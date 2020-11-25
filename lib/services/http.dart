import 'dart:convert';

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
    }
  }

  Dio createDio() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT);
    return Dio(baseOptions);
  }

  Future<void> get(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after}) async {
    try {
      await _dio.get(url, queryParameters: params).then((response) {
        if (response.statusCode == 200) {
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
    return Future.value();
  }

  Future<void> post(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after}) async {
    try {
      await _dio.post(url, data: json.encode(params)).then((response) {
        if (response.statusCode == 200) {
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
    return Future.value();
  }
  // void request(String url,
  //     {String method = 'get', Map<String, dynamic> params}) {
  //   BaseOptions baseOptions =
  //       BaseOptions(baseUrl: BASE_URL, connectTimeout: TIMEOUT);
  //   final dio = Dio(baseOptions);
  //   Options options = Options(method: method);
  //   dio.request(url, queryParameters: params, options: options);
  // }

  Future<void> custom(String url, Map<String, dynamic> params,
      {Success success, Fail fail, After after,int timeOut, method}) async {
    try {
      await _dio.post(url, data: json.encode(params)).then((response) {
        if (response.statusCode == 200) {
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
    return Future.value();
  }
}


