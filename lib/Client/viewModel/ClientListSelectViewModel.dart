import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:dio/dio.dart';

class ClientListSelect1ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData() async {
    if ((selectData['jb']).length > 0) {
      return;
    }
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List<Response<dynamic>> e) {
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
}

class ClientListSelect2ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData() async {
    if ((selectData['jb']).length > 0) {
      return;
    }
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List<Response<dynamic>> e) {
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
          break;
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
}

class ClientListSelect3ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData() async {
    if ((selectData['jb']).length > 0) {
      return;
    }
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List<Response<dynamic>> e) {
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
          break;
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
}

class ClientListSelect4ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData() async {
    if ((selectData['jb']).length > 0) {
      return;
    }
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List<Response<dynamic>> e) {
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
          break;
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
}

class ClientListSelect5ViewModel extends BaseViewModel {
  Map selectData = {'jb': [], 'lx': [], 'mj': []};

  loadSelectData() async {
    if ((selectData['jb']).length > 0) {
      return;
    }
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '102'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '103'}),
      Http().getDio().get(Urls.searchDic, queryParameters: {'dictId': '104'})
    ]).then((List<Response<dynamic>> e) {
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
          break;
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
}
