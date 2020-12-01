import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';

class ClientListSelect1ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  Future dic1 = Http().get(
    Urls.searchDic,
    {'dictId':'102'},
    success: (json) {
      List selectArr = (json['data'] as List)?.map((e) => null)?.toList();
      // selectData['jb'] = selectArr;
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {},);
  Future dic2 = Http().get(
    Urls.searchDic,
    {'dictId':'103'},
    success: (json) {
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {});
  Future dic3 = Http().get(
    Urls.searchDic,
    {'dictId':'104'},
    success: (json) {
    // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {});

    loadSelectData() async{
      state = BaseState.LOADING;
      notifyListeners();
      await Future.wait<dynamic>([dic1,dic2,dic3]).then((e){
        print('e ==== $e');//[true,true,false]
      }).catchError((e){

      });
    }
}

class ClientListSelect2ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  Future dic1 = Http().get(
    Urls.searchDic,
    {'dictId':'102'},
    success: (json) {
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {},);
  Future dic2 = Http().get(
      Urls.searchDic,
      {'dictId':'103'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});
  Future dic3 = Http().get(
      Urls.searchDic,
      {'dictId':'104'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait<dynamic>([dic1,dic2,dic3]).then((e){
      print('e ==== $e');//[true,true,false]
    }).catchError((e){

    });
  }
}

class ClientListSelect3ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  Future dic1 = Http().get(
    Urls.searchDic,
    {'dictId':'102'},
    success: (json) {
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {},);
  Future dic2 = Http().get(
      Urls.searchDic,
      {'dictId':'103'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});
  Future dic3 = Http().get(
      Urls.searchDic,
      {'dictId':'104'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait<dynamic>([dic1,dic2,dic3]).then((e){
      print('e ==== $e');//[true,true,false]
    }).catchError((e){

    });
  }
}

class ClientListSelect4ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  Future dic1 = Http().get(
    Urls.searchDic,
    {'dictId':'102'},
    success: (json) {
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {},);
  Future dic2 = Http().get(
      Urls.searchDic,
      {'dictId':'103'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});
  Future dic3 = Http().get(
      Urls.searchDic,
      {'dictId':'104'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];
        print('json');
      },
      fail: (reason, code) {},
      after: () {});

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait<dynamic>([dic1,dic2,dic3]).then((e){
      print('e ==== $e');//[true,true,false]
    }).catchError((e){

    });
  }
}

class ClientListSelect5ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  Future dic1 = Http().get(
    Urls.searchDic,
    {'dictId':'102'},
    success: (json) {
      // Map<String, dynamic> data = json['data'];

    },
    fail: (reason, code) {},
    after: () {},);
  Future dic2 = Http().get(
      Urls.searchDic,
      {'dictId':'103'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});
  Future dic3 = Http().get(
      Urls.searchDic,
      {'dictId':'104'},
      success: (json) {
        // Map<String, dynamic> data = json['data'];

      },
      fail: (reason, code) {},
      after: () {});

  loadSelectData() async{
    print('222');
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait<dynamic>([dic1,dic2,dic3]).then((e){
      print('e ==== $e');//[true,true,false]
    }).catchError((e){

    });
  }
}