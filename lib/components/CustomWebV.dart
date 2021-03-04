import 'dart:async';

import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;

enum WebPath {
  statisticsMain, // 统计 deptId
  follow, // 未开单
  lowPer, // 低绩效
  breakingRate, //破壳率 deptId
  summary, // 每日总结 deptId
  followProgress, // 跟进进度 deptId
  projectInfo, // 项目详情 projectId
  rankingList, // 榜单
  backlog, //待办事项
  agree,
  searchUser,
}

class CustomWebV extends StatefulWidget {
  final WebPath path;
  final Map otherParams;
  final bool isMultiple;
  final String date;
  final Function(List searchDataList) returnSearchList;
  const CustomWebV(
      {@required this.path,
      this.otherParams,
      this.date,
      this.returnSearchList,
      this.isMultiple = true});
  @override
  _CustomWebVState createState() => _CustomWebVState();
}

class _CustomWebVState extends State<CustomWebV> {
  EventBus _bus = EventBus();
  WebViewController _controller;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    // print('bottom ==== ${MediaQuery.of(ctx).viewInsets.bottom}');
    print('url == ${WEB_URL + getPath(widget.path)}');
    return widget.path == WebPath.searchUser
        ? Scaffold(
            appBar: CustomAppbar(
              title: '搜索用户',
            ),
            body: FutureBuilder<Widget>(
              future: getView(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return snapshot.data;
                  } else {
                    return EmptyView(
                      tips: '出现错误',
                    );
                  }
                } else {
                  return EmptyView(
                    tips: '请稍等',
                  );
                }
              },
            ))
        : FutureBuilder<Widget>(
            future: getView(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return EmptyView(
                    tips: '出现错误',
                  );
                }
              } else {
                return EmptyView(
                  tips: '请稍等',
                );
              }
            },
          );

    // Scaffold(
    //     appBar: widget.path == WebPath.searchUser
    //         ? CustomAppbar(
    //             title: '搜索用户',
    //           )
    //         : PreferredSize(child: NoneV(), preferredSize: Size.zero),
    //     body: FutureBuilder<Widget>(
    //       future: getView(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           if (snapshot.hasData) {
    //             return snapshot.data;
    //           } else {
    //             return EmptyView(
    //               tips: '出现错误',
    //             );
    //           }
    //         } else {
    //           return EmptyView(
    //             tips: '请稍等',
    //           );
    //         }
    //       },
    //     ));
  }

  Future<Widget> getView() async {
    String token = await UserDefault.get(ACCESS_TOKEN);
    String userInfo = await UserDefault.get(USERINFO);
    Map info = convert.jsonDecode(userInfo);

    if (token != null && token.length > 0) {
      return WebView(
        initialUrl: WEB_URL + getPath(widget.path),
        // initialUrl: 'https://www.bilibili.com/',
        javascriptMode: JavascriptMode.unrestricted,

        onWebViewCreated: (controller) {
          // _controller.complete(controller);
          _controller = controller;
        },
        // ClampingScrollPhysics(),
        onPageFinished: (url) {
          Map params = Map<String, dynamic>.from(
              {'token': token, 'deptId': info['deptId']});

          if (widget.otherParams != null && widget.otherParams.isNotEmpty) {
            params = {...params, ...widget.otherParams};
          }
          if (widget.path == WebPath.searchUser) {
            params['multiple'] = widget.isMultiple;
          }
          if (widget.path == WebPath.backlog && widget.date != null) {
            params['date'] = widget.date;
          }
          String json = convert.jsonEncode(params);
          // String js_String = "let json = " +
          //     "'" +
          //     json +
          //     "'" +
          //     '; ' +
          //     'getDataFromNative(json);';
          String jsString = "getDataFromNative('$json');";
          print('js_String === $jsString');
          // Future.delayed(Duration(seconds: 1), () {
          // _controller.future.then((value) {
          //   value?.evaluateJavascript(jsString)?.then((result) {
          //     print('result ==== $result');
          //   });
          // });
          // });
          _controller?.evaluateJavascript(jsString);
        },
        navigationDelegate: (NavigationRequest request) {
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   print('blocking navigation to $request}');
          //   return NavigationDecision.prevent;
          // }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },

        onWebResourceError: (error) {
          print('web_view_error == $error');
        },
        javascriptChannels: <JavascriptChannel>[
          _getJavascriptChannel(context),
          _backJavascriptChannel(context),
          _searchListJavascriptChannel(context),
          _callPhoneNumJavascriptChannel(context),
          _copyStrJavascriptChannel(context)
        ].toSet(),
      );
    } else {
      return EmptyView(
        tips: '请重新登录',
      );
    }
  }

  JavascriptChannel _backJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "back",
        onMessageReceived: (JavascriptMessage message) {
          print('back === ${message.message}');
          // backStatus = message.message;
          if (widget.path == WebPath.backlog) {
            _bus.emit(NOTIFY_LOGIN_SUCCESS);
          }
          back();
        });
  }

  JavascriptChannel _callPhoneNumJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "callPhoneNum",
        onMessageReceived: (JavascriptMessage message) {
          print('callPhoneNum === ${message.message}');
          callPhone(message.message);
        });
  }

  JavascriptChannel _copyStrJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "copyStr",
        onMessageReceived: (JavascriptMessage message) {
          print('copyStr === ${message.message}');
          // callPhone(message.message);
          Clipboard.setData(ClipboardData(text: message.message));
        });
  }

  JavascriptChannel _searchListJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "returnList",
        onMessageReceived: (JavascriptMessage message) {
          print('returnList === ${message.message}');
          if (widget.returnSearchList != null) {
            widget.returnSearchList(convert.jsonDecode(message.message));
          }
          // backStatus = message.message;
          // back();
        });
  }

  JavascriptChannel _getJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "get",
        onMessageReceived: (JavascriptMessage message) {
          print('get === ${message.message}');
          // if (widget.path == WebPath.summary) {
          //   if (int.parse(message.message) < 0) {
          //     // print(double.parse(message.message));
          //     _controller.future.then((ctr) {
          //       ctr.getScrollX().then((x) {
          //         ctr.scrollTo(x, int.parse(message.message));
          //       });
          //     });
          //   }
          // }
          // back();
        });
  }

  back() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  String getPath(WebPath webPath) {
    if (webPath == null) {
      return '';
    }
    switch (webPath) {
      case WebPath.statisticsMain:
        return 'statisticsMain';
        break;
      case WebPath.follow:
        return 'follow';
        break;
      case WebPath.lowPer:
        return 'lowPer';
        break;
      case WebPath.breakingRate:
        return 'breakingRate';
        break;
      case WebPath.summary:
        return 'summary';
        break;
      case WebPath.followProgress:
        return 'followProgress';
        break;
      case WebPath.projectInfo:
        return 'projectInfo';
        break;
      case WebPath.rankingList:
        return 'rankingList';
        break;
      case WebPath.backlog:
        return 'backlog';
        break;
      case WebPath.agree:
        return 'agree';
        break;
      case WebPath.searchUser:
        return 'searchUser';
      default:
        return '';
    }
  }
}
