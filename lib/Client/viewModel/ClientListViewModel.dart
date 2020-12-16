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
  loadClientList(Map params, {Function(List data) success}) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.clientList,
      params,
      success: (json) {
        Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          listData = data['rows'];
          if(success != null) {
            success(listData);
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
}
