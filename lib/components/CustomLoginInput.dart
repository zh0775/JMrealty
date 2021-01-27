import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoginInput extends StatefulWidget {
  final Function(String value) valueChange;
  final double height;
  final double width;
  final bool hideText;
  final bool needClean;
  final String placeholder;
  final int maxLengs;
  final TextInputType keyboardType;
  const CustomLoginInput(
      {this.valueChange,
      this.needClean = false,
      this.width,
      this.height,
      this.maxLengs,
      this.hideText = false,
      this.placeholder,
      this.keyboardType = TextInputType.text});
  @override
  _CustomLoginInputState createState() => _CustomLoginInputState();
}

class _CustomLoginInputState extends State<CustomLoginInput> {
  String string = '';
  double selfWidth;
  double selfHeight;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    selfWidth = widget.width ?? SizeConfig.screenWidth - 80;
    selfHeight = widget.height ?? 50;
    return Container(
      width: selfWidth,
      padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1.5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: selfHeight),
      child: CupertinoTextField(
        // suffix: Icon(
        //   Icons.highlight_off,
        //   color: jm_line_color,
        // ),
        // controller: Tex,
        maxLength: widget.maxLengs,
        obscureText: widget.hideText,
        clearButtonMode: widget.needClean
            ? OverlayVisibilityMode.always
            : OverlayVisibilityMode.never,

        keyboardType: widget.keyboardType,
        placeholderStyle: TextStyle(color: jm_placeholder_color, fontSize: 15),
        controller: TextEditingController.fromValue(TextEditingValue(
          text: string ?? '',
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: string != null ? string.length : 0)),
        )),
        decoration: BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.symmetric(horizontal: 20),
        // obscureText: true,
        placeholder: widget.placeholder ?? '',
        // clearButtonMode: OverlayVisibilityMode.always,
        onChanged: (value) {
          string = value;
          if (widget.valueChange != null) {
            widget.valueChange(value);
          }
        },
      ),
    );
  }
}
