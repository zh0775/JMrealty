import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

typedef void ZZinputValueChange(String value);

class ZZInput extends StatefulWidget {
  final Key key;
  final double width;
  final double height;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final String hintText;
  final ZZinputValueChange valueChange;
  final Color backgroundColor;
  final bool needCleanButton;
  final TextInputType keyboardType;
  final double leftPadding;
  final String text;
  final bool enable;
  ZZInput(
      {this.key,
      this.width = 100,
      this.height = 50,
      this.textStyle = const TextStyle(fontSize: 16),
      this.borderRadius = const BorderRadius.all(Radius.circular(8)),
      this.hintText = '',
      this.valueChange,
      this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.1),
      this.needCleanButton = false,
      this.keyboardType = TextInputType.text,
      this.leftPadding = 20,
      this.text = '',
      this.enable = true})
      : super(key: key);
  @override
  _ZZInputState createState() => _ZZInputState();
}

class _ZZInputState extends State<ZZInput> {
  // 登录手机号输入框controller
  bool phoneNeedClean; // 登录页手机号输入框清空标记

  @override
  void initState() {
    phoneNeedClean = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double rightPadding = widget.needCleanButton ? 80 : 20;
    // double rightPadding = 20;
    return Container(
        width: widget.width,
        constraints: BoxConstraints(maxHeight: widget.height),
        child: Stack(
          children: [
            Container(
              child: TextField(
                  key: widget.key ?? GlobalKey(),
                  // textAlignVertical: TextAlignVertical.bottom,
                  enabled: widget.enable,
                  keyboardType: widget.keyboardType,
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: widget.text ?? '',
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: widget.text != null ? widget.text.length : 0)),
                  )),
                  maxLines: 1,
                  style: widget.textStyle,
                  onChanged: (value) {
                    if (widget.valueChange != null) widget.valueChange(value);
                    if (widget.needCleanButton) {
                      bool needClear = false;
                      if (value.length > 0) {
                        needClear = true;
                      }
                      if (phoneNeedClean != needClear) {
                        setState(() {
                          phoneNeedClean = needClear;
                        });
                      }
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    contentPadding: EdgeInsets.fromLTRB(
                        widget.leftPadding, 0, rightPadding, 0),
                    border: OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: BorderSide.none),

                    fillColor: widget.backgroundColor,
                    // contentPadding: EdgeInsets.all(20.0),
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(color: jm_placeholder_color, fontSize: 15),
                    filled: true,
                  )),
            ),
            // phoneNeedClean == true
            //     ? Positioned(
            //         width: widget.height,
            //         height: widget.height,
            //         right: 0,
            //         top: 0,
            //         child: TextButton(
            //             onPressed: () {
            //               phoneCtr.clear();
            //               if (widget.valueChange != null) {
            //                 widget.valueChange('');
            //               }
            //               setState(() {
            //                 phoneNeedClean = false;
            //               });
            //             },
            //             child: Icon(
            //               Icons.close,
            //               size: 20,
            //               color: Colors.black,
            //             )))
            //     : Container(
            //         height: 0.0,
            //         width: 0.0,
            //       )
          ],
        ));
  }
}
