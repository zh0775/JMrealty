import 'dart:convert';

import 'package:JMrealty/utils/toast.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:dio/dio.dart';
import 'http_config.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class Http {
  static Dio _dio;
  static Http _http = Http();

  static Http getInstence() {
    return _http;
  }

  Http() {
    if (_dio == null) {
      _dio = createDio();
      log(_dio);
    }
  }

  Dio createDio() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT);
    Dio dio = Dio(baseOptions);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      UserDefault.get('access_token').then((token) {
        if (token != null) {
          options.headers['Authorization'] = token;
        }
        return options;
      });
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) {
      return e;
    }));
    return dio;
  }

  Dio getDio() {
    return _dio;
  }

  Future<void> get(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after}) async {
    try {
      await _dio.get(url, queryParameters: params).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          if (data['code'] != 200) {
            ShowToast.normal(data['msg']);
          }
          if (success != null) {
            success(response.data);
          }
        } else {
          if (fail != null) {
            fail(response.statusMessage, response.statusCode);
          }
        }
        if (after != null) {
          after();
        }
      });
    } catch (e) {
      if (fail != null) {
        fail('网络发生错误', -1);
      }
    }
  }

  Future<void> post(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after}) async {
    try {
      await _dio.post(url, data: json.encode(params)).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          if (data['code'] != 200) {
            ShowToast.normal(data['msg']);
          }
          if (success != null) {
            success(response.data);
          }
        } else {
          if (fail != null) {
            fail(response.statusMessage, response.statusCode);
          }
        }
        if (after != null) {
          after();
        }
      });
    } catch (e) {
      if (fail != null) {
        fail('网络发生错误', -1);
      }
    }
  }

  Future<void> custom(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after, int timeOut, method}) async {
    try {
      await _dio.post(url, data: json.encode(params)).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          if (data['code'] != 200) {
            ShowToast.normal(data['msg']);
          }
          if (success != null) {
            success(response.data);
          }
        } else {
          if (fail != null) {
            fail(response.statusMessage, response.statusCode);
          }
        }
        if (after != null) {
          after();
        }
      });
    } catch (e) {
      if (fail != null) {
        fail('网络发生错误', -1);
      }
    }
  }

  void log(Dio _dio) {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print(
          "\n================================= 请求数据 =================================");
      print("method = ${options.method.toString()}");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.queryParameters}");
      print("params = ${options.data}");
    }, onResponse: (Response response) {
      print(
          "\n================================= 响应数据开始 =================================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print(
          "================================= 响应数据结束 =================================\n");
    }, onError: (DioError e) {
      print(
          "\n=================================错误响应数据 =================================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      // print("stackTrace = ${e.}");
      print("\n");
    }));
  }
}
