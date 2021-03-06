import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class SetTargetViewModel {
  loadTargetSetting(int id, Function(bool success, Map data) success) {
    Http().get(
      Urls.queryEmployeeTarget,
      {'id': id},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true, json['data']);
          }
        } else {
          if (json['msg'] != null && json['msg'].length > 0) {
            ShowToast.normal(json['msg']);
          }
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

  setTargetRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.employeeSetTarget,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (json['msg'] != null && json['msg'].length > 0) {
            ShowToast.normal(json['msg']);
          }
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
