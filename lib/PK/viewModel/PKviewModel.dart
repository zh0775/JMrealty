// import 'dart:convert';

import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKviewModel extends BaseViewModel {
  List listData = [];

  loadPKList(Map params,
      {Function(List dataList, bool success, int total) success}) {
    Map params = Map<String, dynamic>.from({});
    // if (status != null && status >= 0) {
    //   params['status'] = status;
    // }
    Http().get(Urls.pkList, params, success: (json) {
      if (json['code'] == 200) {
        listData = json['data'] != null ? (json['data'])['rows'] : [];
        if (success != null) {
          success(listData, true, json['total']);
        }
      } else {
        if (success != null) {
          success(null, false, 0);
        }
      }
    }, fail: (reason, code) {
      if (success != null) {
        success(null, false, 0);
      }
    });
  }
}
