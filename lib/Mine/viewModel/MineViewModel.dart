import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class MineViewModel {
  loadMonthTarget(int id, Function(bool success, Map data) success) {
    Http().get(Urls.monthTarget, {'id': id}, success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(true, json['data']);
        }
      } else {
        if (success != null) {
          success(false, null);
        }
      }
    }, fail: (String reason, int code) {
      if (success != null) {
        success(false, null);
      }
    });
  }

  changeInfo(Map params, Function(bool success) success) {
    Http().post(Urls.changeUserInfo, Map<String, dynamic>.from(params),
        success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(true);
        }
      } else {
        if (success != null) {
          success(false);
        }
      }
    }, fail: (String reason, int code) {
      if (success != null) {
        success(false);
      }
    });
  }
}
