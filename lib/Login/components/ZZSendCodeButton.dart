import 'dart:async';

import 'package:flutter/material.dart';

typedef void CodeButtonClick();
typedef void CodeButtonTimeOver();

class ZZSendCodeButton extends StatefulWidget {
  final double width;
  final double height;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final String buttonText;
  final CodeButtonClick codeButtonClick;
  final Color backgroundColor;
  final int codeWaitTime;
  final bool sending;
  final CodeButtonTimeOver codeButtonTimeOver;
  ZZSendCodeButton(
      {this.width = 100,
      this.height = 48,
      this.textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      this.borderRadius =
          const BorderRadius.horizontal(right: Radius.circular(8)),
      this.buttonText = '获取验证码',
      this.backgroundColor = const Color(0xff404351),
      this.codeWaitTime = 60,
      this.codeButtonClick,
      this.codeButtonTimeOver,
      this.sending = false});
  @override
  _ZZSendCodeButtonState createState() => _ZZSendCodeButtonState();
}

enum CodeButtonState { normal, send, wait }

class _ZZSendCodeButtonState extends State<ZZSendCodeButton> {
  CodeButtonState codeButtonState; //登录验证码状态枚举
  Timer codeTimer; // 验证码按钮倒计时定时器
  // Timer sendTimer; // 验证码按钮模拟网络请求定时器
  int codeNextTime; // 登录页验证码倒计日
  @override
  void initState() {
    codeButtonState = CodeButtonState.normal;
    codeNextTime = widget.codeWaitTime;
    // if (sendTimer != null) sendTimer.cancel();
    super.initState();
  }

  @override
  void dispose() {
    if (codeTimer != null) {
      codeTimer.cancel();
      codeTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text;
    Color buttonColor;
    Function pressed;
    if (widget.sending) {
      codeButtonWait();
    } else {
      codeButtonState = CodeButtonState.normal;
    }
    if (codeButtonState == CodeButtonState.normal) {
      text = widget.buttonText;
      buttonColor = widget.backgroundColor;
      pressed = () {
        if (codeButtonState == CodeButtonState.normal) {
          setState(() {
            codeButtonState = CodeButtonState.send;
          });
          widget.codeButtonClick();
        }
      };
    } else if (codeButtonState == CodeButtonState.send) {
      text = '获取中...';
      buttonColor = Color.fromRGBO(227, 229, 233, 1);
      pressed = null;
    } else if (codeButtonState == CodeButtonState.wait) {
      text = '重新获取 ' + codeNextTime.toString();
      buttonColor = Color.fromRGBO(227, 229, 233, 1);
      pressed = null;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration:
          BoxDecoration(color: buttonColor, borderRadius: widget.borderRadius),
      child: TextButton(
        onPressed: pressed,
        child: Text(text, style: widget.textStyle),
      ),
    );
  }

  void codeButtonWait() {
    codeButtonState = CodeButtonState.wait;
    if (codeTimer != null) codeTimer.cancel();
    codeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (codeNextTime <= 1) {
        timer.cancel();

        setState(() {
          codeButtonState = CodeButtonState.normal;
          codeNextTime = widget.codeWaitTime;
          widget.codeButtonTimeOver();
        });
      } else {
        setState(() {
          codeNextTime--;
        });
      }
    });
  }
}
