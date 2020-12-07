import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportListViewModel extends BaseViewModel {
  Map listData;
  loadListData(int status, {int projectId, Function(bool success) success}) {
    Map params = {'status': status};
    if (projectId != null) {
      params['projectId'] = projectId;
    }
    Http().get(
      Urls.reportRecordList,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          listData = Map<String, dynamic>.from(json['data']);
          if (success != null) {
            success(true);
          }
        } else {
          ShowToast.normal(json['msg']);
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        ShowToast.normal(reason);
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
