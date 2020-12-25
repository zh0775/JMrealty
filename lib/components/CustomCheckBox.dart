import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final Function(bool selected) onChange;
  final bool value;
  final Color checkColor;
  final Color activeColor;
  const CustomCheckBox(
      {this.onChange,
      this.value,
      this.activeColor = jm_appTheme,
      this.checkColor = Colors.white});
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value;
  @override
  Widget build(BuildContext context) {
    value = widget.value ?? false;
    return Checkbox(
        value: value,
        onChanged: widget.onChange,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkColor: widget.checkColor,
        activeColor: widget.activeColor,
        focusColor: jm_appTheme);
  }
}
