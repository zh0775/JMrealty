import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetTargetView extends StatefulWidget {
  @override
  _SetTargetViewState createState() => _SetTargetViewState();
}

class _SetTargetViewState extends State<SetTargetView> {
  double margin;
  double widthScale;
  String monthTarget = '';
  String monthCount = '';
  @override
  Widget build(BuildContext context) {
    int currentMonth = DateTime.now().month;
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: '设置目标',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 6),
              Align(
                child: Container(
                  width: SizeConfig.screenWidth - margin * 2,
                  // color: Colors.red,
                  child: Text(
                    currentMonth.toString() + '月目标业绩',
                    style: jm_text_black_bold_style15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: SizeConfig.screenWidth - margin * 2,
                  constraints: BoxConstraints(
                      minWidth: SizeConfig.screenWidth - margin * 2,
                      minHeight: 40),
                  child: CupertinoTextField(
                    textAlignVertical: TextAlignVertical.center,
                    padding: EdgeInsets.only(left: widthScale * 3),
                    keyboardType: TextInputType.number,
                    placeholder: '请输入目标业绩金额',
                    controller:
                        TextEditingController.fromValue(TextEditingValue(
                      text: monthTarget ?? '',
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: monthTarget.length ?? 0)),
                    )),
                    onChanged: (value) {
                      monthTarget = value;
                    },
                  )),
              getPreSet(true),
              SizedBox(
                height: 10,
              ),
              Align(
                child: Container(
                  width: SizeConfig.screenWidth - margin * 2,
                  // color: Colors.red,
                  child: Text(
                    currentMonth.toString() + '月目标业绩',
                    style: jm_text_black_bold_style15,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                  width: SizeConfig.screenWidth - margin * 2,
                  constraints: BoxConstraints(
                      minWidth: SizeConfig.screenWidth - margin * 2,
                      minHeight: 40),
                  child: CupertinoTextField(
                    textAlignVertical: TextAlignVertical.center,
                    padding: EdgeInsets.only(left: widthScale * 3),
                    keyboardType: TextInputType.number,
                    placeholder: '请输入目标成交套数',
                    controller:
                        TextEditingController.fromValue(TextEditingValue(
                      text: monthCount ?? '',
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: monthCount.length ?? 0)),
                    )),
                    onChanged: (value) {
                      monthCount = value;
                    },
                  )),
              getPreSet(false),
              // CustomInput()
              SizedBox(
                height: SizeConfig.blockSizeVertical * 30,
              ),
              CustomSubmitButton(
                title: '保存',
                height: SizeConfig.blockSizeVertical * 6.5,
                buttonClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPreSet(bool isTarget) {
    String str = '建议目标';
    if (isTarget) {
      str += '业绩为' + 5000.toString() + '元';
    } else {
      str += '成交套数为' + 2.toString() + '套';
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: SizeConfig.screenWidth - margin * 2,
      decoration: BoxDecoration(
        color: jm_line_color,
        borderRadius: BorderRadius.circular(widthScale * 2),
      ),
      child: Row(
        children: [
          SizedBox(
            width: widthScale * 1.5,
          ),
          Icon(
            Icons.error,
            color: jm_appTheme,
            size: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(widthScale * 3, 5, 0, 5),
            child: Text(
              str,
              style: jm_text_black_style14,
            ),
          )
        ],
      ),
    );
  }
}
