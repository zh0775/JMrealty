import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Follow extends StatefulWidget {
  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  WebViewController _controller;
  String _title;
  @override
  void initState() {
    _title = '跟进记录';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        title: Text(
          _title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
        icon: Icon(
          Icons.navigate_before,
          size: 40,
          color: Colors.white,
        ),
        onPressed: () {
          back();
        },
    )),
      body: WebView(
        initialUrl: 'http://192.168.1.108:8081/#/followProgress',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          String js_String = "var title_1 = 30; var price_1 = 40; var title_2 = 10; var price_2 = 50; setData([{title:title_1,price:price_1},{title:title_2,price:price_2}])";
          _controller?.evaluateJavascript(js_String)?.then((result){});
        },
        javascriptChannels: <JavascriptChannel>[
          _alertJavascriptChannel(context),
        ].toSet(),
      ),
    );
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toast',
      onMessageReceived: (JavascriptMessage message) {
      });
  }

  back () {
    Navigator.pop(context);
  }
}
