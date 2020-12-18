import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class MyTasksViewModel {
  loadTasksPublishedList(Function(List tasksList) success) {
    Http().get(
      Urls.tasksPublishedList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows']);
          }
        }
      },
      fail: (reason, code) {},
    );
  }

  loadTasksAcceptList(Function(List tasksList) success) {
    Http().get(
      Urls.tasksAcceptList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows']);
          }
        }
      },
      fail: (reason, code) {},
    );
  }

  addTasksRequest(Map params, Function() success) {
    Http().post(
      Urls.tasksAdd,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success();
          }
        }
      },
      fail: (reason, code) {},
    );
  }
}
