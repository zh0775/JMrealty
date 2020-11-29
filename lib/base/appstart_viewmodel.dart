import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Http.dart';
import 'package:JMrealty/services/Urls.dart';
// import 'package:flutter/cupertino.dart';

class AppStartViewModel extends BaseViewModel {
  String startImgUrl;

  load() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(Urls.appStartImg, {}, success: (json) {
      // print(jsonEncode(json).toString());
      String imgUrl = (json['data'])['pictureUrl'];
      // print('imgUrl === $imgUrl');
      if (imgUrl != null) {
        startImgUrl = imgUrl;
        state = BaseState.CONTENT;
      } else {
        state = BaseState.EMPTY;
      }
      notifyListeners();
    }, fail: (reason, code) {
      state = BaseState.FAIL;
      notifyListeners();
      // print(reason);
    }, after: () {});
  }

  downloadStartImg(url) {
    // void downApkFunction() async{
    // 申请写文件权限
    // bool isPermiss =  await checkPermissFunction();
    // )
    Http().get(Urls.appStartImg, {}, success: (json) {
      state = BaseState.CONTENT;
      notifyListeners();
      print(jsonEncode(json).toString());
    }, fail: (reason, code) {
      state = BaseState.FAIL;
      notifyListeners();
      print(reason);
    }, after: () {});
    // }

    // checkPermissFunction() async {
    //   if (Theme.of(context).platform == TargetPlatform.android) {
    //     ///安卓平台中 checkPermissionStatus方法校验是否有储存卡的读写权限
    //     PermissionStatus permission = await PermissionHandler()
    //         .checkPermissionStatus(PermissionGroup.storage);
    //     if (permission != PermissionStatus.granted) {
    //       ///无权限那么 调用方法 requestPermissions 申请权限
    //       Map<PermissionGroup, PermissionStatus> permissions =
    //       await PermissionHandler()
    //           .requestPermissions([PermissionGroup.storage]);
    //       ///校验用户对权限申请的处理
    //       if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
    //         return true;
    //       }
    //     } else {
    //       return true;
    //     }
    //   } else {
    //     return true;
    //   }
    //   return false;
    // }
  }
}
