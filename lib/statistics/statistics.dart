import 'package:JMrealty/services/http_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;

class Statistics extends StatefulWidget {
  final String token;
  const Statistics({@required this.token});
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     backgroundColor: jm_appTheme,
      //     automaticallyImplyLeading: false,
      //     title: Text(
      //       _title,
      //       style: TextStyle(color: Colors.white, fontSize: 18),
      //     ),
      //     leading: IconButton(
      //       icon: Icon(
      //         Icons.navigate_before,
      //         size: 40,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         if (backStatus == 'follow') {
      //           back();
      //         } else if (backStatus == 'followDetail') {
      //           _controller.goBack();
      //         }
      //       },
      //     )),
      body: WebView(
        initialUrl: WEB_URL + '/statisticsMain',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          String json = convert.jsonEncode({'token': widget.token});
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
}
