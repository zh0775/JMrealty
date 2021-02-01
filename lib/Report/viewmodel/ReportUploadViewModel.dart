import 'package:JMrealty/Report/ReportUpload.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportUploadViewModel extends BaseViewModel {
  uploadReportRecord(Map params, Function(bool success) success,
      {ReportUploadStatus uploadStatus = ReportUploadStatus.upload}) {
    String url = Urls.reportUploadRecord;
    switch (uploadStatus) {
      case ReportUploadStatus.upload:
        url = Urls.reportUploadRecord;
        break;
      case ReportUploadStatus.appointment:
        url = Urls.reportAppointment;
        break;
      case ReportUploadStatus.chargeback:
        url = Urls.reportChargeBack;
        break;
      case ReportUploadStatus.invalid:
        url = Urls.reportInvalid;
        break;
      case ReportUploadStatus.sign:
        url = Urls.reportSignUp;
        break;
      case ReportUploadStatus.disputed:
        url = Urls.reportDispute;
        break;
      case ReportUploadStatus.checkDeal:
        url = Urls.waitForConfirmation;
        break;
      case ReportUploadStatus.checkAppointment:
        url = Urls.waitForConfirmation;
        break;
    }
    Http().post(
      url,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (json['msg'] != null && json['msg'].length > 0) {
            ShowToast.normal(json['msg']);
          }
          success(false);
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

  loadInvalidTmp(Function(List dataList, bool success) success) {
    Http().get(
      Urls.searchDic,
      {'dictId': 129},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }
}
