// import 'dart:convert';

import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKviewModel extends BaseViewModel {
  List listData = [];

  loadPKList(Map params,
      {Function(List dataList, bool success, int total) success}) {
    Map par = Map<String, dynamic>.from(params);
    // if (status != null && status >= 0) {
    //   params['status'] = status;
    // }
    Http().get(Urls.pkList, par, success: (json) {
      if (json['code'] == 200) {
        listData = json['data'] != null ? (json['data'])['rows'] : [];
        if (success != null) {
          success(listData, true, (json['data'])['total']);
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

  getMedal(int medalId, Function(bool success, Map medelData) success) {
    Http().get(
      Urls.getMedal,
      {'medalId': medalId},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true, json['data']);
          }
        } else {
          if (success != null) {
            success(false, null);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false, null);
        }
      },
    );
  }
}
