import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  final String confirmText;
  final String cancelText;
  final String title;
  final String content;
  BuildContext _context = Global.navigatorKey.currentContext;

  CustomAlert(
      {this.confirmText = '确认',
      this.cancelText = '取消',
      this.title = '提示',
      this.content = ''});
  show({
    Function() confirmClick,
    Function() cancelClick,
  }) {
    showDialog(
      context: _context,
      builder: (context) {
        SizeConfig().init(_context);
        double widthScale = SizeConfig.blockSizeHorizontal;
        return AlertDialog(
          title: title != ''
              ? Text(
                  title,
                  style: jm_text_black_style18,
                )
              : NoneV(),
          content: Text(
            content,
            style: jm_text_black_style14,
          ),
          actions: [
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(minWidth: 0),
              onPressed: () {
                if (cancelClick != null) {
                  cancelClick();
                }
                Navigator.pop(_context);
              },
              child: Padding(
                padding: EdgeInsets.only(right: widthScale * 4, bottom: 10),
                child: Text(
                  cancelText,
                  style: jm_text_apptheme_style14,
                ),
              ),
            ),
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(minWidth: 0),
              onPressed: () {
                if (confirmClick != null) {
                  confirmClick();
                }
                Navigator.pop(_context);
              },
              child: Padding(
                padding: EdgeInsets.only(right: widthScale * 4, bottom: 10),
                child: Text(
                  confirmText,
                  style: jm_text_apptheme_style14,
                ),
              ),
            ),
          ],
        );
      },
    );

    // showCupertinoDialog(
    //     context: _context,
    //     builder: (_context) {
    //       return CupertinoAlertDialog(
    //         title: Text(
    //           title,
    //           style: TextStyle(fontSize: 14, color: jm_text_black),
    //         ),
    //         content: Text(
    //           content,
    //           style: TextStyle(fontSize: 14, color: jm_text_black),
    //         ),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 if (cancelClick != null) {
    //                   cancelClick();
    //                 }
    //                 Navigator.pop(_context);
    //               },
    //               child: Text(
    //                 cancelText,
    //                 style: TextStyle(fontSize: 14, color: jm_text_black),
    //               )),
    //           TextButton(
    //               onPressed: () {
    //                 if (confirmClick != null) {
    //                   confirmClick();
    //                 }
    //                 Navigator.pop(_context);
    //               },
    //               child: Text(
    //                 confirmText,
    //                 style: TextStyle(fontSize: 14, color: jm_text_black),
    //               )),
    //         ],
    //       );
    //     });
  }
}
