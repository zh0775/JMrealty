import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum ReadPath { agree, about }

class ReadMe extends StatelessWidget {
  final String title;
  final String url;
  final ReadPath path;
  const ReadMe({this.title, this.path, this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: title,
      ),
      body: WebView(
        initialUrl: url != null ? url : (WEB_URL + getPath(path)),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  String getPath(ReadPath readPath) {
    if (readPath == null) {
      return '';
    }
    switch (readPath) {
      case ReadPath.agree:
        return 'agree';
        break;
      case ReadPath.about:
        return 'about';
        break;
      default:
        return '';
    }
  }
}
