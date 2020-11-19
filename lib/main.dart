import 'package:flutter/material.dart';
import 'Home/Home.dart';
import 'package:JMrealty/const/Default.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeBodyWidget(), theme: ThemeData(primaryColor: jm_appTheme));
  }
}
