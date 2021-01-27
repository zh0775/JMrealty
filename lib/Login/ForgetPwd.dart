import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/Login/components/ZZSendCodeButton.dart';
import 'package:JMrealty/Login/viewModel/LoginViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomLoginInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';

class ForgetPwd extends StatefulWidget {
  final Function() toLogin;
  const ForgetPwd({this.toLogin});
  @override
  _ForgetPwdState createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  LoginViewModel loginVM = LoginViewModel();
  Map forgetParams = {};
  bool loginEnable = false;
  String confirmPwd = '';
  double widthScale;
  double heightScale;
  double margin;
  double selfWidth;

  @override
  void dispose() {
    loginVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    heightScale = SizeConfig.blockSizeVertical;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: heightScale * 4,
          ),
          Container(
            // color: Colors.red,
            width: SizeConfig.screenWidth,
            height: heightScale * 8,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScale * 2),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: widthScale * 6,
                        ),
                        onPressed: () {
                          setState(() {
                            if (widget.toLogin != null) {
                              widget.toLogin();
                            }
                          });
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '找回密码',
                    style: jm_text_black_bold_style20,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: heightScale * 5,
          ),
          Image.asset(
            'assets/images/home/icon_login.png',
            width: SizeConfig.screenWidth * (134 / 375),
            height: SizeConfig.screenWidth * (114 / 375),
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: heightScale * 3,
          ),
          CustomLoginInput(
            placeholder: '请输入手机号',
            keyboardType: TextInputType.phone,
            needClean: true,
            valueChange: (value) {
              forgetParams['phonenumber'] = value;
              checkLogin();
            },
          ),
          SizedBox(
            height: heightScale * 2,
          ),
          CustomLoginInput(
            hideText: true,
            maxLengs: 18,
            placeholder: '请输入6~18位新密码',
            valueChange: (value) {
              forgetParams['password'] = value;
              checkLogin();
            },
          ),
          SizedBox(
            height: heightScale * 2,
          ),
          CustomLoginInput(
            hideText: true,
            maxLengs: 18,
            placeholder: '请确认密码',
            valueChange: (value) {
              confirmPwd = value;
            },
          ),
          SizedBox(
            height: heightScale * 2,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            //注册验证码
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              authCodeInput(context, SizeConfig.screenWidth - 100 - 80),
              getCodeButton(context)
            ],
          ),
          SizedBox(
            height: heightScale * 3.5,
          ),
          CustomSubmitButton(
            title: '确认',
            enable: loginEnable,
            buttonClick: () {
              if (forgetParams['phonenumber'] == null ||
                  forgetParams['phonenumber'].length == 0) {
                ShowToast.normal('请输入您的手机号');
                return;
              }
              if (forgetParams['password'] == null ||
                  forgetParams['password'].length == 0) {
                ShowToast.normal('请输入密码');
                return;
              }
              if (forgetParams['password'].length < 6) {
                ShowToast.normal('密码小于6位，请重新输入');
                return;
              }
              if (forgetParams['password'].length > 18) {
                ShowToast.normal('密码大于18位，请重新输入');
                return;
              }
              if (confirmPwd == null || confirmPwd.length == 0) {
                ShowToast.normal('请输入确认密码');
                return;
              }
              if (confirmPwd != forgetParams['password']) {
                ShowToast.normal('两次密码输入不一致');
                return;
              }
              if (forgetParams['code'] == null ||
                  forgetParams['code'].length == 0) {
                ShowToast.normal('请输入验证码');
                return;
              }
              CustomLoading().show();
              loginVM.userForgetPwd(forgetParams, (success) {
                CustomLoading().hide();
                if (success) {
                  Future.delayed(Duration(seconds: 1), () {
                    if (widget.toLogin != null) {
                      widget.toLogin();
                    }
                  });
                }
              });
            },
          )
        ],
      ),
    );
  }

  Widget authCodeInput(context, width) {
    return ZZInput(
      key: ValueKey('authCodeInput_forget'),
      width: width,
      height: 48,
      keyboardType: TextInputType.number,
      hintText: '请输入验证码',
      text: forgetParams['code'],
      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
      valueChange: (String value) {
        forgetParams['code'] = value;
      },
    );
  }

  bool isCodeSend = false;
  Widget getCodeButton(context) {
    return ProviderWidget<LoginViewModel>(
      model: LoginViewModel(),
      builder: (context, value, child) {
        if (value.state == BaseState.CONTENT) {
          isCodeSend = true;
        } else if (value.state == BaseState.FAIL || value.state == null) {
          isCodeSend = false;
        }
        return ZZSendCodeButton(
          buttonText: '获取验证码',
          height: 48,
          width: 100,
          sending: isCodeSend,
          codeButtonClick: () {
            String phone = forgetParams['phonenumber'];
            if (!strNoEmpty(phone)) {
              ShowToast.normal('请输入手机号码');
              return;
            }
            if (!isMobilePhoneNumber(phone)) {
              ShowToast.normal('请输入正确的手机号码');
              return;
            }
            CustomLoading().show();
            value.loadPhoneCode(phone);
          },
          codeButtonTimeOver: () {
            setState(() {
              value.state = BaseState.FAIL;
              isCodeSend = false;
            });
          },
        );
      },
    );
  }

  checkLogin() {
    if (forgetParams['phonenumber'] != null &&
        forgetParams['phonenumber'].length >= 10 &&
        forgetParams['password'] != null &&
        forgetParams['password'].length >= 6 &&
        !loginEnable) {
      setState(() {
        loginEnable = true;
      });
    }

    if ((forgetParams['phonenumber'] == null ||
            forgetParams['phonenumber'].length < 10 ||
            forgetParams['password'] == null ||
            forgetParams['password'].length < 6) &&
        loginEnable) {
      setState(() {
        loginEnable = false;
      });
    }
  }
}
