import 'dart:convert';

import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Http.dart';
import 'package:JMrealty/services/Urls.dart';

class AppStartViewModel extends BaseViewModel {
  load() {
    Http().get(Urls.appStartImg, {}, success: (json) {
      print(jsonEncode(json).toString());
    }, fail: (reason, code) {
      print(reason);
    }, after: () {});
  }
}
