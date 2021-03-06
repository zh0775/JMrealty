import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:dio/dio.dart';
// import 'package:dio/dio.dart';

class ClientListSelect1ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData({Function(Map data) success}) {
    state = BaseState.LOADING;
    notifyListeners();
    Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '130'}),
      Http().getDio().get(Urls.allTypeByCostomer),
    ]).then((List e) {
      // print('e111 ==== $e');//[true,true,false]
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
          case 3:
            key = 'time';
            break;
          case 4:
            key = 'source';
            break;
        }
        Map res = new Map<String, dynamic>.from((e[i]).data);
        // print('res === $res');
        if (res['code'] == 200) {
          List reList = [];
          if (key == 'source') {
            reList = ((res['data'])['customersOfSource']).map((value) {
              return value;
            }).toList();
          } else {
            reList = (res['data']).map((value) {
              return value;
            }).toList();
          }

          // print('reList === $reList');
          if (key != 'time') {
            selectData[key] = <Map<String, dynamic>>[
              {'title': '全部', 'value': '-1'}
            ];
          } else {
            selectData[key] = <Map<String, dynamic>>[];
          }
          reList.forEach((element) {
            Map<String, dynamic> e = Map<String, dynamic>.from(element);
            (selectData[key]).add({
              'title': levelFormat(e['dictLabel']),
              'value': e['dictValue']
            });
            // List list = selectData[key];
            // print('list === ${list.runtimeType}');
            // list.add(Map<String, dynamic>.from(element));
          });

          // print('selectData === $selectData');
        } else {
          state = BaseState.FAIL;
          notifyListeners();
          return;
        }
      }
      if (success != null) {
        success(selectData);
      }
      state = BaseState.CONTENT;
      notifyListeners();
    }).catchError((e) {
      state = BaseState.FAIL;
      notifyListeners();
      print('error 11==== $e'); //[
    });
  }

  customToPullRequest(int id, Function(bool success) success) {
    Http().post(
      Urls.customToPoll,
      {'id': id},
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

String levelFormat(String str) {
  if (str == 'A') {
    return 'A级';
  } else if (str == 'B') {
    return 'B级';
  } else if (str == 'C') {
    return 'C级';
  } else {
    return str;
  }
}

class ClientListSelect2ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};
  loadSelectData() async {
    state = BaseState.LOADING;
    notifyListeners();
    await UserDefault.get(ACCESS_TOKEN).then((token) {
      Dio dio = Http().getDio();
      if (token != null) {
        dio.options.headers['Authorization'] = token;
        Future.wait([
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '102'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '103'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '104'})
        ]).then((List e) {
          // print('e111 ==== $e');//[true,true,false]
          for (var i = 0; i < e.length; i++) {
            String key;
            switch (i) {
              case 0:
                key = 'jb';
                break;
              case 1:
                key = 'lx';
                break;
              case 2:
                key = 'mj';
                break;
            }
            Map res = new Map<String, dynamic>.from((e[i]).data);
            // print('res === $res');
            if (res['code'] == 200) {
              List reList = (res['data']).map((value) {
                return value;
              }).toList();
              // print('reList === $reList');
              selectData[key] = <Map<String, dynamic>>[
                {'title': '全部', 'value': '-1'}
              ];
              reList.forEach((element) {
                Map<String, dynamic> e = Map<String, dynamic>.from(element);
                (selectData[key])
                    .add({'title': e['dictLabel'], 'value': e['dictValue']});
                // List list = selectData[key];
                // print('list === ${list.runtimeType}');
                // list.add(Map<String, dynamic>.from(element));
              });
              // print('selectData === $selectData');
            } else {
              state = BaseState.FAIL;
              notifyListeners();
              return;
            }
          }
          state = BaseState.CONTENT;
          notifyListeners();
        }).catchError((e) {
          state = BaseState.FAIL;
          notifyListeners();
          print('error 11==== $e'); //[
        });
      }
    });
  }
}

