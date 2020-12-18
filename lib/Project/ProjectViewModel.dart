import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class ProjectViewModel {
  loadProjectList(Function(List projectList) success) {
    Http().get(
      Urls.projectList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data']);
          }
        }
      },
      fail: (reason, code) {},
    );
  }
}
