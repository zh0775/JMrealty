import 'package:flutter/material.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';

class CustomButton extends StatefulWidget {
  final double height;
  final double width;
  final Function() onPressed;
  final Color backgroundColor;
  final Widget child;
  final TextStyle style;
  final BorderRadius borderRadius;
  final BorderSide border;
  const CustomButton(
      {this.height = 0,
      this.width = 0,
      this.onPressed,
      this.backgroundColor,
      this.border,
      this.child,
      this.borderRadius,
      this.style = jm_text_black_style14});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        elevation: 0.2,
        highlightElevation: 1.0,
        splashColor: Colors.transparent,
        onPressed: widget.onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: widget.backgroundColor,
        constraints:
            BoxConstraints(minHeight: widget.height, minWidth: widget.width),
        child: widget.child ?? NoneV(),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
          side:
              widget.border ?? BorderSide(width: 0, color: Colors.transparent),
        ));
  }
}
