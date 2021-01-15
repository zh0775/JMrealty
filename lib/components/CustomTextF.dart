import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomTextF extends StatefulWidget {
  final double width;
  final double margin;
  final double height;
  final double labelWidth;
  final String labelText;
  final String text;
  final String placeholder;
  final bool must;
  final bool bottomLine;
  final TextInputType keyboardType;
  final TextStyle labelStyle;
  final TextStyle style;
  final BorderSide border;
  final bool enable;
  final Color backgroundColor;
  final Function(String value) valueChange;
  final FocusNode focusNode;
  const CustomTextF(
      {Key key,
      this.width,
      this.margin,
      this.height = 50,
      this.bottomLine = false,
      this.labelWidth = 0.0,
      this.labelText,
      this.placeholder = '',
      this.text = '',
      this.must = false,
      this.labelStyle = jm_text_black_style14,
      this.style = jm_text_black_style14,
      this.keyboardType = TextInputType.text,
      this.enable = true,
      this.backgroundColor = Colors.transparent,
      this.valueChange,
      this.border = BorderSide.none,
      this.focusNode})
      : super(key: key);
  @override
  _CustomTextFState createState() => _CustomTextFState();
}

class _CustomTextFState extends State<CustomTextF> {
  double widthScale;
  double otherWidth;
  double labelWidth;
  double selfWidth;
  double margin;
  String selfValue = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    if (widget.width == null) {
      if (widget.margin == null) {
        margin = widthScale * 6;
      }
      selfWidth = SizeConfig.screenWidth - margin * 2;
    } else {
      selfWidth = widget.width;
      margin = (SizeConfig.screenWidth - selfWidth) / 2;
    }
    widget.labelWidth == 0.0 && widget.labelText != null
        ? labelWidth = widthScale * 24
        : labelWidth = widget.labelWidth;
    otherWidth = selfWidth - labelWidth;

    return UnconstrainedBox(
      child: Container(
        width: selfWidth,
        height: widget.height,
        decoration: BoxDecoration(
            border: widget.bottomLine
                ? Border(bottom: BorderSide(width: 0.5, color: jm_line_color))
                : Border.fromBorderSide(BorderSide.none)),
        child: Row(
          children: [
            Container(
              // height: widget.height,
              width: labelWidth,
              child: widget.must
                  ? RichText(
                      text: TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                          children: [
                          TextSpan(
                              text: widget.labelText ?? '',
                              style: widget.labelStyle)
                        ]))
                  : Text(widget.labelText ?? '', style: widget.labelStyle),
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              width: otherWidth,
              constraints: BoxConstraints(
                  minWidth: otherWidth, minHeight: widget.height - 2),
              child: TextField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget.text ?? '',
                  selection: TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: widget.text.length ?? 0)),
                )),
                enabled: widget.enable,
                keyboardType: widget.keyboardType,
                style: widget.style,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  filled: true,
                  fillColor: widget.backgroundColor,
                  focusedBorder: OutlineInputBorder(borderSide: widget.border),
                  disabledBorder: OutlineInputBorder(borderSide: widget.border),
                  enabledBorder: OutlineInputBorder(borderSide: widget.border),
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      // borderRadius: widget.borderRadius,
                      borderSide: widget.border),
                ),
                onChanged: (value) {
                  selfValue = value;
                  if (widget.valueChange != null) {
                    widget.valueChange(value);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
