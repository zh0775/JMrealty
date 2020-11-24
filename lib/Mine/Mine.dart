import 'package:JMrealty/Login/Login.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0), () {
      toLogin(context);
    });
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  void toLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          return Login(
            isLogin: true,
          );
        },
        fullscreenDialog: true));
  }
}
