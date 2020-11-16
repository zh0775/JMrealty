import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final bool isLogin;
  const Login({this.isLogin = true});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: widget.isLogin ? loginWidget(context) : registWidget(context));
  }

  Widget loginWidget(context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      // color: Colors.blue,
      child: Stack(
        children: [
          Positioned(
              top: 60,
              right: 0,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 40,
                    color: Color.fromRGBO(65, 68, 83, 1),
                  ))),
          Positioned(
              top: 100,
              bottom: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/tabbar/food-cake.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '登录',
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(65, 68, 83, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: TextField(
                        decoration: InputDecoration(
                      // border: BorderRadius,
                      fillColor: Colors.grey,
                      // contentPadding: EdgeInsets.all(20.0),
                      hintText: "helperText",
                      filled: true,
                    )),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget registWidget(context) {
    return Container();
  }
}
