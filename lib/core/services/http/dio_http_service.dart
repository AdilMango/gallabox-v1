import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallabox/core/configs/configs.dart';
import 'package:gallabox/core/exceptions/http_exception.dart';
import 'package:gallabox/core/services/http/dio-interceptors/cache_interceptor.dart';
import 'package:gallabox/core/services/http/http_service.dart';
import 'package:gallabox/core/services/storage/storage_service.dart';

/// Http service implementation using the Dio package
class DioHttpService implements HttpService {
  /// Create new instance of [DioHttpService]
  DioHttpService(
    this.storageService, {
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );
    if (enableCaching) {
      dio.interceptors.add(CacheInterceptor(storageService));
    }
  }

  /// Storage service used for caching http response
  final StorageService storageService;

  /// The Dio Http client
  late final Dio dio;

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => Configs.apiBaseUrl;

  @override
  Map<String, String> headers = {'accept': 'application/json', 'content-type': 'application/json'};

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  }) async {
    await setToken();
    dio.options.extra[Configs.dioCacheForceRefreshKey] = forceRefresh;
    final response = await dio.get<dynamic>(
      endpoint,
      queryParameters: queryParameters,
    );
    if (response.data == null || response.statusCode != 200) {
      throw HttpException(
        title: 'Http Error!',
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }
    return {'results': response.data};
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response<dynamic> response = await dio.post<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );
    if (response.data == null || response.statusCode != 200) {
      throw HttpException(
        title: 'Http Error!',
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }
    return response.data;
  }

  @override
  Future<dynamic> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  }) async {
    await setToken();
    dio.options.extra[Configs.dioCacheForceRefreshKey] = forceRefresh;
    final response = await dio.patch<dynamic>(
      endpoint,
      queryParameters: queryParameters,
    );
    if (response.data == null || response.statusCode != 200) {
      throw HttpException(
        title: 'Http Error!',
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }
    return {'results': response.data};
  }

  /// Set fake token for testing
  Future<void> setToken() async {
    debugPrint(' Token ');
    //final token = await getToken();
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InlvZ2VzaEBtYW5nb2xlYXAuY29tIiwibmFtZSI6IllvZ2VzaCIsImlkIjoiNjAwNWVjNDA1ZGRkNzEwMDA0MzIzOTBjIiwiaWF0IjoxNjY2MTA2MjMxLCJleHAiOjE2NjY5NzAyMzF9.jeNze44gDq29Kx8r-A2lQzEo7kQLn2bmh99g_N5KC-k';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
