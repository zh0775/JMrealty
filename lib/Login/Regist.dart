import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/Login/viewModel/LoginViewModel.dart';
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
          Row(
            children: [
              SizedBox(
                width: widthScale * 3,
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: widthScale * 8,
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.toLogin != null) {
                        widget.toLogin();
                      }
                    });
                  })
            ],
          ),
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
          CustomTextF(
            labelText: '姓名',
            placeholder: '请输入姓名',
            must: true,
            text: name ?? '',
            valueChange: (value) {
              name = value;
            },
          ),
          SexCell(
            sex: sex ?? Sex.boy,
            title: '性别',
            must: true,
            labelWidth: widthScale * 26,
            valueChange: (newSex) {
              sex = newSex;
            },
          ),
          CustomTextF(
            labelText: '手机号',
            placeholder: '请输入手机号',
            text: phoneStr ?? '',
            must: true,
            keyboardType: TextInputType.phone,
            valueChange: (value) {
              phoneStr = value;
            },
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
                  '隐私政策',
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
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
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
      hintText: '验证码',
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
          buttonText: '发送验证码',
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
