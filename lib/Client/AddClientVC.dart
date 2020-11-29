import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/Client/viewModel/ClientViewModel.dart';
import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClientVC extends StatefulWidget {
  @override
  _AddClientVCState createState() => _AddClientVCState();
}

class _AddClientVCState extends State<AddClientVC> {
  ClientModel clientModel;
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
    labelStyle = TextStyle(color: jm_text_black, fontSize: 14);
    clientYY = 1;
    clientIsMan = false;
    sensitive = false;
    clientModel = ClientModel();
    ClientViewModel().loadAddSelect();
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
      body: ListView(
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
            clientModel.name = value;
          }, hintText: '请输入客户姓名', must: true),
          // line
          getLine(false),
          // 性别按钮
          lineContent(true, '性别', [
            sexButton(context, true, (sex) {
              setState(() {
                clientIsMan = sex;
              });
            }),
            SizedBox(
              width: 20,
            ),
            sexButton(context, false, (sex) {
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
                    backgroundColor: Colors.transparent,
                    needCleanButton: true,
                    valueChange: (value) {
                      clientModel.clientPhoneNum = value;
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
                      clientYY = 1;
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
                      clientYY = 2;
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
                      clientYY = 3;
                    });
                  }),
            )
          ]),
          // line
          getLine(true, height: 8, color: Color(0xfff0f2f5)),
        ],
      ),
    );
  }

  Widget getInput(String title, Function(String value) valueChange,
      {String hintText = '', bool must = false}) {
    return Align(
      child: Container(
        //注册手机号
        width: SizeConfig.screenWidth - marginSpace * 2,
        height: lineHeight,
        child: Row(
          children: [
            Container(width: labelWidth, child: getlabel(title, must)),
            ZZInput(
              height: lineHeight,
              width: otherWidth,
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
}
