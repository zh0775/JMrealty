import 'package:JMrealty/StartAppPage.dart';
import 'package:JMrealty/const/Config.dart';
import 'package:JMrealty/const/Routes.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
//   jPush.getRegistrationID().then((rid) {
//     print('---->rid:${rid}');
//     // _result = "JPush RegistrationID 唯一标识:\n $rid";
//   });
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String debugLable = 'Unknown';
  EventBus _bus = EventBus();
  final JPush jPush = new JPush();

  @override
  void initState() {
    super.initState();
    registJPush();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Global.navigatorKey,
      onGenerateRoute: (setting) {
        return Routes.findRoutes(setting);
      },
      builder: EasyLoading.init(),
      home: StartAppPage(),
      theme: ThemeData(
          primaryColor: jm_appTheme,
          splashColor: jm_appTheme,
          // primaryTextTheme: TextTheme(headline4: jm_text_apptheme_style15),
          // dialogTheme: DialogTheme(
          //     contentTextStyle: jm_text_apptheme_style15,
          //     titleTextStyle: jm_text_apptheme_style15),
          colorScheme: ColorScheme.light(primary: jm_appTheme),
          highlightColor: Color.fromRGBO(255, 255, 255, 0.5),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(jm_appTheme_splash)))),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // ChineseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      navigatorObservers: [
        GLObserver(),
      ],
    );
  }

  registJPush() async {
    String platformVersion;
    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
        _bus.emit(NOTIFY_NOTIFICATION_MESSAGE_REFRESH);

        // setState(() {
        //   debugLable = "flutter onReceiveNotification: $message";
        // });
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        // setState(() {
        //   debugLable = "flutter onOpenNotification: $message";
        // });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        // setState(() {
        //   debugLable = "flutter onReceiveMessage: $message";
        // });
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        // setState(() {
        //   debugLable = "flutter onReceiveNotificationAuthorization: $message";
        // });
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jPush.setup(
      appKey: Config.JPUSH_APP_KEY,
      channel: "theChannel",
      production: JPUSH_ENVIRONMENT == 'dev' ? false : true,
      debug: JPUSH_ENVIRONMENT == 'dev' ? true : false,
    );
    jPush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jPush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      // setState(() {
      //   debugLable = "flutter getRegistrationID: $rid";
      // });
    });
  }
}

class GLObserver extends NavigatorObserver {
// 添加导航监听后，跳转的时候需要使用Navigator.push路由
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    // print('route === ${route}');
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
  }
}
