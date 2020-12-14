import 'package:JMrealty/PK/viewModel/PKviewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PKadd extends StatefulWidget {
  @override
  _PKaddState createState() => _PKaddState();
}

class _PKaddState extends State<PKadd> {
  double widthScale;
  double margin;
  double selfWidth;
  double outMargin;
  double lineHeight;
  DateTime startTime;
  DateTime endTime;
  DateFormat dateFormat;
  List unitList; // pk指标
  List pkTargetList; // 参与单位
  String pkName; // pk赛名称
  String award; // 奖励
  String rules; // 规则
  @override
  void initState() {
    unitList = [];
    pkTargetList = [];
    dateFormat = DateFormat('yyyy-MM-dd');
    startTime = DateTime.now();
    endTime = startTime.add(Duration(days: 7));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    outMargin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    lineHeight = 50;
    return Scaffold(
      appBar: CustomAppbar(title: '新建PK赛'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 40,
                  ),
                  Text(
                    'PK赛信息',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              JMline(width: SizeConfig.screenWidth, height: 0.5),
              CustomInput(
                title: 'PK赛名称',
                hintText: '请输入',
                text: pkName ?? '',
                valueChange: (value) {
                  pkName = value;
                },
              ),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '开始时间', start: true),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '结束时间', start: false),
              JMline(width: selfWidth, height: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                      Text(
                        '参与单位',
                        style: jm_text_black_style15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...getUnitList(),
                          RawMaterialButton(
                              key: ValueKey('addUnit_button'),
                              constraints: BoxConstraints(
                                  maxHeight: lineHeight, maxWidth: 50),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                    color: jm_appTheme,
                                  ),
                                  Text(
                                    '添加',
                                    style: jm_text_apptheme_style13,
                                  )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  unitList.add({'name': '123'});
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                    ],
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                      Text(
                        'PK赛指标',
                        style: jm_text_black_style15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...getTargetList(),
                          RawMaterialButton(
                              key: ValueKey('addTarget_button'),
                              constraints: BoxConstraints(
                                  maxHeight: lineHeight, maxWidth: 50),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                    color: jm_appTheme,
                                  ),
                                  Text(
                                    '添加',
                                    style: jm_text_apptheme_style13,
                                  )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  pkTargetList.add({'name': '123'});
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                    ],
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 30,
                  ),
                  Text(
                    'PK赛奖励',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              CustomMarkInput(
                valueChange: (value) {
                  award = value;
                },
              ),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 30,
                  ),
                  Text(
                    'PK赛规则',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              CustomMarkInput(
                valueChange: (value) {
                  rules = value;
                },
              ),
              // JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 20,
              ),
              CustomSubmitButton(buttonClick: () {}),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDateWidget({@required String title, bool start = true}) {
    double labelWidth = widthScale * 22;
    return Row(
      children: [
        SizedBox(
          width: margin,
          height: lineHeight,
        ),
        Container(
          width: labelWidth,
          child: Text(
            title,
            style: jm_text_black_style15,
          ),
        ),
        Container(
          width: selfWidth - labelWidth - widthScale * 8,
          child: Text(
            dateFormat.format(start ? startTime : endTime),
            style: jm_text_black_style15,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_right,
          size: widthScale * 8,
        )
      ],
    );
  }

  showDatePick(DateTime dateTime) async {
    dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018, 1),
        lastDate: DateTime(2022, 1),
        builder: (BuildContext context, Widget child) {
          return Theme(
            child: Container(),
            data: null,
          );
        });
    setState(() {});
  }

  List<Widget> getUnitList() {
    double buttonHeight = lineHeight * 0.5;
    List<Widget> units = [];
    for (Map item in unitList) {
      units.add(SizedBox(
        height: 6,
      ));
      units.add(RawMaterialButton(
        onPressed: () {
          deleteUnit(item);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints:
            BoxConstraints(minHeight: buttonHeight, minWidth: widthScale * 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonHeight / 2),
          side: BorderSide(color: jm_line_color, width: 0.5),
        ),
        child: Container(
          width: widthScale * 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item['name'] ?? '',
                  style: jm_text_black_style13,
                ),
              ),
              Icon(
                Icons.cancel,
                size: buttonHeight * 0.9,
                color: jm_line_color,
              ),
            ],
          ),
        ),
      ));
    }
    return units;
  }

  List<Widget> getTargetList() {
    double buttonHeight = lineHeight * 0.5;
    List<Widget> targets = [];
    for (Map item in pkTargetList) {
      targets.add(SizedBox(
        height: 6,
      ));
      targets.add(RawMaterialButton(
        onPressed: () {
          deleteTarget(item);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints:
            BoxConstraints(minHeight: buttonHeight, minWidth: widthScale * 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonHeight / 2),
          side: BorderSide(color: jm_line_color, width: 0.5),
        ),
        child: Container(
          width: widthScale * 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item['name'] ?? '',
                  style: jm_text_black_style13,
                ),
              ),
              Icon(
                Icons.cancel,
                size: buttonHeight * 0.9,
                color: jm_line_color,
              ),
            ],
          ),
        ),
      ));
    }
    return targets;
  }

  void deleteUnit(Map item) {
    if (item != null) {
      setState(() {
        unitList.remove(item);
      });
    }
  }

  void deleteTarget(Map item) {
    if (item != null) {
      setState(() {
        pkTargetList.remove(item);
      });
    }
  }
}
