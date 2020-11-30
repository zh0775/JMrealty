import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';

enum ClientStatus {
  wait, // 待跟进
  already, // 已带看
  order, // 已预约
  deal, // 已成交
  water // 水客
}

class ClientListViewModel extends BaseViewModel {
  Map listData = {};
  loadClientList (ClientStatus status) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(Urls.clientList, {'status': status.index},
      success: (json) {
        Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          listData[status.index.toString()] = data['rows'];
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
      after: () {},);
  }


}