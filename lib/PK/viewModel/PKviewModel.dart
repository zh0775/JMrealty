import 'dart:convert';

import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKviewModel extends BaseViewModel {
  List listData = [];

  loadPKList ({Function(List dataList) success}) {
    Http().get(Urls.pkList, {},success: (json) {
      if (json['code'] == 200) {
        listData = json['data'];
        if(success != null) {
          success(listData);
        }
      }
    },fail: (reason, code){

    });
  }
}
