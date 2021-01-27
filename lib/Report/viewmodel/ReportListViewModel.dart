import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportListViewModel extends BaseViewModel {
  loadListData(Map param,
      {int projectId,
      Function(List reportList, bool success, int total) success}) {
    Map params = Map<String, dynamic>.from(param);
    // {'status': status};
    if (projectId != null) {
      params['projectId'] = projectId;
    }
    Http().get(
      Urls.reportRecordList,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows'], true, (json['data'])['total'] ?? 0);
          }
        } else {
          // ShowToast.normal(json['msg']);
          if (success != null) {
            success(null, false, 0);
          }
        }
      },
      fail: (reason, code) {
        ShowToast.normal(reason);
        if (success != null) {
          success(null, false, 0);
        }
      },
    );
  }

  copyReportRequest(List params, Function(bool success) success) {
    Http().post(
      Urls.reportCopy,
      {'copyReport': params},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
