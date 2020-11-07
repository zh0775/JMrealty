import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('金慕'), centerTitle: true, actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.mail,
          ),
          tooltip: '搜索',
          onPressed: clickMessage,
        ),
      ]),
    );
  }

  int count = 0;
  void clickMessage() {
    print('messageClick${count++}');
  }
}
