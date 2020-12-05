import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FollowTrack extends StatefulWidget {
  final String json;
  final bool isFollow;
  FollowTrack({@required this.json, @required this.isFollow});
  @override
  _FollowTrackState createState() => _FollowTrackState();
}

class _FollowTrackState extends State<FollowTrack> {
  WebViewController _controller;
  String url = '';
  String _title;
  @override
  void initState() {
    url = widget.isFollow ? 'followTrack' : 'guideTrack';
    _title = '';
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
        initialUrl: WEB_URL + '/#/' + url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          String js_String = "var json = " +
              "'" +
              widget.json +
              "'" +
              '; ' +
              'setParams(json);';
          print('js_String === $js_String');
          // "var title_1 = 30; var price_1 = 40; var title_2 = 10; var price_2 = 50; setData([{title:title_1,price:price_1},{title:title_2,price:price_2}])";
          _controller?.evaluateJavascript(js_String)?.then((result) {});
        },
        javascriptChannels: <JavascriptChannel>[
          _titleJavascriptChannel(context),
        ].toSet(),
      ),
    );
  }

  JavascriptChannel _titleJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'title',
      onMessageReceived: (JavascriptMessage message) {
        print('title === ${message.message}');
        setState(() {
          _title = message.message;
        });
      },
    );
  }

  back() {
    Navigator.pop(context);
  }
}
