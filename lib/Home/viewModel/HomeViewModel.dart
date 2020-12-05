import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'dart:convert' as convert;

class HomeViewModel extends BaseViewModel {
  Map<String, dynamic> userInfo;

  loadUserInfo() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.getUserInfo,
      {},
      success: (json) {
        UserDefault.saveStr('userInfo', convert.jsonEncode(json['data']))
            .then((value) {
          if (value) {
            state = BaseState.CONTENT;
            notifyListeners();
          }
        });
      },
      fail: (reason, code) {},
      after: () {},
    );
  }
}
