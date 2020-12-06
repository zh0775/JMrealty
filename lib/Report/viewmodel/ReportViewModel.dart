import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ReportViewModel extends BaseViewModel {
  List projectData;
  loadProjectList(String name, {Function(List data) success}) {
    Http().get(
      Urls.projectFuzzySearch,
      {'name': name},
      success: (json) {
        if (json['code'] != null && json['code'] == 200) {
          projectData = (json['data'])['rows'];
          if (success != null) {
            success(projectData);
          }
        }
        // print('projectFuzzySearch === $json');
      },
      fail: (reason, code) {},
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
    List clients = data['client'];
    Map agent = data['agent'];
    Map project = data['project'];

    List clientsParams = [];
    Map<String, dynamic> params = {};
    clients.forEach((element) {
      Map client = {
        'csutomerPhone': element['csutomerPhone'],
        'custmoerCard': element['custmoerCard'],
        'custmoerSex': element['sex'],
        'customerId': element['id'],
        'customerName': element['name'],
      };
      clientsParams.add(client);
    });
    params = {
      'company': project['name'],
      'companyId': project['id'],
      'employeeId': agent['id'],
      'employeeName': agent['userName'],
      'employeePhone': agent['phonenumber'],
      'projectId': project['id'],
      'projectName': project['name'],
      'remarks': data['mark'],
    };
    params['customerReport'] = clientsParams;

    print('data === $data');
    Http().post(
      Urls.addReport,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          success(false);
        }
        ShowToast.normal(json['msg']);
      },
      fail: (reason, code) {
        success(false);
        ShowToast.normal(reason);
      },
    );
  }
}
