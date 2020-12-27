// import 'dart:convert';

import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKviewModel extends BaseViewModel {
  List listData = [];

  loadPKList(int status, {Function(List dataList) success}) {
    Map params = Map<String, dynamic>.from({});
    if (status != null && status >= 0) {
      params['status'] = status;
    }
    Http().get(Urls.pkList, params, success: (json) {
      if (json['code'] == 200) {
        listData = json['data'];
        if (success != null) {
          success(listData);
        }
      }
    }, fail: (reason, code) {});
  }
}
