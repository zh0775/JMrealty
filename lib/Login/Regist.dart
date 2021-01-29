import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/Login/viewModel/LoginViewModel.dart';
import 'package:JMrealty/Login/viewModel/RegistViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/components/DepSelectView.dart';
import 'package:JMrealty/components/DropdownSelectV.dart';
import 'package:JMrealty/components/ReadMe.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:intl/intl.dart';
import 'components/ZZSendCodeButton.dart';

class Regist extends StatefulWidget {
  final Function() toLogin;
  const Regist({this.toLogin});
  @override
  _RegistState createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  TextEditingController phoneTextCtr = TextEditingController();
  RegistViewModel registVM = RegistViewModel();
  SelectImageView imgSelectV; // 选择图片视图
  ReportUploadViewModel uploadImaVM = ReportUploadViewModel();
  LoginViewModel loginVM = LoginViewModel();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  dynamic headImgPath;
  double widthScale;
  double heightScale;
  double margin;
  double selfWidth;
  List<TreeNode> depList;
  List positionList;
  bool agree = false;
  String phoneStr = '';
  String name = '';
  String avatar = '';
  Map post = {};
  String date = '';
  Sex sex = Sex.boy;
  TreeNode dep;
  String pwd = '';
  String confirmPwd = '';
  String sendCode = '';