class ClientListSelect3ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};
  loadSelectData() async {
    state = BaseState.LOADING;
    notifyListeners();
    await UserDefault.get(ACCESS_TOKEN).then((token) {
      Dio dio = Http().getDio();
      if (token != null) {
        dio.options.headers['Authorization'] = token;
        Future.wait([
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '102'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '103'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '104'})
        ]).then((List e) {
          // print('e111 ==== $e');//[true,true,false]
          for (var i = 0; i < e.length; i++) {
            String key;
            switch (i) {
              case 0:
                key = 'jb';
                break;
              case 1:
                key = 'lx';
                break;
              case 2:
                key = 'mj';
                break;
            }
            Map res = new Map<String, dynamic>.from((e[i]).data);
            // print('res === $res');
            if (res['code'] == 200) {
              List reList = (res['data']).map((value) {
                return value;
              }).toList();
              // print('reList === $reList');
              selectData[key] = <Map<String, dynamic>>[
                {'title': '全部', 'value': '-1'}
              ];
              reList.forEach((element) {
                Map<String, dynamic> e = Map<String, dynamic>.from(element);
                (selectData[key])
                    .add({'title': e['dictLabel'], 'value': e['dictValue']});
                // List list = selectData[key];
                // print('list === ${list.runtimeType}');
                // list.add(Map<String, dynamic>.from(element));
              });
              // print('selectData === $selectData');
            } else {
              state = BaseState.FAIL;
              notifyListeners();
              return;
            }
          }
          state = BaseState.CONTENT;
          notifyListeners();
        }).catchError((e) {
          state = BaseState.FAIL;
          notifyListeners();
          print('error 11==== $e'); //[
        });
      }
    });
  }
}

class ClientListSelect4ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};
  loadSelectData() async {
    state = BaseState.LOADING;
    notifyListeners();
    await UserDefault.get(ACCESS_TOKEN).then((token) {
      Dio dio = Http().getDio();
      if (token != null) {
        dio.options.headers['Authorization'] = token;
        Future.wait([
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '102'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '103'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '104'})
        ]).then((List e) {
          // print('e111 ==== $e');//[true,true,false]
          for (var i = 0; i < e.length; i++) {
            String key;
            switch (i) {
              case 0:
                key = 'jb';
                break;
              case 1:
                key = 'lx';
                break;
              case 2:
                key = 'mj';
                break;
            }
            Map res = new Map<String, dynamic>.from((e[i]).data);
            // print('res === $res');
            if (res['code'] == 200) {
              List reList = (res['data']).map((value) {
                return value;
              }).toList();
              // print('reList === $reList');
              selectData[key] = <Map<String, dynamic>>[
                {'title': '全部', 'value': '-1'}
              ];
              reList.forEach((element) {
                Map<String, dynamic> e = Map<String, dynamic>.from(element);
                (selectData[key])
                    .add({'title': e['dictLabel'], 'value': e['dictValue']});
                // List list = selectData[key];
                // print('list === ${list.runtimeType}');
                // list.add(Map<String, dynamic>.from(element));
              });
              // print('selectData === $selectData');
            } else {
              state = BaseState.FAIL;
              notifyListeners();
              return;
            }
          }
          state = BaseState.CONTENT;
          notifyListeners();
        }).catchError((e) {
          state = BaseState.FAIL;
          notifyListeners();
          print('error 11==== $e'); //[
        });
      }
    });
  }
}

class ClientListSelect5ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};
  loadSelectData() async {
    state = BaseState.LOADING;
    notifyListeners();
    await UserDefault.get(ACCESS_TOKEN).then((token) {
      Dio dio = Http().getDio();
      if (token != null) {
        dio.options.headers['Authorization'] = token;
        Future.wait([
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '102'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '103'}),
          Http()
              .getDio()
              .get(Urls.searchDic, queryParameters: {'dictId': '104'})
        ]).then((List e) {
          // print('e111 ==== $e');//[true,true,false]
          for (var i = 0; i < e.length; i++) {
            String key;
            switch (i) {
              case 0:
                key = 'jb';
                break;
              case 1:
                key = 'lx';
                break;
              case 2:
                key = 'mj';
                break;
            }
            Map res = new Map<String, dynamic>.from((e[i]).data);
            // print('res === $res');
            if (res['code'] == 200) {
              List reList = (res['data']).map((value) {
                return value;
              }).toList();
              // print('reList === $reList');
              selectData[key] = <Map<String, dynamic>>[
                {'title': '全部', 'value': '-1'}
              ];
              reList.forEach((element) {
                Map<String, dynamic> e = Map<String, dynamic>.from(element);
                (selectData[key])
                    .add({'title': e['dictLabel'], 'value': e['dictValue']});
                // List list = selectData[key];
                // print('list === ${list.runtimeType}');
                // list.add(Map<String, dynamic>.from(element));
              });
              // print('selectData === $selectData');
            } else {
              state = BaseState.FAIL;
              notifyListeners();
              return;
            }
          }
          state = BaseState.CONTENT;
          notifyListeners();
        }).catchError((e) {
          state = BaseState.FAIL;
          notifyListeners();
          print('error 11==== $e'); //[
        });
      }
    });
  }
}
