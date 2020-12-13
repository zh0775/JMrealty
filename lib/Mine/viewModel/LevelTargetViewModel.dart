import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class LevelTargetViewModel extends BaseViewModel {
  List levelTarget;

  loadTarget(int depId) {
    state = BaseState.LOADING;
    Http().get(
      Urls.targetRuleList,
      {'organizationId': depId},
      success: (json) {
        state = BaseState.CONTENT;
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
}
