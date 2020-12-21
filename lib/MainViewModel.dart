import 'dart:convert';

import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class MainViewModel {
  loadForcedRemind (Function(bool needRemind) needRemind){
    Http().post(Urls.findOvertime, {},success: (json) {
      if(json['code'] == 200) {
        if(needRemind != null) {
          needRemind(true);
        }
      } else {
        if(needRemind != null) {
          needRemind(false);
        }
      }
    },fail: (String reason, int code) {
      if(needRemind != null) {
        needRemind(false);
      }
    });
  }
}