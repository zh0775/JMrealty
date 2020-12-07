import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final double height;
  final double margin;
  final String title;
  final Function() buttonClick;
  CustomSubmitButton(
      {this.height = 50, this.margin, this.title = '提交', this.buttonClick});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double selfMargin =
        margin != null ? margin : SizeConfig.blockSizeHorizontal * 6;
    return Align(
      child: Container(
          // 提交注册按钮
          width: SizeConfig.screenWidth - selfMargin * 2,
          height: height,
          margin: EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: jm_appTheme,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: TextButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (buttonClick != null) {
                buttonClick();
              }
            },
            child: Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )),
    );
  }
}
