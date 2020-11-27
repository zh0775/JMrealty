import 'dart:async';
import 'dart:io';
import 'package:JMrealty/Login/model/login_model.dart';
import 'package:JMrealty/Login/viewModel/LoginViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Login/components/RegistSelectInput.dart';
import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/Login/components/ZZSendCodeButton.dart';

class Login extends StatefulWidget {
  final bool isLogin;
  const Login({this.isLogin = true});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String headImgPath; // 头像路径
  dynamic headImg;
  String phoneNumString; // 登录手机号
  String codeNumString; //登录验证码
  String registCodeNumString; // 注册验证码
  bool isLoginSend;
  bool isRegistSend;
  bool isLogin; // 登录或注册
  Map organData; // 注册组织级别数据
  Map servicePointData; // 注册服务点数据
  bool registIsMan; // 注册性别
  String registName; // 注册姓名
  String registPhone; // 注册手机号

  SelectImageView imgSelectV; // 选择图片视图

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    imgSelectV = SelectImageView(
      imageSelected: (image) {
        print('image === ${image.runtimeType.toString()}');
        setState(() {
          if (image != null) {
            headImg = File(image.path);
          } else {
            print('No image selected.');
          }
        });
      },
    );
    registIsMan = false;
    isLoginSend = false;
    isRegistSend = false;
    organData = null;
    headImg = null;
    headImgPath = '';
    phoneNumString = '';
    codeNumString = '';
    registCodeNumString = '';
    servicePointData = null;
    isLogin = widget.isLogin;
    super.initState();
  }

  double lineHeight = 50;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        // 修复弹出键盘后高度不够报错的bug 套一层SingleChildScrollView
        body: GestureDetector(
      onTap: () {
        // 收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: isLogin ? loginWidget(context) : registWidget(context),
      ),
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
              // bottom: 100,
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
                      authCodeInput(context, SizeConfig.screenWidth - 80 - 100),
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
                          color: jm_appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ProviderWidget<LoginViewModel>(
                        model: LoginViewModel(),
                        builder: (context, value, child) {
                          return TextButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (!strNoEmpty(phoneNumString)) {
                                ShowToast.normal('请输入您的手机号码');
                                return;
                              }
                              if (!isMobilePhoneNumber(phoneNumString)) {
                                ShowToast.normal('请输入正确的的手机号码');
                                return;
                              }
                              if (!strNoEmpty(codeNumString)) {
                                ShowToast.normal('请输入验证码');
                                return;
                              }
                              value.requestLogin(phoneNumString, codeNumString,
                                  () {
                                ShowToast.normal('登录成功');
                                Future.delayed(Duration(seconds: 1), () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Navigator.pop(context);
                                });
                              });
                            },
                            child: Text(
                              '确认登录',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: SizeConfig.screenWidth - 80 - 200,
                      height: 48,
                      child: TextButton(
                        key: ValueKey('toRegistTextButton'),
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

  // 登录页 注册页 验证码按钮
  Widget getCodeButton(context) {
    return ProviderWidget<LoginViewModel>(
      model: LoginViewModel(),
      builder: (context, value, child) {
        if (value.state == BaseState.CONTENT) {
          isLogin ? isLoginSend = true : isRegistSend = true;
        } else if (value.state == BaseState.FAIL || value.state == null) {
          isLogin ? isLoginSend = false : isRegistSend = false;
        }
        return ZZSendCodeButton(
          buttonText: '发送验证码',
          sending: isLogin ? isLoginSend : isRegistSend,
          codeButtonClick: () {
            String phone = isLogin ? phoneNumString : registPhone;
            if (!strNoEmpty(phone)) {
              ShowToast.normal('请输入手机号码');
              return;
            }
            if (!isMobilePhoneNumber(phone)) {
              ShowToast.normal('请输入正确的手机号码');
              return;
            }
            value.loadPhoneCode(phone);
          },
          codeButtonTimeOver: () {
            setState(() {
              isLogin ? isLoginSend = false : isRegistSend = false;
            });
          },
        );
      },
    );
  }

  // 登录页 注册页 验证码输入框
  Widget authCodeInput(context, width) {
    return ZZInput(
      width: width,
      height: 48,
      hintText: '验证码',
      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
      valueChange: (String value) {
        isLogin ? codeNumString = value : registCodeNumString = value;
      },
    );
  }

  // 登录页 手机号输入框
  Widget phoneInput(context) {
    return ZZInput(
      width: SizeConfig.screenWidth - 80,
      height: 48,
      hintText: '请输入手机号',
      needCleanButton: true,
      valueChange: (String value) {
        // setState(() {
        phoneNumString = value;
        // });
      },
    );
  }

  // 模拟发送验证码网络请求
  void sendCodeRequest() {
    Timer((Duration(milliseconds: 1500)), () {
      setState(() {
        isLogin ? isLoginSend = true : isRegistSend = true;
      });
    });
  }

  // 注册页主页面
  Widget registWidget(context) {
    return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        // color: Colors.blue,
        child: Stack(children: [
          Positioned(
              top: 50,
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
              top: 80,
              // bottom: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // 头像按钮
                  GestureDetector(
                      onTap: () {
                        imgSelectV.showImage(context);
                      },
                      child: headImg != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              child: Image.file(
                                headImg,
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              ),
                            )
                          : selectHead(context)),
                  SizedBox(
                    height: 40,
                  ),
                  // 注册组织级别选择
                  ProviderWidget<LoginViewModel>(
                    model: LoginViewModel(),
                    onReady: (model) {
                      model.loadRegistPostSelectList();
                    },
                    builder: (context, model, child) {
                      return RegistSelectInput(
                        title: '组织级别',
                        dataList: model.postDataList,
                        height: lineHeight,
                        border: Border(
                            top: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2))),
                        selectedChange: (value, data) {
                          // print('value == $value --- data == $data');
                          organData = {'value': value, 'title': data};
                        },
                      );
                    },
                  ),
                  Container(
                    // line
                    width: SizeConfig.screenWidth - 40,
                    height: 0.5,
                    // margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  ),
                  ProviderWidget<LoginViewModel>(
                    model: LoginViewModel(),
                    onReady: (vm) {
                      vm.loadRegistDeptSelectList();
                    },
                    builder: (context, model, child) {
                      return RegistSelectInput(
                          //注册服务点选择
                          title: '服务点',
                          height: lineHeight,
                          dataList: model.depTreeDataList,
                          border: Border.all(style: BorderStyle.none),
                          showTree: true,
                          nodeSelected: (node) {
                            servicePointData = {
                              'value': node.id,
                              'title': node.label
                            };
                          });
                    },
                  ),
                  Container(
                    // line
                    width: SizeConfig.screenWidth - 40,
                    height: 0.5,
                    // margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  ),
                  Container(
                    // 注册姓名
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(left: 20),
                    height: lineHeight,
                    child: Row(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30 - 40,
                          child: Text('姓名'),
                        ),
                        ZZInput(
                          height: lineHeight,
                          width: SizeConfig.blockSizeHorizontal * 70 + 5,
                          backgroundColor: Colors.transparent,
                          needCleanButton: true,
                          valueChange: (value) {
                            registName = value;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    // line
                    width: SizeConfig.screenWidth - 40,
                    height: 0.5,
                    // margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  ),
                  Container(
                    // 注册性别
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(left: 20),
                    height: lineHeight,
                    child: Row(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30 - 20,
                          child: Text('性别'),
                        ),
                        sexButton(context, true),
                        SizedBox(
                          width: 20,
                        ),
                        sexButton(context, false),
                      ],
                    ),
                  ),
                  Container(
                    // line
                    width: SizeConfig.screenWidth - 40,
                    height: 0.5,
                    // margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  ),
                  Container(
                    //注册手机号
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(left: 20),
                    height: lineHeight,
                    child: Row(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30 - 40,
                          child: Text('手机号'),
                        ),
                        ZZInput(
                          height: lineHeight,
                          width: SizeConfig.blockSizeHorizontal * 70 + 5,
                          backgroundColor: Colors.transparent,
                          needCleanButton: true,
                          valueChange: (value) {
                            registPhone = value;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    // line
                    width: SizeConfig.screenWidth - 40,
                    height: 0.5,
                    // margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    //注册验证码
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      authCodeInput(context, SizeConfig.screenWidth - 100 - 40),
                      getCodeButton(context)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      // 提交注册按钮
                      width: SizeConfig.screenWidth - 40,
                      height: 48,
                      decoration: BoxDecoration(
                          color: jm_appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          sendRegist();
                        },
                        child: Text(
                          '提交注册',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )),
                  Container(
                      // 注册回到登录
                      width: SizeConfig.screenWidth - 80 - 150,
                      height: 50,
                      child: TextButton(
                        key: ValueKey('toLoginTextButton'),
                        onPressed: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                        child: Text(
                          '已有帐号？去登录',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff4c4f5c)),
                        ),
                      )),
                ],
              ))
        ]));
  }

  // 性别按钮
  Widget sexButton(BuildContext context, bool sex) {
    double sexButtonHeight = lineHeight * 0.7;
    return Container(
      width: 70,
      height: sexButtonHeight,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Color.fromRGBO(64, 67, 82, 1)),
          color:
              sex == registIsMan ? Color.fromRGBO(64, 67, 82, 1) : Colors.white,
          borderRadius: BorderRadius.circular(sexButtonHeight / 2)),
      child: TextButton(
        onPressed: () {
          if (sex != registIsMan) {
            setState(() {
              registIsMan = sex;
            });
          }
        },
        child: Text(
          sex ? '男' : '女',
          style: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 16,
              color: sex != registIsMan
                  ? Color.fromRGBO(64, 67, 82, 1)
                  : Colors.white),
        ),
      ),
    );
  }

  Widget selectHead(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 242, 245, 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
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
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ))
            ],
          ),
        ));
  }

  requestRegist(RegistModel model) {
    Map<String, dynamic> params = {
      'deptId': model.deptId,
      'nickName': model.nickName,
      'sex': model.sex,
      'phonenumber': model.phonenumber,
      'position': model.position,
      'code': model.code
    };
    if (model.avatar != null) {
      params['avatar'] = model.avatar;
    }

    Http().post(
      Urls.userRegister,
      params,
      success: (json) {
        if (json['code'] == 200) {
          ShowToast.normal('注册成功');
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              isLogin = true;
            });
          });
        }
        print('userRegister-success === $json');
      },
      fail: (reason, code) {
        print('userRegister-fail === $reason --- code === $code');
      },
      after: () {},
    );
  }

  void sendRegist() {
    RegistModel model = RegistModel();
    if (organData == null || organData.isEmpty || organData['value'] == null) {
      ShowToast.normal('请选择组织级别');
      return;
    }
    model.position = organData['value'];
    if (servicePointData == null ||
        servicePointData.isEmpty ||
        servicePointData['value'] == null) {
      ShowToast.normal('请选择服务点');
      return;
    }
    model.deptId = servicePointData['value'];
    if (!strNoEmpty(registName)) {
      ShowToast.normal('请输入您的姓名');
      return;
    }
    model.nickName = registName;
    if (!strNoEmpty(registPhone)) {
      ShowToast.normal('请输入您的手机号码');
      return;
    }
    if (!isMobilePhoneNumber(registPhone)) {
      ShowToast.normal('请输入正确的的手机号码');
      return;
    }
    model.phonenumber = registPhone;
    if (!strNoEmpty(registCodeNumString)) {
      ShowToast.normal('请输入验证码');
      return;
    }
    model.code = registCodeNumString;
    model.sex = registIsMan ? 1 : 2;
    requestRegist(model);
  }
}
