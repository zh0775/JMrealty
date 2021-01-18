import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class LevelTargetViewModel {
  getDepCityList(Function(bool success, List cityList) success) {
    Http().get(
      Urls.getDepCityList,
      {'isCity': 1},
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

  loadTarget(int depId, Function(bool success, List targetList) success) {
    Http().post(
      Urls.targetRuleList,
      {'organizationId': depId},
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

  addTargetSetting(Map params, Function(bool success) success) {
    Http().post(
      Urls.addTargetRule,
      params,
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
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }

  deleteTarget(int id, Function(bool success) success) {
    // state = BaseState.LOADING;
    // notifyListeners();
    Http().delete(
      Urls.deleteTargetRule(id.toString()),
      Map<String, dynamic>.from({'id': id}),
      success: (json) {
        // state = BaseState.CONTENT;
        // notifyListeners();
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
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

  saveTarget() {}
}
