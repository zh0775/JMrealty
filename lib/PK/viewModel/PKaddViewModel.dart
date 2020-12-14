import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class PKviewModel extends BaseViewModel {


  loadPKList (Map addParams) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(Urls.pkList, {},success: (json) {
      if (json['code'] == 200) {
        state = BaseState.CONTENT;
        notifyListeners();
      } else {
        state = BaseState.FAIL;
        notifyListeners();
      }
    },fail: (reason, code){
      state = BaseState.FAIL;
      notifyListeners();
    });
  }
}
