import 'package:JMrealty/StartAppPage.dart';
import 'package:JMrealty/const/Routes.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
// import 'Home/Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:JMrealty/const/Default.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Global.navigatorKey,
        onGenerateRoute: (setting) {
          return Routes.findRoutes(setting);
        },
        home: StartAppPage(),
        theme: ThemeData(
            primaryColor: jm_appTheme,
            splashColor: jm_appTheme,
            highlightColor: Color.fromRGBO(255, 255, 255, 0.5),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(jm_appTheme_splash)))),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
    );
  }
}
