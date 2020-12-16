import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ClientPoolViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData(void Function(Map data) success) async {
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List e) {
      for (var i = 0; i < e.length; i++) {
        String key;
        switch (i) {
          case 0:
            key = 'jb';
            break;
          case 1:
            key = 'mj';
            break;
          case 2:
            key = 'lx';
            break;
        }
        Map res = new Map<String, dynamic>.from((e[i]).data);
        // print('res === $res');
        if (res['code'] == 200) {
          List reList = (res['data']).map((value) {
            return value;
          }).toList();
          selectData[key] = <Map<String, dynamic>>[
            {'title': '全部', 'value': '-1'}
          ];
          reList.forEach((element) {
            Map<String, dynamic> e = Map<String, dynamic>.from(element);
            (selectData[key])
                .add({'title': e['dictLabel'], 'value': e['dictValue']});
          });
        } else {
          return;
        }
      }
      success(selectData);
    }).catchError((e) {});
  }

  Map listData;
  loadClientPoolList({Map params = const {}, Function(Map data) success}) {
    // state = BaseState.LOADING;
    // notifyListeners();
    Http().get(
      Urls.findCustomerPoolInfo,
      params,
      success: (json) {
        if (json['code'] == 200) {
          listData = json['data'];
          print('listData === $listData');
          if(success != null) {
            success(listData);
          }
          // state = BaseState.CONTENT;
        } else {
          // state = BaseState.FAIL;
          // ShowToast.normal(json['msg']);
        }
        // notifyListeners();
        // print('object')
      },
      fail: (reason, code) {
        // state = BaseState.FAIL;
        // ShowToast.normal(reason);
        // notifyListeners();
      },
    );
  }

  takeClientRequest(int id, void Function() success) {
    Http().post(
      Urls.takeCustomerInPool,
      {'id': id},
      success: (json) {
        if (json['code'] == 200) {
          success();
        }
        if (json['msg'] != null) {
          ShowToast.normal(json['msg']);
        }
      },
      fail: (reason, code) {
        ShowToast.normal(reason);
      },
    );
  }
}
