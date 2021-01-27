import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class SmartReportViewModel {
  smartReportRequest(String reportStr, Function(bool success) success) {
    Http().post(
      Urls.smartReport,
      {'report': reportStr},
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
        if (json['msg'] != null && (json['msg'] as String).length > 0) {
          ShowToast.normal(json['msg']);
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
