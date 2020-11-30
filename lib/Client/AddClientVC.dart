import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/Client/viewModel/ClientViewModel.dart';
import 'package:JMrealty/Login/components/RegistSelectInput.dart';
import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClientVC extends StatefulWidget {
  @override
  _AddClientVCState createState() => _AddClientVCState();
}

class _AddClientVCState extends State<AddClientVC> {
  bool firstBuild;
  ClientModel clientModel;
  Map<String, dynamic> addClientParams;
  bool clientIsMan; // 是否男士
  bool sensitive; //是否脱敏
  int clientYY; //客户意愿星级
  double otherWidth;
  double labelWidth;
  double lineHeight = 50;
  double marginSpace;
  double widthScale;
  TextStyle labelStyle;
  @override
  void initState() {
    firstBuild = true;
    labelStyle = TextStyle(color: jm_text_black, fontSize: 14);
    clientYY = 1;
    clientIsMan = false;
    sensitive = false;
    clientModel = ClientModel();
    addClientParams = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    marginSpace = widthScale * 6;
    labelWidth = widthScale * 22;
    otherWidth = (SizeConfig.screenWidth - marginSpace * 2) - labelWidth;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '录入客源',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: ProviderWidget<ClientViewModel>(
        model: ClientViewModel(),
        onReady: (model) {
          model.loadAddSelect();
        },
        builder: (ctx, model, child) {
          if (firstBuild && model.state == BaseState.CONTENT) {
            if (model.listData['sex'] != null && model.listData['sex'] is List && model.listData['sex'].length > 1) {
              addClientParams['sex'] =
              clientIsMan ? ((model.listData['sex'])[0])['value'] :
              ((model.listData['sex'])[1])['value'];
            }
            if (model.listData['sensitive'] != null && model.listData['sensitive'] is List && model.listData['sensitive'].length > 1) {
              addClientParams['isSensitive'] = sensitive ?  ((model.listData['sensitive'])[0])['value'] : ((model.listData['sensitive'])[1])['value'];
            }
            if (model.listData['desireGrade'] != null && model.listData['desireGrade'] is List && model.listData['desireGrade'].length > 2) {
              switch (clientYY) {
                case 1:
                  addClientParams['desireId'] = ((model.listData['desireGrade'])[2])['value'];
                  break;
                case 2:
                  addClientParams['desireId'] = ((model.listData['desireGrade'])[1])['value'];
                  break;
                case 3:
                  addClientParams['desireId'] = ((model.listData['desireGrade'])[0])['value'];
                  break;
              }
            }

            firstBuild = false;
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
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
                          style: TextStyle(
                              color: jm_text_black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                                  style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                getInput('姓名', (value) {
                  addClientParams['name'] = value;
                }, hintText: '请输入客户姓名', must: true),
                // line
                getLine(false),
                // 性别按钮
                lineContent(true, '性别', [
                  sexButton(context, true, (sex) {
                    if (model.listData['sex'] != null && model.listData['sex'] is List && model.listData['sex'].length > 1) {
                      addClientParams['sex'] = ((model.listData['sex'])[0])['value'];
                    }
                    setState(() {
                      clientIsMan = sex;
                    });
                  }),
                  SizedBox(
                    width: 20,
                  ),
                  sexButton(context, false, (sex) {
                    if (model.listData['sex'] != null && model.listData['sex'] is List && model.listData['sex'].length > 1) {
                      addClientParams['sex'] = ((model.listData['sex'])[1])['value'];
                    }
                    setState(() {
                      clientIsMan = sex;
                    });
                  })
                ]),
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
                        CupertinoSwitch(
                            value: sensitive,
                            onChanged: (bool value) {
                              if (model.listData['sensitive'] != null && model.listData['sensitive'] is List && model.listData['sensitive'].length > 1) {
                                addClientParams['isSensitive'] = sensitive ?  ((model.listData['sensitive'])[0])['value'] : ((model.listData['sensitive'])[1])['value'];
                              }
                              setState(() {
                                sensitive = value;
                              });
                            })
                      ],
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.only(left: marginSpace),
                  child: Text(
                    '不可更改，将作为核查带看依据',
                    style: TextStyle(fontSize: 12, color: jm_text_gray),
                  ),
                ),
                // 手机号输入
                Align(
                  child: Container(
                    width: SizeConfig.screenWidth - marginSpace * 2,
                    height: lineHeight,
                    child: Row(
                      children: [
                        Container(
                            width: labelWidth,
                            height: lineHeight,
                            child: RawMaterialButton(
                              highlightElevation: 0,
                              elevation: 0,
                              onPressed: () {
                                // 通讯录导入
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 15,
                                    color: jm_text_black,
                                  ),
                                  // SizedBox(
                                  //   width: 6,
                                  // ),
                                  Text(
                                    '+86',
                                    style:
                                    TextStyle(fontSize: 14, color: jm_text_black),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: jm_text_gray,
                                  ),
                                ],
                              ),
                            )),
                        ZZInput(
                          height: lineHeight,
                          width: otherWidth,
                          leftPadding: 0,
                          keyboardType: TextInputType.phone,
                          backgroundColor: Colors.transparent,
                          needCleanButton: true,
                          valueChange: (value) {
                            addClientParams['phone'] = value;
                            // clientModel.clientPhoneNum = value;
                          },
                          hintText: '客户手机号',
                        )
                      ],
                    ),
                  ),
                ),
                getLine(false),
                // 客户意愿
                lineContent(true, '客户意愿', [
                  Container(
                    width: lineHeight * 0.7,
                    height: lineHeight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.grade,
                          color: clientYY >= 1 ? jm_appTheme : jm_text_gray,
                          size: lineHeight * 0.5,
                        ),
                        onPressed: () {
                          setState(() {
                            setClientYY(1, model);
                            // clientYY = 1;
                          });
                        }),
                  ),
                  Container(
                    width: lineHeight * 0.7,
                    height: lineHeight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.grade,
                          color: clientYY >= 2 ? jm_appTheme : jm_text_gray,
                          size: lineHeight * 0.5,
                        ),
                        onPressed: () {
                          setState(() {
                            setClientYY(2, model);
                            // clientYY = 2;
                          });
                        }),
                  ),
                  Container(
                    width: lineHeight * 0.7,
                    height: lineHeight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.grade,
                          color: clientYY >= 3 ? jm_appTheme : jm_text_gray,
                          size: lineHeight * 0.5,
                        ),
                        onPressed: () {
                          setState(() {
                            setClientYY(3, model);
                            // clientYY = 3;
                          });
                        }),
                  )
                ]),
                // line
                getLine(true, height: 8, color: Color(0xfff0f2f5)),
                // 客户职业
                getSelect('客户职业', (model.state == BaseState.CONTENT && model.listData['customersOccupation'] != null) ? model.listData['customersOccupation'] : [], (value, data) {
                  // print('客户职业 value == $value --- data == $data');
                  addClientParams['occupationId'] = value;
                  addClientParams['occupation'] = data;
                }),
                // line
                getLine(false),
                // 用途
                getSelect('用途', (model.state == BaseState.CONTENT && model.listData['intentionProductType'] != null) ? model.listData['intentionProductType'] : [], (value, data) {
                  // print('用途 value == $value --- data == $data');
                  addClientParams['typeId'] = value;
                  addClientParams['type'] = data;
                }),
                // line
                getLine(false),
                // 意向面积
                getSelect('意向面积', (model.state == BaseState.CONTENT && model.listData['intentionArea'] != null) ? model.listData['intentionArea'] : [], (value, data) {
                  // print('意向面积 value == $value --- data == $data');
                  addClientParams['areaId'] = value;
                  addClientParams['area'] = data;
                }),
                // line
                getLine(false),
                // 意向面积
                getInput('几次置业', (value) {
                  // print('几次置业 value === $value');
                  addClientParams['shopTimes'] = value;
                },hintText: '几次置业',keyboardType: TextInputType.number),
                // line
                getLine(false),
                // 意向楼层
                getInput('意向楼层', (value) {
                  // print('意向楼层 value === $value');
                  addClientParams['floor'] = value;
                },hintText: '意向楼层',keyboardType: TextInputType.number),
                // line
                getLine(false),
                // 决策人
                getSelect('决策人', (model.state == BaseState.CONTENT && model.listData['decisionMaker'] != null) ? model.listData['decisionMaker'] : [], (value, data) {
                  // print('决策人 value == $value --- data == $data');
                  addClientParams['policymakerId'] = value;
                  addClientParams['policymaker'] = data;
                }),
                // line
                getLine(false),
                // 首付预算
                getInput('首付预算·万', (value) {
                  print('首付预算 value === $value');
                },hintText: '请输入首付预算',keyboardType: TextInputType.number),
                // line
                getLine(false),
                // 看房时间
                getInput('看房时间', (value) {
                  // print('看房时间 value === $value');
                  addClientParams['seeTime'] = value;
                },hintText: '请输入看房时间'),
                // line
                getLine(false),
                // 客户来源
                getSelect('客户来源', (model.state == BaseState.CONTENT && model.listData['customersOfSource'] != null) ? model.listData['customersOfSource'] : [], (value, data) {
                  // print('客户来源 value == $value --- data == $data');
                  addClientParams['sourceId'] = value;
                  addClientParams['source'] = data;
                }),
                // line
                getLine(false),
                // 意向楼盘
                getInput('意向楼盘', (value) {
                  // print('意向楼盘 value === $value');
                  addClientParams['region'] = value;
                },hintText: '请输入客户意向楼盘'),
                // line
                getLine(false),
                // 特殊要求
                Container(
                  height: lineHeight,
                  margin: EdgeInsets.only(left: marginSpace),
                  alignment: Alignment.centerLeft,
                  child: Text('特殊要求',style: labelStyle,),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 90,
                    minHeight: 90
                  ),
                  width: SizeConfig.screenWidth - marginSpace * 2,
                  padding: EdgeInsets.fromLTRB(marginSpace, 10, marginSpace, 10),
                  child: TextField(
                    maxLines: 10,
                    minLines: 3,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      fillColor: Color.fromRGBO(247,248,251, 1),
                      // contentPadding: EdgeInsets.all(20.0),
                      hintText: '请输入',
                      filled: true,
                    ),
                    onChanged: (value) {
                      // print('特殊要求 value === $value');
                      addClientParams['remarks'] = value;
                    },
                  ),
                ),
                // 客源录入合规告知书
                Container(
                  width: SizeConfig.screenWidth,
                  height: lineHeight * 0.6,
                  child: TextButton(onPressed: (){},
                    child: RichText(
                        text:TextSpan(text:'请保护用户隐私，确保遵守',
                            style: TextStyle(fontSize: 12,color: Color.fromRGBO(133,133,134, 1)),
                            children: <TextSpan>[
                              TextSpan(
                                text: '《客源录入合规告知书》',
                                style: TextStyle(fontSize: 12,color: Colors.red),
                              )
                              ])),
                  ),
                ),
                Align(
                  child: Container(
                    // 提交注册按钮
                      width: SizeConfig.screenWidth - marginSpace * 2,
                      height: lineHeight,
                      margin: EdgeInsets.only(bottom: 50),
                      decoration: BoxDecoration(
                          color: jm_appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          // sendRegist();
                          model.sendAddClientRequest(addClientParams, (bool success) {
                            if (success) {
                              Future.delayed(Duration(seconds: 1),() {
                                Navigator.pop(context);
                              });
                            }
                          });
                        },
                        child: Text(
                          '提交注册',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getInput(String title, Function(String value) valueChange,
      {String hintText = '', bool must = false,TextInputType keyboardType = TextInputType.text}) {
    return Align(
      child: Container(
        width: SizeConfig.screenWidth - marginSpace * 2,
        height: lineHeight,
        child: Row(
          children: [
            Container(width: labelWidth, child: getlabel(title, must)),
            ZZInput(
              leftPadding: 0,
              height: lineHeight,
              width: otherWidth,
              keyboardType: keyboardType,
              backgroundColor: Colors.transparent,
              needCleanButton: true,
              valueChange: valueChange,
              hintText: hintText,
            )
          ],
        ),
      ),
    );
  }

  Widget getLine(bool full,
      {double height = 0.5, Color color = jm_line_color}) {
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

  Widget getSelect (String title,List dataList, Function(int value,dynamic data) selectValueChange) {
    return Padding(
      padding: EdgeInsets.only(left: marginSpace),
      child: RegistSelectInput(
        title: title,
        width: SizeConfig.screenWidth - marginSpace * 2,
        labelWidth: labelWidth,
        dataList: dataList,
        hintText: '请选择' + title,
        height: lineHeight,
        border: Border.all(color: Colors.transparent, width: 0.0),
        selectedChange: selectValueChange,
      ),
    );
  }
  void setClientYY (int value, ClientViewModel model) {
    clientYY = value;
    if (model.state == BaseState.CONTENT && model.listData['desireGrade'] != null && model.listData['desireGrade'] is List && model.listData['desireGrade'].length > 0) {
      // addClientParams['desireId'] = ((model.listData['desireGrade'])[value - 1])['value'];
      switch (clientYY) {
        case 1:
          addClientParams['desireId'] = ((model.listData['desireGrade'])[2])['value'];
          break;
        case 2:
          addClientParams['desireId'] = ((model.listData['desireGrade'])[1])['value'];
          break;
        case 3:
          addClientParams['desireId'] = ((model.listData['desireGrade'])[0])['value'];
          break;
      }
    }
  }
}
