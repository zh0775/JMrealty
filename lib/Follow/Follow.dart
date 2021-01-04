import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;

class Follow extends StatefulWidget {
  final String token;
  final int deptId;
  Follow({@required this.token, @required this.deptId});
  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  String backStatus;
  WebViewController _controller;
  String _title;
  @override
  void initState() {
    backStatus = 'follow';
    // print('widget.token === ${widget.token}');
    // print('widget.deptId === ${widget.deptId}');
    _title = '跟进记录';
    super.initState();
  }

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
        initialUrl: WEB_URL + '/followProgress',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          String json = convert
              .jsonEncode({'token': widget.token, 'deptId': widget.deptId});
          String js_String =
              "var json = " + "'" + json + "'" + '; ' + 'setParams(json);';
          print('js_String === $js_String');
          // "var title_1 = 30; var price_1 = 40; var title_2 = 10; var price_2 = 50; setData([{title:title_1,price:price_1},{title:title_2,price:price_2}])";
          _controller?.evaluateJavascript(js_String)?.then((result) {});
        },
        javascriptChannels: <JavascriptChannel>[
          _titleJavascriptChannel(context),
          _clgJavascriptChannel(context),
          _backJavascriptChannel(context)
        ].toSet(),
      ),
    );
  }

  JavascriptChannel _titleJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'currentTitle',
      onMessageReceived: (JavascriptMessage message) {
        print('title === ${message.message}');
        setState(() {
          _title = message.message;
        });
      },
    );
  }

  JavascriptChannel _clgJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "clg",
        onMessageReceived: (JavascriptMessage message) {
          print('clg === ${message.message}');
        });
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

  back() {
    Navigator.pop(context);
  }
}
