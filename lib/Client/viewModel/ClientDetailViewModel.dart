import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ClientDetailViewModel extends BaseViewModel {
  Map clientData;

  loadClientDetail(int id) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.findClientById,
      {'id': id},
      success: (json) {
        if (json['code'] == 200) {
          clientData = json['data'];
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          if (json['msg'] != null) {
            ShowToast.normal(json['msg']);
          }
          state = BaseState.FAIL;
          notifyListeners();
        }
      },
      fail: (reason, code) {
        ShowToast.normal(reason);
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );

    // Http().getDio().get(Urls.findClientById, queryParameters: {'id': id}).then(
    //     (Response response) {
    //   clientData = response.data;
    // });
  }
}
