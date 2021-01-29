import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:dio/dio.dart';

class ReportSuccessViewModel {
  reportSuccessRequest(Map params, Function(bool success) success) {
    // Http()
    //     .getDio()
    //     .post(Urls.reportSuccess, data: Map<String, dynamic>.from(params))
    //     .then((Response response) {
    //   print('data ====  $response');
    // });
    // Http().delete(
    //   Urls.reportSuccess,
    //   params,
    //   success: (json) {
    //     if (json['code'] == 200) {
    //       success(true);
    //     }
    //   },
    //   fail: (reason, code) {},
    // );
    Http().post(
      Urls.reportSuccess,
      params,
      success: (json) {
        if (json['code'] == 200) {
          success(true);
        } else {
          if (json['msg'] != null && json['msg'].length > 0) {
            ShowToast.normal(json['msg']);
          }
        }
      },
      fail: (reason, code) {},
    );
    // Http().post(
    //   Urls.reportSuccess,
    //   Map<String, dynamic>.from(params),
    //   success: (json) {
    //     // if (json['code'] == 200) {
    //     //   if (success != null) {
    //     //     success(true);
    //     //   }
    //     // } else {
    //     //   if (success != null) {
    //     //     success(false);
    //     //   }
    //     // }
    //     // if (json['msg'] != null) {
    //     //   ShowToast.normal(json['msg']);
    //     // }
    //   },
    //   fail: (reason, code) {
    //     // success(false);
    //     // if (reason != null) {
    //     //   ShowToast.normal(reason);
    //     // }
    //   },
    // );
  }
}
