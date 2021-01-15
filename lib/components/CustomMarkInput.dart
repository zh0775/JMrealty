import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomMarkInput extends StatefulWidget {
  final Function(String value) valueChange;
  final String hintText;
  final String text;
  final int maxLength;
  CustomMarkInput(
      {this.valueChange,
      this.text = '',
      this.maxLength,
      this.hintText = '请输入'});
  @override
  _CustomMarkInputState createState() => _CustomMarkInputState();
}

class _CustomMarkInputState extends State<CustomMarkInput> {
  double marginSpace;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    marginSpace = SizeConfig.blockSizeHorizontal * 6;
    return Container(
      constraints: BoxConstraints(
          // minHeight: 200,
          // maxHeight: widget.maxLength != null ? 120 : 90,
          // minHeight: widget.maxLength != null ? 120 : 120,
          minWidth: SizeConfig.screenWidth - marginSpace * 2),
      // width: SizeConfig.screenWidth - marginSpace * 2,
      padding: EdgeInsets.fromLTRB(marginSpace, 10, marginSpace, 10),
      child: TextField(
        maxLines: null,
        controller: TextEditingController.fromValue(TextEditingValue(
          text: widget.text ?? '',
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: widget.text.length ?? 0)),
        )),
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(10),
            //     borderSide:
            //         BorderSide(width: 0.1, color: Colors.red)),
            // fillColor: Color(0xfff7f8fb),
            // contentPadding: EdgeInsets.all(20.0),
            hintText: '请输入',
            filled: true,
            enabledBorder: OutlineInputBorder(
              //未选中时候的颜色
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: jm_line_color,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              //选中时外边框颜色
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: jm_line_color,
              ),
            )),
        onChanged: (value) {
          if (widget.valueChange != null) {
            widget.valueChange(value);
          }
          // print('特殊要求 value === $value');
          // addClientParams['remarks'] = value;
        },
      ),
    );
  }
}
