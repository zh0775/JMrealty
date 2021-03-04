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
              dynamic otherIndex;
              value.forEach((element) {
                keyList.add({
                  'value': element['dictValue'],
                  'title': element['dictLabel']
                });
                if (element['dictLabel'] == '其他') {
                  otherIndex = element['dictValue'];
                }
              });

              listData[key] = keyList;
              listData[key + 'Index'] = otherIndex ?? -1;
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
      Map<String, dynamic> params, void Function(bool success) reqSuccess,
      {bool isEdit = false}) {
    // state = BaseState.LOADING;
    Http().post(
      isEdit ? Urls.editClient : Urls.addClient,
      params,
      success: (json) {
        // Map<String, dynamic> data = json['data'];
        if (json['code'] == 200) {
          // state = BaseState.CONTENT;
          if (reqSuccess != null) {
            reqSuccess(true);
          }
        } else {
          // state = BaseState.FAIL;
          if (reqSuccess != null) {
            reqSuccess(false);
          }

          if (json['msg'] != null) {
            ShowToast.normal(json['msg']);
          }
        }

        // notifyListeners();
      },
      fail: (reason, code) {
        // state = BaseState.FAIL;
        // notifyListeners();
        if (reqSuccess != null) {
          reqSuccess(false);
        }
        // ShowToast.normal(reason);
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
