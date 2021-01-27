import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoading {
  // static OverlayEntry _loadding;
  static bool _isShow = false;

  factory CustomLoading() => getInstence();
  static CustomLoading get instance => getInstence();
  static CustomLoading _instance;
  CustomLoading._internal() {
    // _loadding = createOverlayEntry();
    setLoading();
  }

  static CustomLoading getInstence() {
    if (_instance == null) {
      _instance = CustomLoading._internal();
    }
    return _instance;
  }

  setLoading() {
    Widget widget = Column(
      children: [
        Image.asset(
          'assets/images/icon/loading.gif',
          width: SizeConfig.blockSizeHorizontal * 30,
          height: SizeConfig.blockSizeHorizontal * 30,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '加载中',
          style: jm_text_black_style15,
        )
      ],
    );
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskColor = Colors.black12
      ..backgroundColor = Colors.black12
      ..indicatorColor = Colors.black12
      ..progressColor = Colors.black12
      ..textColor = jm_text_black
      ..animationDuration = Duration(milliseconds: 500)
      ..displayDuration = Duration(seconds: 20)
      ..radius = 10.0
      ..userInteractions = false
      ..infoWidget = widget
      ..errorWidget = widget
      ..indicatorWidget = widget
      ..successWidget = widget;
  }

  // OverlayEntry createOverlayEntry() {
  //   BuildContext context = Global.navigatorKey.currentContext;
  //   SizeConfig().init(context);
  //   // RenderBox renderBox = context.findRenderObject();
  //   // var size = renderBox.size;
  //   // Widget c = Container();
  //   return OverlayEntry(
  //       builder: (context) => GestureDetector(
  //             onTap: () => hide(),
  //             child: Positioned(
  //               // width: SizeConfig.blockSizeHorizontal * 30,
  //               // height: SizeConfig.blockSizeHorizontal * 30,
  //               child: Center(
  //                 child: Image.asset(
  //                   'assets/images/icon/loading.gif',
  //                   width: SizeConfig.blockSizeHorizontal * 30,
  //                   height: SizeConfig.blockSizeHorizontal * 30,
  //                 ),
  //               ),
  //             ),
  //           ));
  // }

  show() {
    EasyLoading.show(dismissOnTap: true);
    // if (!_isShow) {
    //   BuildContext c = Global.navigatorKey.currentState.context;
    //   Future.delayed(Duration(microseconds: 0), () {
    //     Overlay.of(c).insert(_loadding);
    //     _isShow = true;
    //   });
    // }
  }

  hide() {
    EasyLoading.dismiss();
    // if (_isShow) {
    //   _loadding.remove();
    //   _isShow = false;
    // }
  }
}

// CustomLoading
