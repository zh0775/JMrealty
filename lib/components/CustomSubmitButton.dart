import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final double height;
  final double margin;
  final String title;
  final TextStyle style;
  final bool enable;
  final Function() buttonClick;
  CustomSubmitButton(
      {this.height = 65,
      this.margin,
      this.enable = true,
      this.title = '提交',
      this.buttonClick,
      this.style = const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)});
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
        fillColor: enable ? jm_appTheme : jm_appTheme_disable,
        elevation: 1,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2)),
        onPressed: enable
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (buttonClick != null) {
                  buttonClick();
                }
              }
            : null,
        child: Text(title, style: style),
      ),
    );
  }
}
