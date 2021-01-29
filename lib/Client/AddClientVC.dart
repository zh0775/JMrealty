// import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/Client/viewModel/ClientViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/components/DropdownSelectV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:easy_contact_picker/easy_contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:permission_handler/permission_handler.dart';

class AddClientVC extends StatefulWidget {
  @override
  _AddClientVCState createState() => _AddClientVCState();
}

class _AddClientVCState extends State<AddClientVC> {
  EventBus _bus = EventBus();
  final EasyContactPicker _contactPicker = new EasyContactPicker();
  ReportViewModel projectVM = ReportViewModel();
  bool firstBuild = true;
  // ClientModel clientModel = ClientModel();
  String housesName;
  Map<String, dynamic> addClientParams = {};
  bool clientIsMan = true; // 是否男士
  Sex clientSex = Sex.boy;
  bool sensitive = false; //是否脱敏
  double otherWidth;
  double labelWidth;
  double lineHeight = 50;
  double marginSpace;
  double widthScale;
  TextStyle labelStyle = jm_text_black_bold_style16;
  TextStyle titleStyle = jm_text_black_bold_style20;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    projectVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    marginSpace = widthScale * 6;
    labelWidth = widthScale * 22;
    otherWidth = (SizeConfig.screenWidth - marginSpace * 2) - labelWidth;
    return Scaffold(
      appBar: CustomAppbar(
        title: '录入客源',
      ),
      body: ProviderWidget<ClientViewModel>(
        model: ClientViewModel(),
        onReady: (model) {
          model.loadAddSelect();
        },
        builder: (ctx, model, child) {
          if (firstBuild && model.state == BaseState.CONTENT) {
            // if (model.listData['sex'] != null &&
            //     model.listData['sex'] is List &&
            //     model.listData['sex'].length > 1) {
            addClientParams['sex'] = 0;
            // print('sex === ${addClientParams['sex']}');
            //       ? ((model.listData['sex'])[0])['value']
            //       : ((model.listData['sex'])[1])['value'];
            // }
            if (model.listData['sensitive'] != null &&
                model.listData['sensitive'] is List &&
                model.listData['sensitive'].length > 1) {
              addClientParams['isSensitive'] = sensitive
                  ? ((model.listData['sensitive'])[0])['value']
                  : ((model.listData['sensitive'])[1])['value'];
            }
            if (model.listData['desireGrade'] != null &&
                model.listData['desireGrade'] is List &&
                model.listData['desireGrade'].length > 0) {
              addClientParams['desireId'] =
                  ((model.listData['desireGrade'])[0])['value'];
            }

            if (model.listData['customersOccupation'] != null &&
                model.listData['customersOccupation'] is List &&
                model.listData['customersOccupation'].length > 0) {
              addClientParams['occupationId'] =
                  ((model.listData['customersOccupation'])[0])['value'];
              addClientParams['occupation'] =
                  ((model.listData['customersOccupation'])[0])['title'];
            }
            if (model.listData['intentionProductType'] != null &&
                model.listData['intentionProductType'] is List &&
                model.listData['intentionProductType'].length > 0) {
              addClientParams['typeId'] =
                  ((model.listData['intentionProductType'])[0])['value'];
              addClientParams['type'] =
                  ((model.listData['intentionProductType'])[0])['title'];
            }

            if (model.listData['intentionArea'] != null &&
                model.listData['intentionArea'] is List &&
                model.listData['intentionArea'].length > 0) {
              addClientParams['areaId'] =
                  ((model.listData['intentionArea'])[0])['value'];
              addClientParams['area'] =
                  ((model.listData['intentionArea'])[0])['title'];
            }
            if (model.listData['decisionMaker'] != null &&
                model.listData['decisionMaker'] is List &&
                model.listData['decisionMaker'].length > 0) {
              addClientParams['policymakerId'] =
                  ((model.listData['decisionMaker'])[0])['value'];
              addClientParams['policymaker'] =
                  ((model.listData['decisionMaker'])[0])['title'];
            }

            if (model.listData['customersOfSource'] != null &&
                model.listData['customersOfSource'] is List &&
                model.listData['customersOfSource'].length > 0) {
              addClientParams['sourceId'] =
                  ((model.listData['customersOfSource'])[0])['value'];
              addClientParams['source'] =
                  ((model.listData['customersOfSource'])[0])['title'];
            }

            addClientParams['shopTimes'] = 1;
            firstBuild = false;
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // title 通讯录导入
                  Container(
                    height: lineHeight,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: marginSpace),
                          child: Text(
                            '基本信息',
                            style: titleStyle,
                          ),
                        ),
                        Container(
                            width: widthScale * 30,
                            height: lineHeight,
                            margin: EdgeInsets.only(right: marginSpace),
                            child: RawMaterialButton(
                              highlightElevation: 0,
                              elevation: 0,
                              onPressed: () {
                                // 通讯录导入
                                _requestPermission();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.class_,
                                    size: 15,
                                    color: jm_appTheme,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '通讯录导入',
                                    style: TextStyle(
                                        fontSize: 14, color: jm_text_black),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  // line
                  getLine(true),
                  // 客户姓名
                  CustomTextF(
                    text: addClientParams['name'] ?? '',
                    bottomLine: true,
                    labelText: '姓名',
                    placeholder: '请输入客户姓名',
                    labelStyle: labelStyle,
                    must: true,
                    valueChange: (value) {
                      addClientParams['name'] = value;
                    },
                  ),
                  // getInput('姓名', (value) {
                  //   addClientParams['name'] = value;
                  // }, hintText: '请输入客户姓名', must: true),
                  // // line
                  // getLine(false),
                  // 性别按钮
                  SexCell(
                    title: '性别',
                    labelStyle: labelStyle,
                    must: true,
                    labelWidth: widthScale * 26,
                    sex: Sex.boy,
                    valueChange: (newSex) {
                      addClientParams['sex'] = (newSex == Sex.boy ? 0 : 1);
                      // clientSex = newSex;
                    },
                  ),

                  // lineContent(true, '性别', [
                  //   sexButton(context, true, (sex) {
                  //     if (model.listData['sex'] != null &&
                  //         model.listData['sex'] is List &&
                  //         model.listData['sex'].length > 1) {
                  //       addClientParams['sex'] =
                  //           ((model.listData['sex'])[0])['value'];
                  //     }
                  //     setState(() {
                  //       clientIsMan = sex;
                  //     });
                  //   }),
                  //   SizedBox(
                  //     width: 20,
                  //   ),
                  //   sexButton(context, false, (sex) {
                  //     if (model.listData['sex'] != null &&
                  //         model.listData['sex'] is List &&
                  //         model.listData['sex'].length > 1) {
                  //       addClientParams['sex'] =
                  //           ((model.listData['sex'])[1])['value'];
                  //     }
                  //     setState(() {
                  //       clientIsMan = sex;
                  //     });
                  //   })
                  // ]),
                  // line
                  getLine(false),
                  lineContent(true, '手机号', [
                    Container(
                      width: otherWidth,
                      height: lineHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('前三尾四录入'),
                          SizedBox(
                            width: widthScale * 3,
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: CupertinoSwitch(
                                activeColor: jm_appTheme,
                                value: sensitive,
                                onChanged: (bool value) {
                                  if (model.listData['sensitive'] != null &&
                                      model.listData['sensitive'] is List &&
                                      model.listData['sensitive'].length > 1) {
                                    addClientParams['isSensitive'] = sensitive
                                        ? ((model
                                            .listData['sensitive'])[0])['value']
                                        : ((model.listData['sensitive'])[1])[
                                            'value'];
                                  }
                                  setState(() {
                                    sensitive = value;
                                  });
                                }),
                          )
                        ],
                      ),
                    )
                  ]),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 0),
                  //   child: Text(
                  //     '不可更改，将作为核查带看依据',
                  //     style: TextStyle(fontSize: 12, color: jm_text_gray),
                  //   ),
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: marginSpace + widthScale * 2,
                      ),
                      Text(
                        '不可更改，将作为核查带看依据',
                        style: TextStyle(fontSize: 12, color: jm_text_gray),
                      ),
                    ],
                  ),
                  // 客户手机号
                  CustomTextF(
                    text: addClientParams['phone'] ?? '',
                    placeholder: '请输入手机号',
                    keyboardType: TextInputType.number,
                    valueChange: (value) {
                      addClientParams['phone'] = value;
                    },
                  ),
                  getLine(false),

