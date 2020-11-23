import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginViewModel extends BaseViewModel {
  bool sendCodeSuccess;
  loadPhoneCode(String phonenumber) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().post(
      Urls.phoneCode,
      {'phonenumber': phonenumber},
      success: (json) {
        state = BaseState.CONTENT;
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
        Fluttertoast.showToast(
            msg: reason,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: jm_appTheme,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      after: () {},
    );
  }

  loadRegistPostSelectList() {

    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerPostList,
      {},
      success: (json) {
        print('loadRegistSelectList json ==== $json');
        state = BaseState.CONTENT;
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }

  loadRegistPost1SelectList() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerPostList,
      {},
      success: (json) {
        print('loadRegistSelectList json ==== $json');
        state = BaseState.CONTENT;
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }
}
