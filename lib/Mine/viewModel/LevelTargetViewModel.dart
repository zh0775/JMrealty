import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class LevelTargetViewModel extends BaseViewModel {
  List levelTarget;

  loadTarget(int depId) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.targetRuleList,
      {'organizationId': depId},
      success: (json) {
        state = BaseState.CONTENT;
        notifyListeners();
        if (json['code'] == 200) {
        } else {
          if (json['msg'] != null) {
            ShowToast.normal(json['msg']);
          }
        }
      },
      fail: (reason, code) {
        if (reason != null) {
          ShowToast.normal(reason);
        }
      },
    );
  }

  addTargetSetting(Map params, Function() success) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().post(
      Urls.addTargetRule,
      params,
      success: (json) {
        state = BaseState.CONTENT;
        notifyListeners();
        if (json['code'] == 200) {
          if (success != null) {
            success();
          }
        } else {
          if (json['msg'] != null) {
            ShowToast.normal(json['msg']);
          }
        }
      },
      fail: (reason, code) {
        if (reason != null) {
          ShowToast.normal(reason);
        }
      },
    );
  }

  deleteTarget(int id, Function(bool success) success) {
    // state = BaseState.LOADING;
    // notifyListeners();
    Http().delete(
      Urls.deleteTargetRule(id.toString()), {},
      // params,
      success: (json) {
        // state = BaseState.CONTENT;
        // notifyListeners();
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (json['msg'] != null) {
            ShowToast.normal(json['msg']);
          }
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (reason != null) {
          ShowToast.normal(reason);
        }
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