                  DropdownSelectV(
                    labelText: '客户意愿',
                    must: true,
                    labelStyle: labelStyle,
                    // defalultValue: true,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['desireId'] ?? '',
                    dataList: model.listData['desireGrade'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['desireId'] = data['value'] ?? '';
                      });
                    },
                  ),
                  // line
                  getLine(true, height: 8, color: Color(0xfff0f2f5)),
                  // 客户职业
                  DropdownSelectV(
                    labelText: '客户职业',
                    labelStyle: labelStyle,
                    // defalultValue: true,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['occupationId'] ?? '',
                    dataList: model.listData['customersOccupation'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['occupationId'] = value ?? 0;
                        addClientParams['occupation'] = data['title'] ?? '';
                      });
                    },
                  ),
                  // line
                  getLine(false),
                  // 用途
                  DropdownSelectV(
                    labelText: '用途',
                    labelStyle: labelStyle,
                    // defalultValue: true,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['typeId'] ?? '',
                    dataList: model.listData['intentionProductType'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['typeId'] = value ?? 0;
                        addClientParams['type'] = data['title'] ?? '';
                      });
                    },
                  ),
                  // line
                  getLine(false),
                  // 意向面积
                  DropdownSelectV(
                    labelText: '意向面积',
                    // defalultValue: true,
                    labelStyle: labelStyle,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['areaId'] ?? '',
                    dataList: model.listData['intentionArea'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['areaId'] = value ?? 0;
                        addClientParams['area'] = data['title'] ?? '';
                      });
                    },
                  ),

                  // line
                  getLine(false),
                  // 几次置业
                  DropdownSelectV(
                    labelText: '几次置业',
                    labelStyle: labelStyle,
                    defalultValue: true,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['shopTimes'],
                    dataList: [
                      {'value': 1, 'title': '1次'},
                      {'value': 2, 'title': '2次'},
                      {'value': 3, 'title': '3次'},
                      {'value': 4, 'title': '4次'},
                      {'value': 5, 'title': '5次'},
                      {'value': 6, 'title': '多次'},
                    ],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['shopTimes'] = value;
                      });
                    },
                  ),
                  // line
                  getLine(false),
                  // 意向楼层
                  CustomTextF(
                    labelStyle: labelStyle,
                    labelText: '意向楼层',
                    placeholder: '请输入意向楼层',
                    text: addClientParams['floor'] ?? '',
                    // keyboardType: TextInputType.number,
                    valueChange: (value) {
                      addClientParams['floor'] = value;
                    },
                  ),
                  // line
                  getLine(false),
                  // 决策人
                  DropdownSelectV(
                    labelText: '决策人',
                    labelStyle: labelStyle,
                    // defalultValue: true,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['policymakerId'] ?? '',
                    dataList: model.listData['decisionMaker'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['policymakerId'] = value ?? 0;
                        addClientParams['policymaker'] = data['title'] ?? '';
                      });
                    },
                  ),
                  // line
                  getLine(false),
                  // 首付预算
                  CustomInput(
                    lastLabelText: '万',
                    title: '首付预算',
                    labelStyle: labelStyle,
                    keyboardType: TextInputType.number,
                    hintText: '请输入首付预算',
                    text: addClientParams['paymentsBudget'] ?? '',
                    labelWidth: widthScale * 24,
                    valueChange: (value) {
                      addClientParams['paymentsBudget'] = value;
                    },
                  ),
                  // CustomTextF(
                  //   labelText: '首付预算',
                  //   placeholder: '请输入首付预算',
                  //   text: addClientParams['paymentsBudget'] ?? '',
                  //   // keyboardType: TextInputType.number,
                  //   valueChange: (value) {
                  //     addClientParams['paymentsBudget'] = value;
                  //   },
                  // ),
                  // line
                  getLine(false),
                  // 看房时间
                  CustomTextF(
                    labelText: '看房时间',
                    labelStyle: labelStyle,
                    placeholder: '请输入看房时间',
                    text: addClientParams['seeTime'] ?? '',
                    // keyboardType: TextInputType.number,
                    valueChange: (value) {
                      addClientParams['seeTime'] = value;
                    },
                  ),
                  // line
                  getLine(false),
                  // 客户来源
                  DropdownSelectV(
                    labelText: '客户来源',
                    // defalultValue: true,
                    labelStyle: labelStyle,
                    textPadding: EdgeInsets.only(left: 10),
                    currentValue: addClientParams['sourceId'] ?? '',
                    dataList: model.listData['customersOfSource'] ?? [],
                    valueChange: (value, data) {
                      setState(() {
                        addClientParams['sourceId'] = value ?? 0;
                        addClientParams['source'] = data['title'] ?? '';
                      });
                    },
                  ),
                  // line
                  getLine(false),
                  // 意向楼盘
                  CustomInput(
                    labelWidth: widthScale * 24,
                    title: '意向楼盘',
                    labelStyle: labelStyle,
                    text: housesName ?? '',
                    hintText: '请输入楼盘名称',
                    searchUrl: Urls.projectFuzzySearch,
                    // valueChangeAndShowList: (value, state) {
                    //   housesName = value;
                    //   if (housesName != null && housesName.length > 0) {
                    //     projectVM.loadProjectList(
                    //       housesName,
                    //       success: (data, success, total) {
                    //         if (success) {
                    //           if (data != null && data.length > 0) {
                    //             state.showList(data);
                    //           }
                    //         }
                    //       },
                    //     );
                    //   }
                    // },
                    showListClick: (data) {
                      if (addClientParams['customerProject'] == null) {
                        addClientParams['customerProject'] = [];
                      }
                      bool isHave = false;
                      (addClientParams['customerProject'] as List)
                          .forEach((element) {
                        if (data['id'] == element['id']) {
                          isHave = true;
                        }
                      });

                      if (!isHave) {
                        setState(() {
                          (addClientParams['customerProject'] as List).add({
                            'id': data['id'],
                            'projectId': data['id'],
                            'projectName': data['name'],
                          });
                        });
                      } else {
                        ShowToast.normal('已经选择该楼盘');
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [...getProjects()],
                      ),
                      SizedBox(
                        width: marginSpace,
                      )
                    ],
                  ),
                  // getInput('意向楼盘', (value) {
                  //   // print('意向楼盘 value === $value');
                  //   addClientParams['region'] = value;
                  // }, hintText: '请输入客户意向楼盘'),
                  // line
                  getLine(false),
                  // 特殊要求
                  Container(
                    height: lineHeight,
                    margin: EdgeInsets.only(left: marginSpace),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '特殊要求',
                      style: labelStyle,
                    ),
                  ),
                  CustomMarkInput(
                    text: addClientParams['remarks'] ?? '',
                    maxLength: 200,
                    valueChange: (value) {
                      addClientParams['remarks'] = value;
                    },
                  ),
                  // 客源录入合规告知书
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   height: lineHeight * 0.6,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: RichText(
                  //         text: TextSpan(
                  //             text: '请保护用户隐私，确保遵守',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Color.fromRGBO(133, 133, 134, 1)),
                  //             children: <TextSpan>[
                  //           TextSpan(
                  //             text: '《客源录入合规告知书》',
                  //             style: TextStyle(fontSize: 12, color: Colors.red),
                  //           )
                  //         ])),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomSubmitButton(
                    buttonClick: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      CustomAlert(title: '提示', content: '是否确认提交？').show(
                          confirmClick: () {
                        UserDefault.get(USERINFO).then((value) {
                          Map userInfo = convert.jsonDecode(value);
                          addClientParams['employeeId'] = userInfo['userId'];
                          model.sendAddClientRequest(addClientParams,
                              (bool success) {
                            if (success) {
                              _bus.emit(NOTIFY_CLIENT_LIST_REFRASH_NORMAL);
                              ShowToast.normal('提交成功');
                              Future.delayed(Duration(seconds: 1), () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              });

                              ClientListViewModel clVM = ClientListViewModel();
                              clVM.loadClientList(
                                {'status': 0},
                                success: (data, total) {
                                  _bus.emit(NOTIFY_CLIENTWAIT_COUNT, total);
                                },
                              );
                            }
                          });
                        });
                      });
                      // sendRegist();
                    },
                  ),
                  // Align(
                  //   child: Container(
                  //       // 提交注册按钮
                  //       width: SizeConfig.screenWidth - marginSpace * 2,
                  //       height: lineHeight,
                  //       margin: EdgeInsets.only(bottom: 50),
                  //       decoration: BoxDecoration(
                  //           color: jm_appTheme,
                  //           borderRadius: BorderRadius.all(Radius.circular(8))),
                  //       child: TextButton(
                  //         onPressed: () {

                  //         },
                  //         child: Text(
                  //           '提交',
                  //           style: TextStyle(fontSize: 15, color: Colors.white),
                  //         ),
                  //       )),
                  // ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _requestPermission() async {
    print('通讯录导入');
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      await [
        Permission.contacts,
      ].request();
    } else {
      Contact contact = await _contactPicker.selectContactWithNative();
      setState(() {
        addClientParams['phone'] =
            contact.phoneNumber != null ? stringTrim(contact.phoneNumber) : '';
        addClientParams['name'] = contact.fullName ?? '';
      });
    }

    if (status.isGranted) {
      Contact contact = await _contactPicker.selectContactWithNative();
      setState(() {
        print('contact === ${contact.phoneNumber}');
        addClientParams['phone'] =
            contact.phoneNumber != null ? stringTrim(contact.phoneNumber) : '';
        addClientParams['name'] = contact.fullName ?? '';
      });
    }
  }

  Widget getLine(bool full, {double height = 1, Color color = jm_line_color}) {
    return Align(
      child: Container(
        width: full
            ? SizeConfig.screenWidth
            : SizeConfig.screenWidth - marginSpace * 2,
        height: height,
        color: color,
      ),
    );
  }

  // 性别按钮
  Widget sexButton(
      BuildContext context, bool sex, Function(bool valueChange) valueChange) {
    double sexButtonHeight = lineHeight * 0.7;
    return Align(
      child: Container(
        width: 70,
        height: sexButtonHeight,
        decoration: BoxDecoration(
            border:
                Border.all(width: 0.5, color: Color.fromRGBO(64, 67, 82, 1)),
            color: sex == clientIsMan
                ? Color.fromRGBO(64, 67, 82, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(sexButtonHeight / 2)),
        child: TextButton(
          onPressed: () {
            if (sex != clientIsMan) {
              valueChange(sex);
            }
          },
          child: Text(
            sex ? '男' : '女',
            style: TextStyle(
                textBaseline: TextBaseline.alphabetic,
                fontSize: 16,
                color: sex != clientIsMan
                    ? Color.fromRGBO(64, 67, 82, 1)
                    : Colors.white),
          ),
        ),
      ),
    );
  }

  // form title
  Widget getlabel(String title, bool must) {
    Widget textWidget;
    if (must) {
      textWidget = RichText(
        text: TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontSize: 14),
            children: <TextSpan>[TextSpan(text: title, style: labelStyle)]),
      );
    } else {
      textWidget = Text(
        title,
        style: labelStyle,
      );
    }
    return textWidget;
  }

  // 手机输入 是否脱敏
  Widget getPhoneSwitch() {
    return Align(
      child: Container(
        width: SizeConfig.screenWidth - marginSpace * 2,
        height: lineHeight,
      ),
    );
  }

  Widget lineContent(bool must, String title, List<Widget> widgets) {
    return Align(
        child: Container(
      width: SizeConfig.screenWidth - marginSpace * 2,
      height: lineHeight,
      child: Row(
        children: [
          Container(
            width: labelWidth,
            child: getlabel(title, must),
          ),
          ...widgets,
        ],
      ),
    ));
  }

  List<Widget> getProjects() {
    double buttonHeight = 35;
    List<Widget> list = [];
    if (addClientParams['customerProject'] != null &&
        (addClientParams['customerProject'] is List)) {
      List projectList = addClientParams['customerProject'];
      for (var i = 0; i < projectList.length; i++) {
        Map data = projectList[i];
        list.add(SizedBox(
          height: 6,
        ));
        list.add(RawMaterialButton(
          onPressed: () {
            deleteProject(i);
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          constraints: BoxConstraints(
              minHeight: buttonHeight, minWidth: widthScale * 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonHeight / 2),
            side: BorderSide(color: jm_line_color, width: 0.5),
          ),
          child: Container(
            width: widthScale * 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: widthScale * 4),
                  child: Text(
                    // node.label ?? '',
                    data['projectName'] ?? '',
                    style: jm_text_black_style14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: widthScale * 1),
                  child: Icon(
                    Icons.cancel,
                    size: buttonHeight * 0.9,
                    color: jm_line_color,
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      list.add(SizedBox(
        height: 15,
      ));
    }
    return list;
  }

  void deleteProject(int index) {
    if (addClientParams['customerProject'] != null &&
        (addClientParams['customerProject'] is List)) {
      setState(() {
        (addClientParams['customerProject'] as List).removeAt(index);
      });
    }
  }
}
