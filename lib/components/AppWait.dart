import 'package:JMrealty/StartAppPage.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class AppWait {
  final BuildContext context;
  AppWait({this.context});
  bool isShow = false;
  OverlayEntry _overlayEntry;
  OverlayEntry createOverlayEntry() {
    // BuildContext context = Global.navigatorKey.currentContext;
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    // Widget c = Container();
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              height: size.height,
              child: Material(
                  elevation: 0.0,
                  child: StartAppPage(
                    timeOut: () {
                      hide();
                    },
                  )),
            ));
  }

  show() {
    if (!isShow) {
      _overlayEntry = this.createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
      isShow = true;
    }
    //   Overlay.of(context).insert(this._overlayEntry);
  }

  hide() {
    if (isShow) {
      _overlayEntry.remove();
      isShow = false;
    }
  }
}
