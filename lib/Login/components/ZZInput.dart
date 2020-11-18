import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

typedef void ZZinputValueChange(String value);

class ZZInput extends StatefulWidget {
  final double width;
  final double height;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final String hintText;
  final ZZinputValueChange valueChange;
  final Color backgroundColor;
  final bool needCleanButton;
  ZZInput({
    this.width = 100,
    this.height = 50,
    this.textStyle = const TextStyle(fontSize: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.hintText = '',
    this.valueChange,
    this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.1),
    this.needCleanButton = false,
  });
  @override
  _ZZInputState createState() => _ZZInputState();
}

class _ZZInputState extends State<ZZInput> {
  TextEditingController phoneCtr; // 登录手机号输入框controller
  bool phoneNeedClean; // 登录页手机号输入框清空标记

  @override
  void initState() {
    phoneCtr = TextEditingController();
    phoneNeedClean = false;
    super.initState();
  }

  @override
  void dispose() {
    phoneCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double rightPadding = widget.needCleanButton ? 80 : 20;
    return Container(
        width: widget.width,
        constraints: BoxConstraints(maxHeight: widget.height),
        child: Stack(
          children: [
            Container(
              child: TextField(
                  controller: phoneCtr,
                  maxLines: 1,
                  style: widget.textStyle,
                  onChanged: (value) {
                    widget.valueChange(value);
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
                    contentPadding: EdgeInsets.fromLTRB(20, 0, rightPadding, 0),
                    border: OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: BorderSide.none),
                    fillColor: widget.backgroundColor,
                    // contentPadding: EdgeInsets.all(20.0),
                    hintText: widget.hintText,
                    filled: true,
                  )),
            ),
            phoneNeedClean == true
                ? Positioned(
                    width: 48,
                    height: 48,
                    right: 0,
                    top: 0,
                    child: TextButton(
                        onPressed: () {
                          phoneCtr.clear();
                          widget.valueChange('');
                          setState(() {
                            phoneNeedClean = false;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        )))
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ));
  }
}