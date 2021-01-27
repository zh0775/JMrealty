import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class MyTasksViewModel {
  loadTasksPublishedList(
      Function(List tasksList, bool success, int total) success,
      {Map params = const {}}) {
    Http().get(
      Urls.tasksPublishedList,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows'], true, (json['data'])['total']);
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

  loadTasksAcceptList(Function(List tasksList, bool success) success,
      {Map params = const {}}) {
    Http().get(
      Urls.tasksAcceptList,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows'], true);
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

  addTasksRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.tasksAdd,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }

  loadTasksType(Function(List data, bool success) success) {
    Http().get(
      Urls.tasksType,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            List listData = (json['data']).map((value) {
              return {'title': value['dictLabel'], 'value': value['dictValue']};
            }).toList();
            success(listData, true);
          }
        } else {
          if (success != null) {
            success([], false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success([], false);
        }
      },
    );
  }

  loadTasksUrgency(Function(List data, bool success) success) {
    Http().get(
      Urls.tasksUrgency,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            List listData = (json['data']).map((value) {
              return {'title': value['dictLabel'], 'value': value['dictValue']};
            }).toList();
            success(listData, true);
          }
        } else {
          if (success != null) {
            success([], false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success([], false);
        }
      },
    );
  }

  taskCompleteRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.changeTaskStatus,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
