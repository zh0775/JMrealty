import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class ProjectDistrictViewModel {
  loadDepLevel1List(Function(List dataList, bool success) success) {
    Http().get(
      Urls.findDeptDetailIsListByDeptIp,
      {},
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

  loadDepLevel2List(Map params, Function(List dataList, bool success) success) {
    Http().get(
      Urls.getAreaList,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['rows'], true);
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

  loadDepLevel3List(Function(List dataList, bool success) success) {
    Http().get(
      Urls.findDeptDetailIsListByDeptIp,
      {},
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
