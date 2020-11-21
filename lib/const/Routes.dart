import 'package:flutter/cupertino.dart';
import 'package:JMrealty/Home/Home.dart';

class Routes {
  static const String main_page = '/main/mainPage';
  static Route findRoutes(RouteSettings settings) {
    String name = settings.name;
    Object argument = settings.arguments;
    return CupertinoPageRoute(builder: (_) {
      return _findPage(name, argument);
    });
  }

  static Widget _findPage(String name, Object object) {
    Widget page;
    switch (name) {
      case main_page:
        page = MainPageWidget();
        break;
      default:
    }
    return page;
  }
}
