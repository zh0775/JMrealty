import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKaddViewModel extends BaseViewModel {
  loadPKList(Map addParams) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(Urls.pkList, {}, success: (json) {
      if (json['code'] == 200) {
        state = BaseState.CONTENT;
        notifyListeners();
      } else {
        state = BaseState.FAIL;
        notifyListeners();
      }
    }, fail: (reason, code) {
      state = BaseState.FAIL;
      notifyListeners();
    });
  }

  loadTarget({Function(List targetList) success}) {
    Http().get(Urls.pkTarget, {'dictId': 114}, success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(json['data']);
        }
      } else {}
    }, fail: (reason, code) {});
  }

  loadMedal(String name, {Function(List targetList) success}) {
    Http().get(Urls.pkMedel, {'name': name}, success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(json['data']);
        }
      } else {}
    }, fail: (reason, code) {});
  }

  adPkRequest(Map params, {Function(bool success) success}) {
    Http().post(Urls.addPk, params, success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(true);
        }
      } else {}
    }, fail: (reason, code) {});
  }

  loadPkType({Function(List data) success}) {
    Http().get(Urls.pkType, {'dictId': 121}, success: (json) {
      if (json['code'] == 200) {
        if (success != null) {
          success(json['data']);
        }
      } else {}
    }, fail: (reason, code) {});
  }
}
