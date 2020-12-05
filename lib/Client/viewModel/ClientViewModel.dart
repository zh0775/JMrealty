import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';

class ClientViewModel extends BaseViewModel {
  // ClientModel clientModel;
  // List<ClientModel> clientList = [];
  // ClientModel addClientModel;
  Map<String, dynamic> listData = {};
  loadAddSelect() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.allTypeByCostomer,
      {},
      success: (json) {
        Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          data.forEach((key, value) {
            List<Map<String, dynamic>> keyList = [];
            if (value != null && value is List) {
              value.forEach((element) {
                keyList.add({
                  'value': element['dictValue'],
                  'title': element['dictLabel']
                });
              });
              listData[key] = keyList;
            }
          });
          print('listData === $listData');
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

  sendAddClientRequest(
      Map<String, dynamic> params, void Function(bool success) reqSuccess) {
    print('params === $params');
    if (params['name'] == null || params['name'].length == 0) {
      ShowToast.normal('请输入客户姓名');
      return;
    }
    if (params['phone'] == null || params['phone'].length == 0) {
      ShowToast.normal('请输入客户手机号码');
      return;
    }
    if (!isMobilePhoneNumber(params['phone'])) {
      ShowToast.normal('请输入正确的手机号码');
      return;
    }
    // state = BaseState.LOADING;
    Http().post(
      Urls.addClient,
      params,
      success: (json) {
        // Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          // state = BaseState.CONTENT;
          reqSuccess(true);
        } else {
          // state = BaseState.FAIL;
          reqSuccess(false);
        }
        ShowToast.normal(json['msg']);
        // notifyListeners();
      },
      fail: (reason, code) {
        // state = BaseState.FAIL;
        // notifyListeners();
        reqSuccess(false);
        ShowToast.normal(reason);
      },
      after: () {},
    );
  }

  @override
  void dispose() {
    // clientList = [];
    super.dispose();
  }
}
