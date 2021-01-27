import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

enum ClientStatus {
  wait, // 待跟进
  already, // 已带看
  order, // 已预约
  deal, // 已成交
  water // 水客
}

class ClientListViewModel extends BaseViewModel {
  List listData = [];
  loadClientList(Map params, {Function(List data, int total) success}) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.clientList,
      {'isAsc': 'desc', 'orderByColumn': 'update_time', ...params},
      success: (json) {
        Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          listData = data['rows'];
          if (success != null) {
            success(listData, data['total']);
          }
          state = BaseState.CONTENT;
        } else {
          state = BaseState.FAIL;
        }
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
        ShowToast.normal(reason);
      },
      after: () {},
    );
  }

  loadCountProgress(Function(bool success, int count) success) {
    Http().get(
      Urls.countProgress,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true, json['data']);
          }
        } else {
          if (success != null) {
            success(false, 0);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false, 0);
        }
      },
    );
  }

  findOvertime(Function(bool success, Map data) success) {
    Http().post(
      Urls.findOvertime,
      {},
      success: (json) {
        if (json['code'] == 200) {
          success(true, json['data'] ?? {});
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
