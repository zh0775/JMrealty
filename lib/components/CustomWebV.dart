import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;

enum WebPath { statisticsMain }

class CustomWebV extends StatefulWidget {
  final WebPath path;
  const CustomWebV({@required this.path});
  @override
  _CustomWebVState createState() => _CustomWebVState();
}

class _CustomWebVState extends State<CustomWebV> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
      ),
    );
  }

  Future<Widget> getView() async {
    String token = await UserDefault.get(ACCESS_TOKEN);
    if (token != null && token.length > 0) {
      return SafeArea(
        child: WebView(
          initialUrl: WEB_URL + '/' + getPath(widget.path),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            String json = convert.jsonEncode({'token': token});
            String js_String = "let json = " +
                "'" +
                json +
                "'" +
                '; ' +
                'getDataFromNative(json);';
            print('js_String === $js_String');
            // "var title_1 = 30; var price_1 = 40; var title_2 = 10; var price_2 = 50; setData([{title:title_1,price:price_1},{title:title_2,price:price_2}])";
            _controller?.evaluateJavascript(js_String)?.then((result) {});
          },
          javascriptChannels: <JavascriptChannel>[
            _getJavascriptChannel(context),
            _backJavascriptChannel(context)
          ].toSet(),
        ),
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

  String getPath(WebPath webPath) {
    if (webPath == null) {
      return '';
    }
    switch (webPath) {
      case WebPath.statisticsMain:
        return 'statisticsMain';
        break;
      default:
        return '';
    }
  }
}
