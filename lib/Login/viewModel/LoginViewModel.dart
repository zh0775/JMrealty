import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginViewModel extends BaseViewModel {
  bool sendCodeSuccess;
  loadPhoneCode(String phonenumber) {
    print('phonenumber == $phonenumber');
    // Fluttertoast.showToast(
    //     msg: '123',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
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
      },
      after: () {},
    );
  }
}