  @override
  void initState() {
    imgSelectV = SelectImageView(
      count: 1,
      imageSelected: (images) {
        if (images != null && images.length > 0 && mounted) {
          setState(() {
            headImgPath = images[0];
            avatar = null;
          });
          // ReportUploadViewModel().upLoadReportImages(images,
          //     callBack: (List strImages) {
          //   if (strImages != null && strImages.length > 0) {
          //     setState(() {
          //       headImgPath = strImages[0];
          //     });
          //   }
          // if (addImages != null) {
          //   addImages(strImages);
          // }
          // });
        }
      },
    );
    CustomLoading().show();
    loginVM.loadRegistPostSelectList(
      success: (success, postList) {
        CustomLoading().hide();
        if (success && mounted) {
          setState(() {
            positionList = postList;
            post = positionList.length > 0 ? positionList[0] : 0;
          });
        }
      },
    );

    CustomLoading().show();
    loginVM.loadRegistDeptSelectList(
      success: (value) {
        CustomLoading().hide();
        if (value != null && mounted) {
          setState(() {
            depList = value;
          });
        }
      },
    );
    super.initState();
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
                    '注册',
                    style: jm_text_black_bold_style20,
                  ),
                )
              ],
            ),
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: widthScale * 3,
          //     ),
          //     IconButton(
          //         icon: Icon(
          //           Icons.arrow_back_ios,
          //           size: widthScale * 6,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             if (widget.toLogin != null) {
          //               widget.toLogin();
          //             }
          //           });
          //         }),
          //   ],
          // ),
          SizedBox(
            height: heightScale * 1,
          ),
          getHeadView(),
          SizedBox(
            height: heightScale * 3,
          ),
          JMline(
            width: SizeConfig.screenWidth,
            height: 1,
          ),
          CustomTextF(
            labelText: '选择部门',
            placeholder: '请选择部门',
            must: true,
            onlyTap: true,
            text: dep != null ? dep.label : '',
            labelClick: () {
              push(
                  DepSelectView(
                    treeData: depList ?? [],
                    singleSelect: true,
                    nodeSelected: (node) {
                      if (mounted) {
                        setState(() {
                          dep = node;
                        });
                      }
                    },
                  ),
                  context);
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          DropdownSelectV(
            titleKey: 'title',
            valueKey: 'value',
            dataList: positionList ?? [],
            defalultValue: true,
            labelText: '选择职位',
            must: true,
            textPadding: EdgeInsets.only(left: 10),
            valueChange: (value, data) {
              post = data;
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          CustomTextF(
            labelText: '入职日期',
            placeholder: '请选择日期',
            onlyTap: true,
            must: true,
            text: date ?? '',
            labelClick: () {
              showDatePick();
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          CustomTextF(
            labelText: '姓名',
            placeholder: '请输入姓名',
            must: true,
            text: name ?? '',
            valueChange: (value) {
              name = value;
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          SexCell(
            // sex: sex ?? Sex.boy,
            title: ' 性别',
            // must: true,
            labelStyle: jm_text_black_bold_style15,
            labelWidth: widthScale * 26,
            valueChange: (newSex) {
              sex = newSex;
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: margin),
                child: CustomTextF(
                  labelText: '手机号',
                  placeholder: '请输入手机号',
                  // text: phoneStr ?? '',
                  width: widthScale * 80,
                  controller: phoneTextCtr,
                  must: true,
                  keyboardType: TextInputType.number,
                  valueChange: (value) {
                    phoneStr = value;
                  },
                ),
              ),
              IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.cancel,
                    color: Color(0xff636366),
                    size: widthScale * 4.5,
                  ),
                  onPressed: () {
                    phoneTextCtr.clear();
                  })
            ],
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          CustomTextF(
            labelText: '密码',
            placeholder: '请输入6~18位密码',
            hideText: true,
            text: pwd ?? '',
            must: true,
            valueChange: (value) {
              pwd = value;
            },
          ),
          JMline(
            width: selfWidth,
            height: 1,
          ),
          CustomTextF(
            labelText: '确认密码',
            placeholder: '确认密码',
            must: true,
            hideText: true,
            text: confirmPwd ?? '',
            valueChange: (value) {
              confirmPwd = value;
            },
          ),
          SizedBox(
            height: 5,
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
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: jm_appTheme,
                  value: agree,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        agree = value;
                      });
                    }
                  }),
              Text(
                '已阅读并同意',
                style: jm_text_black_style14,
              ),
              GestureDetector(
                onTap: () {
                  push(
                      ReadMe(
                        path: ReadPath.agree,
                        title: '隐私协议',
                      ),
                      context);
                },
                child: Text(
                  '隐私协议',
                  style: jm_text_apptheme_style14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            title: '提交注册',
            style: TextStyle(fontSize: 16, color: Colors.white),
            height: 50,
            buttonClick: () {
              if (dep == null || dep.id == null) {
                ShowToast.normal('请选择您的部门');
                return;
              }
              if (post == null || post['value'] == null) {
                ShowToast.normal('请选择您的职位');
                return;
              }
              if (date == null || date.length == 0) {
                ShowToast.normal('请选择您的入职日期');
                return;
              }
              if (name == null || name.length == 0) {
                ShowToast.normal('请输入您的姓名');
                return;
              }

              if (phoneStr == null || phoneStr.length == 0) {
                ShowToast.normal('请输入您的手机号');
                return;
              }
              if (pwd == null || pwd.length == 0) {
                ShowToast.normal('请输入密码');
                return;
              }
              if (pwd.length < 6) {
                ShowToast.normal('密码小于6位，请重新输入');
                return;
              }
              if (pwd.length > 18) {
                ShowToast.normal('密码大于18位，请重新输入');
                return;
              }
              if (confirmPwd == null || confirmPwd.length == 0) {
                ShowToast.normal('请输入确认密码');
                return;
              }
              if (confirmPwd != pwd) {
                ShowToast.normal('两次密码输入不一致');
                return;
              }
              if (sendCode == null || sendCode.length == 0) {
                ShowToast.normal('请输入验证码');
                return;
              }
              if (!agree) {
                ShowToast.normal('请阅读并同意《隐私政策》');
                return;
              }
              CustomLoading().show();
              Map params = Map<String, dynamic>.from({
                'deptId': dep.id,
                'position': post['value'],
                'nickName': name,
                'sex': sex == Sex.boy ? '0' : '1',
                'phonenumber': phoneStr,
                'password': pwd,
                'joinDate': date,
                'code': sendCode,
              });
              if (headImgPath != null &&
                  (avatar == null || avatar.length == 0)) {
                uploadImaVM.upLoadReportImages(
                  [headImgPath],
                  callBack: (strImg) {
                    if (strImg != null && strImg.length > 0) {
                      avatar = strImg[0];
                      params['avatar'] = avatar;
                      regist(params);
                    }
                  },
                );
              } else {
                if (avatar != null && avatar.length > 0) {
                  params['avatar'] = avatar;
                }
                regist(params);
              }
            },
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  regist(params) {
    print('regist--params === $params');
    registVM.userRegist(params, (success) {
      CustomLoading().hide();
      if (success) {
        ShowToast.normal('注册成功');
        if (widget.toLogin != null) {
          Future.delayed(Duration(seconds: 1), () {
            widget.toLogin();
          });
        }
      }
    });
  }

  getHeadView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            imgSelectV.showImage(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widthScale * 10),
            child: SizedBox(
              width: widthScale * 20,
              height: widthScale * 20,
              child: Stack(
                children: [
                  headImgPath != null
                      ? Image(
                          image: AssetThumbImageProvider(headImgPath,
                              height: (widthScale * 20).round(),
                              width: (widthScale * 20).round()),
                          fit: BoxFit.fill,
                        )
                      : Positioned.fill(
                          child: Image.asset(
                              'assets/images/icon/icon_default_head.png')),
                  Positioned(
                    left: 0,
                    right: 0,
                    height: widthScale * 7,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      child: Text(
                        '编辑',
                        style: jm_text_black_bold_style12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget authCodeInput(context, width) {
    return ZZInput(
      key: ValueKey('authCodeInput_regist'),
      width: width,
      height: 48,
      keyboardType: TextInputType.number,
      hintText: '请输入验证码',
      text: sendCode,
      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
      valueChange: (String value) {
        sendCode = value;
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
          sending: isCodeSend,
          codeButtonClick: () {
            String phone = phoneStr;
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

  Future<void> showDatePick() async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2300, 1),
        locale: Locale('zh'));
    if (dateTime == null) return;
    setState(() {
      date = dateFormat.format(dateTime);
    });
  }
}
