import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final double height;
  final double margin;
  final String title;
  final Function() buttonClick;
  CustomSubmitButton(
      {this.height = 65, this.margin, this.title = '提交', this.buttonClick});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double selfMargin =
        margin != null ? margin : SizeConfig.blockSizeHorizontal * 30;
    return UnconstrainedBox(
      child: RawMaterialButton(
        constraints: BoxConstraints(
          minHeight: height,
          minWidth: SizeConfig.screenWidth - selfMargin * 2,
        ),
        fillColor: jm_appTheme,
        elevation: 1,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2)),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (buttonClick != null) {
            buttonClick();
          }
        },
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
