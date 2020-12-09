import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:dio/dio.dart';

class ReportSuccessViewModel {
  reportSuccessRequest(Map params, Function(bool success) success) {
    Http()
        .getDio()
        .post(Urls.reportSuccess, data: params)
        .then((Response response) {
      print('data ====  $response');
    });

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
