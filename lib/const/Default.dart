import 'package:JMrealty/Login/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color jm_appTheme = Color.fromRGBO(230, 184, 92, 1);
const Color jm_appTheme_splash = Color.fromRGBO(230, 184, 92, 0.2);
const Color jm_line_color = Color.fromRGBO(0, 0, 0, 0.15);
const Color jm_text_black = Color(0xff404351);
const Color jm_text_gray = Color(0xffaaacb2);
class Global{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void toLogin({bool isLogin = true}) {
    Navigator.of(Global.navigatorKey.currentState.context).push(MaterialPageRoute(
        builder: (_) {
          return Login(
            isLogin: isLogin,
          );
        },
        fullscreenDialog: true));
  }
}