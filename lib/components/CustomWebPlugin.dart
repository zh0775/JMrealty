import 'dart:async';

import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:convert' as convert;

enum WebPaths {
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
}

class CustomWebPlugin extends StatefulWidget {
  final WebPaths path;
  final Map otherParams;
  const CustomWebPlugin({@required this.path, this.otherParams});
  @override
  _CustomWebPluginState createState() => _CustomWebPluginState();
}

class _CustomWebPluginState extends State<CustomWebPlugin> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  @override
  void initState() {
    _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        getJs().then((value) {
          flutterWebviewPlugin.evalJavascript(value);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: WebviewScaffold(
        resizeToAvoidBottomInset: true,
        url: WEB_URL + getPath(widget.path),
        mediaPlaybackRequiresUserGesture: false,
        javascriptChannels: [
          _getJavascriptChannel(context),
          _backJavascriptChannel(context)
        ].toSet(),
        withJavascript: true,
      ),
    );
  }

  JavascriptChannel _backJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "back",
        onMessageReceived: (JavascriptMessage message) {
          print('back === ${message.message}');
          // backStatus = message.message;
          back();
        });
  }

  JavascriptChannel _getJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "get",
        onMessageReceived: (JavascriptMessage message) {
          print('get === ${message.message}');

          // backStatus = message.message;
          // back();
        });
  }

  back() {
    Navigator.pop(context);
  }

  Future<String> getJs() async {
    String token = await UserDefault.get(ACCESS_TOKEN);
    String userInfo = await UserDefault.get(USERINFO);
    Map info = convert.jsonDecode(userInfo);

    if (token != null && token.length > 0) {
      Map params =
          Map<String, dynamic>.from({'token': token, 'deptId': info['deptId']});

      if (widget.otherParams != null && widget.otherParams.isNotEmpty) {
        params = {...params, ...widget.otherParams};
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
      return jsString;
    }
    return '';
  }

  String getPath(WebPaths webPath) {
    if (webPath == null) {
      return '';
    }
    switch (webPath) {
      case WebPaths.statisticsMain:
        return 'statisticsMain';
        break;
      case WebPaths.follow:
        return 'follow';
        break;
      case WebPaths.lowPer:
        return 'lowPer';
        break;
      case WebPaths.breakingRate:
        return 'breakingRate';
        break;
      case WebPaths.summary:
        return 'summary';
        break;
      case WebPaths.followProgress:
        return 'followProgress';
        break;
      case WebPaths.projectInfo:
        return 'projectInfo';
        break;
      case WebPaths.rankingList:
        return 'rankingList';
        break;
      case WebPaths.backlog:
        return 'backlog';
        break;
      case WebPaths.agree:
        return 'agree';
        break;
      default:
        return '';
    }
  }
}
