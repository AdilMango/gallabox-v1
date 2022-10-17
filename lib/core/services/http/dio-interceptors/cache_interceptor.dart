import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallabox/core/configs/configs.dart';
import 'package:gallabox/core/models/cache_response.dart';
import 'package:gallabox/core/services/storage/storage_service.dart';

/// Dio interceptor used to cache http response in local storage
class CacheInterceptor implements Interceptor {
  /// Creates new instance of [CacheInterceptor]
  CacheInterceptor(this.storageService);

  /// Storage service used to store cache in local storage
  final StorageService storageService;

  /// Helper method to create a storage key from req/res information
  String createStorageKey(String method,
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

  /// Method that intercepts Dio request
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[Configs.dioCacheForceRefreshKey] == true) {
      debugPrint('🌍 🌍 🌍 Retrieving request from network by force refresh');
      return handler.next(options);
    }
    final storageKey = createStorageKey(
      options.method,
      options.baseUrl,
      options.path,
      options.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        debugPrint('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildResponse(options);
        debugPrint('⬅️ ⬅️ ⬅️ Response');
        // ignore: lines_longer_than_80_chars
        debugPrint(
            '<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        debugPrint('Query params: ${response.requestOptions.queryParameters}');
        debugPrint('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(options);
  }

  /// Method that intercepts Dio response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final storageKey = createStorageKey(
      response.requestOptions.method,
      response.requestOptions.baseUrl,
      response.requestOptions.path,
      response.requestOptions.queryParameters,
    );

    // ignore: lines_longer_than_80_chars
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      debugPrint('🌍 🌍 🌍 Retrieved response from network');
      debugPrint('⬅️ ⬅️ ⬅️ Response');
      // ignore: lines_longer_than_80_chars
      debugPrint(
          '<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      debugPrint('Query params: ${response.requestOptions.queryParameters}');
      debugPrint('-------------------------');

      final cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: clock.now(),
        statusCode: response.statusCode!,
      );
      storageService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _getCachedResponse(String storageKey) {
    final dynamic rawCachedResponse = storageService.get(storageKey);
    try {
      final cachedResponse = CachedResponse.fromJson(
        json.decode(json.encode(rawCachedResponse)) as Map<String, dynamic>,
      );
      if (cachedResponse.isValid) {
        return cachedResponse;
      } else {
        debugPrint('Cache is outdated, deleting it...');
        storageService.remove(storageKey);
        return null;
      }
    } catch (e) {
      debugPrint('Error retrieving response from cache');
      debugPrint('e: $e');
      return null;
    }
  }
}
