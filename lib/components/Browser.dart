
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatelessWidget {
  final String url;
  final String title;
  const Browser({Key key,@required this.url, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: jm_appTheme,
        title: Text(title,style: TextStyle(fontSize: 16,color: Colors.white),),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
