import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportUploadViewModel extends BaseViewModel {
  uploadReportBills(Map params, Function(bool success) success) {
    Http().post(
      Urls.addReport,
      Map<String, dynamic>.from(params),
      success: (json) {
        print('json === $json');
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          success(false);
        }
        if (json['msg'] != null) {
          ShowToast.normal(json['msg']);
        }
      },
      fail: (reason, code) {
        success(false);
        if (reason != null) {
          ShowToast.normal(reason);
        }
      },
    );
  }
}
