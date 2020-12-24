import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportUploadViewModel extends BaseViewModel {
  uploadReportRecord(Map params, Function(bool success) success) {
    Http().post(
      Urls.reportUploadRecord,
      Map<String, dynamic>.from(params),
      success: (json) {
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

  upLoadReportImages(List images, {Function(List strImg) callBack}) {
    int total = images.length;
    int successCount = 0;
    Http().uploadImages(images, resList: (List resImages) {
      List<String> imageDatas = [];
      resImages.forEach((imgJson) {
        if ((imgJson.data)['code'] == 200) {
          successCount++;
          imageDatas.add((imgJson.data)['data']);
        }
      });
      callBack(imageDatas);
      if (total != successCount) {
        ShowToast.normal('上传成功' +
            successCount.toString() +
            '张，失败' +
            (total - successCount).toString() +
            '张');
      }
      if (successCount == 0) {
        ShowToast.normal('上传失败');
      }
    });
  }
}
