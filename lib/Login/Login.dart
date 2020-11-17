import 'dart:async';

import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Login/components/RegistSelectInput.dart';

class Login extends StatefulWidget {
  final bool isLogin;
  const Login({this.isLogin = true});
  @override
  _LoginState createState() => _LoginState();
}

enum CodeButtonState { normal, send, wait }

class _LoginState extends State<Login> {
  TextEditingController phoneCtr; // 登录手机号输入框controller
  TextEditingController codeCtr; // 登录验证码输入框controller
  CodeButtonState codeButtonState; //登录验证码状态枚举
  bool phoneNeedClean; // 登录页手机号输入框清空标记
  int codeNextTime; // 登录页验证码倒计日
  Timer codeTimer; // 登录页验证码按钮倒计时定时器
  Timer sendTimer; // 登录页验证码按钮模拟网络请求定时器
  bool isLogin; // 登录或注册
  Map organData;
  Map servicePointData;
  @override
  void dispose() {
    if (codeTimer != null) {
      codeTimer.cancel();
    }
    if (sendTimer != null) {
      sendTimer.cancel();
    }
    phoneCtr.dispose();
    codeCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    organData = null;
    servicePointData = null;
    phoneCtr = TextEditingController();
    codeCtr = TextEditingController();
    codeButtonState = CodeButtonState.normal;
    phoneNeedClean = false;
    codeNextTime = 60;
    isLogin = widget.isLogin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        // 修复弹出键盘后高度不够报错的bug 套一层SingleChildScrollView
        body: SingleChildScrollView(
      child: isLogin ? loginWidget(context) : registWidget(context),
    ));
  }

  // 登录页 主页面
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
                      getCodeButton(context)
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
                        onPressed: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
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

  // 登录页验证码按钮
  Widget getCodeButton(context) {
    String text;
    Color buttonColor;
    Function pressed;
    if (codeButtonState == CodeButtonState.normal) {
      text = '获取验证码';
      buttonColor = Color(0xff404351);
      pressed = () {
        if (codeButtonState == CodeButtonState.normal) {
          setState(() {
            codeButtonState = CodeButtonState.send;
          });
          sendTimer = Timer(Duration(seconds: 2), () {
            sendCodeRequest();
          });
        }
      };
    } else if (codeButtonState == CodeButtonState.send) {
      text = '获取中...';
      buttonColor = Color.fromRGBO(227, 229, 233, 1);
      pressed = null;
    } else if (codeButtonState == CodeButtonState.wait) {
      text = '重新获取 ' + codeNextTime.toString();
      buttonColor = Color.fromRGBO(227, 229, 233, 1);
      pressed = null;
    }

    return Container(
      width: 100,
      height: 48,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(8))),
      child: TextButton(
        onPressed: pressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // 登录页 验证码输入框
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

  // 登录页 手机号输入框
  Widget phoneInput(context) {
    return Container(
        width: SizeConfig.screenWidth - 80,
        constraints: BoxConstraints(maxHeight: 48),
        child: Stack(
          children: [
            TextField(
                controller: phoneCtr,
                maxLines: 1,
                style: TextStyle(fontSize: 16),
                onChanged: (value) {
                  bool needClear = false;
                  if (value.length > 0) {
                    needClear = true;
                  }
                  if (phoneNeedClean != needClear) {
                    setState(() {
                      phoneNeedClean = needClear;
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  // contentPadding: EdgeInsets.all(20.0),
                  hintText: "请输入手机号",
                  filled: true,
                )),
            phoneNeedClean == true
                ? Positioned(
                    width: 48,
                    height: 48,
                    right: 0,
                    top: 0,
                    child: TextButton(
                        onPressed: () {
                          phoneCtr.clear();
                          setState(() {
                            phoneNeedClean = false;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        )))
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ));
  }

  // 模拟发送验证码网络请求
  void sendCodeRequest() {
    codeNextTime = 60;

    codeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (codeNextTime <= 1) {
        timer.cancel();
        setState(() {
          codeButtonState = CodeButtonState.normal;
        });
      } else {
        setState(() {
          codeButtonState = CodeButtonState.wait;
          codeNextTime--;
        });
      }
    });
  }

  // 注册页主页面
  Widget registWidget(context) {
    List zizhiList = [
      {'id': 1, 'title': '组织1'},
      {'id': 2, 'title': '组织2'},
      {'id': 3, 'title': '组织3'},
      {'id': 4, 'title': '组织4'},
      {'id': 5, 'title': '组织5'}
    ];
    List fuwuList = [
      {'id': 1, 'title': '服务点1'},
      {'id': 2, 'title': '服务点2'},
      {'id': 3, 'title': '服务点3'},
      {'id': 4, 'title': '服务点4'},
      {'id': 5, 'title': '服务点5'}
    ];

    return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        // color: Colors.blue,
        child: Stack(children: [
          Positioned(
              top: 60,
              right: 0,
              child: TextButton(
                  onPressed: () {
                    if (codeTimer != null) {
                      codeTimer.cancel();
                    }
                    if (sendTimer != null) {
                      sendTimer.cancel();
                    }
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
                  // 头像按钮
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 242, 245, 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(50)),
                        child: Stack(
                          overflow: Overflow.clip,
                          children: [
                            Positioned(
                                top: 10,
                                left: 10,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60,
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                )),
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  height: 25,
                                  width: 80,
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  child: Text(
                                    '编辑',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ))
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  // 组织级别选择
                  RegistSelectInput(
                    title: '组织级别',
                    dataList: zizhiList,
                    selectedChange: (value, data) {
                      print('value == $value --- data == $data');
                      organData = {'value': value, 'title': data};
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RegistSelectInput(
                    title: '服务点',
                    dataList: fuwuList,
                    selectedChange: (value, data) {
                      servicePointData = {'value': value, 'title': data};
                    },
                  ),
                ],
              ))
        ]));
  }
}
