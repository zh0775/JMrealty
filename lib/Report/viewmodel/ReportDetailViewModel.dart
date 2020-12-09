import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportDetailViewModel extends BaseViewModel {
  Map reportDetailData;

  loadReportDetailRequest (int id,) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(Urls.reportDetail, {'id':id },
        success: (json) {

          if (json['code'] == 200) {
            state = BaseState.CONTENT;
            notifyListeners();
            reportDetailData = Map<String, dynamic>.from(json['data']);

          } else {
            state = BaseState.FAIL;
            notifyListeners();
            if (json['msg'] != null) {
              ShowToast.normal(json['msg']);
            }
          }
        },
        fail: (reason, code) {
          state = BaseState.FAIL;
          notifyListeners();
          if (reason != null) {
            ShowToast.normal(reason);
          }
        });
      }
}