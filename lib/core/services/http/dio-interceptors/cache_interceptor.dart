import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallabox/core/services/storage/storage_service.dart';

/// Dio interceptor used to cache http response in local storage
class CacheInterceptor implements Interceptor {
  /// Creates new instance of [CacheInterceptor]
  CacheInterceptor(this.storageService);

  /// Storage service used to store cache in local storage
  final StorageService storageService;

  /// Helper method to create a storage key from req/res information
  String createStorageKey(
    String method,
    String baseUrl,
    String path, [
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  ]) {
    var storageKey = '${method.toUpperCase()}:${baseUrl + path}/';
    if (queryParameters.isNotEmpty) {
      storageKey += '?';
      queryParameters.forEach((key, dynamic value) {
        storageKey += '$key=$value';
      });
    }
    return storageKey;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('❌ Dio Error! ❌');
    debugPrint('❌ Url: ${err.requestOptions.uri} ❌');
    debugPrint('❌ ${err.stackTrace} ❌');
    debugPrint('❌ Response Errors: ${err.response?.data} ❌');
    final storageKey = createStorageKey(
      err.requestOptions.method,
      err.requestOptions.baseUrl,
      err.requestOptions.path,
      err.requestOptions.queryParameters,
    );
    if (storageService.has(storageKey)) {
      //final cachedResponse = _getCachedResponse(storageKey);
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
  }
}
