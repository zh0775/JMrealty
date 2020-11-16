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
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController codeCtr = TextEditingController();
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
                  SizedBox(height: 50),
                  phoneInput(context),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      authCodeInput(context),
                      Container(
                        width: 100,
                        height: 48,
                        decoration: BoxDecoration(
                            color: Color(0xff404351),
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(8))),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '获取验证码',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: SizeConfig.screenWidth - 80,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Color(0xfff1daaf),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '确认登录',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: SizeConfig.screenWidth - 80 - 200,
                      height: 48,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '注册账号',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff4c4f5c)),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }

  Widget authCodeInput(context) {
    return Container(
      width: SizeConfig.screenWidth - 80 - 100,
      child: TextField(
          controller: codeCtr,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                borderSide: BorderSide.none),
            fillColor: Color.fromRGBO(0, 0, 0, 0.1),
            // contentPadding: EdgeInsets.all(20.0),
            hintText: "验证码",
            filled: true,
          )),
    );
  }

  Widget phoneInput(context) {
    return Container(
      width: SizeConfig.screenWidth - 80,
      decoration: BoxDecoration(),
      child: TextField(
          controller: phoneCtr,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            fillColor: Color.fromRGBO(0, 0, 0, 0.1),
            // contentPadding: EdgeInsets.all(20.0),
            hintText: "请输入手机号",
            filled: true,
          )),
    );
  }

  Widget registWidget(context) {
    return Container();
  }
}
