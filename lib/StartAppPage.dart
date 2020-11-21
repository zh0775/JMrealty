import 'package:JMrealty/const/Routes.dart';
import 'package:flutter/material.dart';

class StartAppPage extends StatefulWidget {
  @override
  _StartAppPageState createState() => _StartAppPageState();
}

class _StartAppPageState extends State<StartAppPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(Routes.main_page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}
