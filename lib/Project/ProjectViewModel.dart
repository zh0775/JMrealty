import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class ProjectViewModel {
  loadProjectList(Function(List projectList, bool success) success) {
    Http().get(
      Urls.projectList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data']) != null ? (json['data'])['rows'] ?? [] : [],
                true);
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

  searchProject(
      String searchStr, Function(List projectList, bool success) success) {
    Http().get(
      Urls.projectList,
      {'name': searchStr},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data']) != null ? (json['data'])['rows'] ?? [] : [],
                true);
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
