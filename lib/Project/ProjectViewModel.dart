import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class ProjectViewModel {
  loadProjectList(
      Map params, Function(List projectList, bool success, int total) success) {
    Http().get(
      Urls.projectList,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data']) != null ? (json['data'])['rows'] ?? [] : [],
                true, (json['data'])['total'] ?? 0);
          }
        } else {
          if (success != null) {
            success(null, false, 0);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false, 0);
        }
      },
    );
  }

  reportListProjectFilter(
      Function(List projectList, bool success, int total) success) {
    Http().get(
      Urls.reportListProjectFilter,
      Map<String, dynamic>.from({}),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data']) != null ? (json['data'])['rows'] ?? [] : [],
                true, (json['data'])['total'] ?? 0);
          }
        } else {
          if (success != null) {
            success(null, false, 0);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false, 0);
        }
      },
    );
  }

  searchProject(
      Map params, Function(List projectList, bool success, int total) success) {
    Http().get(
      Urls.projectList,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data']) != null ? (json['data'])['rows'] ?? [] : [],
                true, (json['data'])['total']);
          }
        } else {
          if (success != null) {
            success(null, false, 0);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false, 0);
        }
      },
    );
  }
}
