import 'package:dio/dio.dart';
import 'http_config.dart';

class HttpRequest {
  void request(String url,
      {String method = 'get', Map<String, dynamic> params}) {
    BaseOptions baseOptions =
        BaseOptions(baseUrl: BASE_URL, connectTimeout: TIMEOUT);
    final dio = Dio(baseOptions);
    Options options = Options(method: method);
    dio.request(url, queryParameters: params, options: options);
  }
}
