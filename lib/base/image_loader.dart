import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageLoader extends StatelessWidget {
  final String imgUrl;
  final double height;
  final BoxFit fit;
  final LoadingErrorWidgetBuilder errorWidget;
  final PlaceholderWidgetBuilder placeholder;
  ImageLoader(this.imgUrl,
      {this.height,
      this.fit = BoxFit.cover,
      this.placeholder,
      this.errorWidget});

  @override
  Widget build(BuildContext context) {
    precacheImage(
      CachedNetworkImageProvider(imgUrl),
      context,
      onError: (exception, stackTrace) {},
    );
    try {
      return CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 1),
        placeholderFadeInDuration: Duration(milliseconds: 1),
        fadeOutDuration: Duration(milliseconds: 1),

        imageUrl: imgUrl,
        // height: this.height,
        placeholder: placeholder,

        // placeholder: (context, url) {
        //   return Image.asset(
        //     'assets/images/home/motivation_monochromatic.png',
        //     // width: context.size.width, height: context.size.height
        //   );
        // },
        cacheManager: CustomCacheManagerWithHandler(),
        errorWidget: errorWidget != null
            ? errorWidget
            : (context, url, error) {
                return Image.asset(
                  'assets/images/icon/icon_default_min.png',
                  // width: context.size.width,
                  // height: context.size.height,
                );
              },
        // height: height,
        fit: fit,
      );
    } catch (e) {
      return Image.asset(
        'assets/images/icon/icon_default_min.png',
        // width: context.size.width,
        // height: context.size.height,
      );
    }
  }
}

class CustomCacheManagerWithHandler extends CacheManager {
  static const key = 'CustomCacheManagerWithHandlerImageData';
  static CustomCacheManagerWithHandler _instance;
  factory CustomCacheManagerWithHandler() {
    _instance ??= CustomCacheManagerWithHandler._();
    return _instance;
  }

  CustomCacheManagerWithHandler._()
      : super(Config(key, fileService: EsoHttpFileService()));

  @override
  Stream<FileResponse> getFileStream(String url,
      {String key, Map<String, String> headers, bool withProgress}) async* {
    var stream = super.getFileStream(url,
        key: key, headers: headers, withProgress: withProgress);
    try {
      await for (var value in stream) {
        yield value;
      }
    } catch (_) {
      yield null;
    }

    // return super.getFileStream(url, key, headers, withProgress);
  }
}

class EsoHttpFileService extends FileService {
  HttpClient _httpClient;
  EsoHttpFileService({HttpClient httpClient}) {
    _httpClient = httpClient ?? HttpClient();
    _httpClient.badCertificateCallback = (cert, host, port) => true;
  }

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String> headers = const {}}) async {
    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest req = await _httpClient.getUrl(resolved);
    headers?.forEach((key, value) {
      req.headers.add(key, value);
    });
    final HttpClientResponse httpResponse = await req.close();
    final http.StreamedResponse _response = http.StreamedResponse(
      httpResponse.timeout(Duration(seconds: 60)),
      httpResponse.statusCode,
      contentLength: httpResponse.contentLength,
      reasonPhrase: httpResponse.reasonPhrase,
      isRedirect: httpResponse.isRedirect,
    );
    return HttpGetResponse(_response);
  }
}
