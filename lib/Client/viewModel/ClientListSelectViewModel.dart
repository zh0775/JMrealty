import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:dio/dio.dart';

class ClientListSelect1ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'102'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'103'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'104'})]).then((List<Response<dynamic>> e){
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
        Map res = (e[i]).data;
        print('res === $res');
        if(res['code'] == 200) {
          List reList = res['data'];
          print('reList === $reList');
          selectData[key] = [{'title':'全部','value': '-1'}];
          reList.forEach((element) {
            selectData[key].add({'title': element['dictLabel'], 'value': element['dictValue']});
          });
          print('selectData === $selectData');
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          state = BaseState.FAIL;
          notifyListeners();
        }
      }
    }).catchError((e){
      state = BaseState.FAIL;
      notifyListeners();
      print('error ==== $e');//[
    });
  }
}

class ClientListSelect2ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'102'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'103'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'104'})]).then((List<Response<dynamic>> e){
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
        Map res = ((e[i]).data)['data'];
        if(res['code'] == 200) {
          List reList = res['data'];
          selectData[key] = [{'title':'全部','value': '-1'}];
          reList.forEach((element) {
            selectData[key].add({'title': element['dictLabel'], 'value': element['dictValue']});
          });
          print('selectData === $selectData');
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          state = BaseState.FAIL;
          notifyListeners();
        }
      }
    }).catchError((e){
      state = BaseState.FAIL;
      notifyListeners();
      print('error ==== $e');//[
    });
  }
}

class ClientListSelect3ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'102'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'103'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'104'})]).then((List<Response<dynamic>> e){
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
        Map res = ((e[i]).data)['data'];
        if(res['code'] == 200) {
          List reList = res['data'];
          selectData[key] = [{'title':'全部','value': '-1'}];
          reList.forEach((element) {
            selectData[key].add({'title': element['dictLabel'], 'value': element['dictValue']});
          });
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          state = BaseState.FAIL;
          notifyListeners();
        }
      }
    }).catchError((e){
      state = BaseState.FAIL;
      notifyListeners();
      print('error ==== $e');//[
    });
  }
}

class ClientListSelect4ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'102'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'103'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'104'})]).then((List<Response<dynamic>> e){
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
        Map res = ((e[i]).data)['data'];
        if(res['code'] == 200) {
          List reList = res['data'];
          selectData[key] = [{'title':'全部','value': '-1'}];
          reList.forEach((element) {
            selectData[key].add({'title': element['dictLabel'], 'value': element['dictValue']});
          });
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          state = BaseState.FAIL;
          notifyListeners();
        }
      }
    }).catchError((e){
      state = BaseState.FAIL;
      notifyListeners();
      print('error ==== $e');//[
    });
  }
}

class ClientListSelect5ViewModel extends BaseViewModel{
  Map selectData = {'jb': [],'lx': [],'mj': []};

  loadSelectData() async{
    state = BaseState.LOADING;
    notifyListeners();
    await Future.wait([
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'102'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'103'}),
      Http().getDio().get(Urls.searchDic,queryParameters: {'dictId':'104'})]).then((List<Response<dynamic>> e){
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
        Map res = ((e[i]).data)['data'];
        if(res['code'] == 200) {
          List reList = res['data'];
          selectData[key] = [{'title':'全部','value': '-1'}];
          reList.forEach((element) {
            selectData[key].add({'title': element['dictLabel'], 'value': element['dictValue']});
          });
          state = BaseState.CONTENT;
          notifyListeners();
        } else {
          state = BaseState.FAIL;
          notifyListeners();
        }
      }
    }).catchError((e){
      state = BaseState.FAIL;
      notifyListeners();
      print('error ==== $e');//[
    });
  }
}