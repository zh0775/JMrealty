import 'package:JMrealty/Report/Report.dart';
import 'package:flutter/cupertino.dart';
import 'package:JMrealty/Home/Home.dart';

class Routes {
  static const String main_page = '/main/mainPage';
  static const String report_list = '/report/reportList';
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
      case report_list:
        page = Report();
        break;
      default:
    }
    return page;
  }
}
