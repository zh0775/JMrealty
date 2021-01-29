import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:intl/intl.dart';

class ReportViewModel extends BaseViewModel {
  List projectData;
  loadProjectList(String name,
      {Function(List data, bool success, int total) success}) {
    Http().get(
      Urls.projectFuzzySearch,
      {'name': name},
      success: (json) {
        if (json['code'] != null && json['code'] == 200) {
          projectData = (json['data'])['rows'];
          if (success != null) {
            success(projectData, true, (json['data'])['total']);
          }
        } else {
          if (success != null) {
            success(null, false, 0);
          }
        }
        // print('projectFuzzySearch === $json');
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false, 0);
        }
      },
    );
  }

  List agentData;
  loadAgentSearchData(String name, {Function(List data) success}) {
    Http().get(
      Urls.agentFuzzySearch,
      {'userName': name},
      success: (json) {
        if (json['code'] != null && json['code'] == 200) {
          agentData = (json['data'])['rows'];
          if (agentData != null && agentData is List && agentData.length > 0) {
            agentData.forEach((element) {
              element['name'] = element['userName'];
            });
          }
          if (success != null) {
            success(agentData);
          }
        }
        // print('projectFuzzySearch === $json');
      },
      fail: (reason, code) {},
    );
  }

  List clientData;
  loadClientSearchData(String name, {Function(List data) success}) {
    Http().get(
      Urls.clientFuzzySearch,
      {'keys': name},
      success: (json) {
        if (json['code'] != null && json['code'] == 200) {
          clientData = json['data'];
          if (clientData != null &&
              clientData is List &&
              clientData.length > 0) {
            clientData.forEach((element) {
              element['name'] = element['name'];
              print('element === ${element['phone']}');
            });
          }
          if (success != null) {
            success(clientData);
          }
        }
        // print('projectFuzzySearch === $json');
      },
      fail: (reason, code) {},
    );
  }

  addReportRequest(Map data, Function(bool success) success) {
    print('addReportRequest ==== $data');
    List clients = data['client'];
    Map agent = data['agent'];
    Map project = data['project'];
    // print('data === $data');
    List clientsParams = [];
    Map<String, dynamic> params = {};
    if (clients != null && clients.length > 0) {
      clients.forEach((element) {
        Map client = {
          'csutomerPhone': element['phone'],
          'custmoerSex': element['sex'],
          'customerName': element['name'],
        };
        if (element['id'] != null) {
          client['customerId'] = element['id'];
        }
        if (element['custmoerCard'] != null) {
          client['custmoerCard'] = element['custmoerCard'];
        }
        clientsParams.add(client);
      });
    }
    params = {
      'company': project['companyName'] ?? '',
      'companyId': project['companyId'] ?? '',
      'employeeId': agent['userId'] ?? '',
      'employeeName': agent['userName'] ?? '',
      'employeePhone': agent['phonenumber'] ?? '',
      'projectId': project['id'] ?? '',
      'projectName': project['name'] ?? '',
      'projectBeforeTime': project['approachDate'] ?? '',
      'projectProtect': project['reportProtect'] != null
          ? DateFormat('yyyy-MM-dd').format(
              DateTime.now().add(Duration(days: project['reportProtect'])))
          : '',
      'remarks': data['mark'] ?? '',
      'isSensitive': data['isSensitive'] ?? '',
    };
    if (clientsParams.length > 0) {
      params['customerReport'] = clientsParams;
    } else {
      ShowToast.normal('请输入客源信息');
      return;
    }
    // print('addReportRequest ==== $data');
    // print('data === $data');
    Http().post(
      Urls.addReport,
      Map<String, dynamic>.from(params),
      success: (json) {
        print('json === $json');
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          success(false);
        }
        // if (json['msg'] != null) {
        //   ShowToast.normal(json['msg']);
        // }
      },
      fail: (reason, code) {
        success(false);
        if (reason != null) {
          ShowToast.normal(reason);
        }
      },
    );
  }

  projectContact(int projectId, Function(bool success, List data) success,
      {Function() after}) {
    Http().get(
      Urls.projectContact,
      {'projectId': projectId},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true, json['data']);
          }
        } else {
          if (success != null) {
            success(false, null);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false, null);
        }
      },
      after: after,
    );
  }
}
