import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/services/http/dio_http_service.dart';
import 'package:gallabox/core/services/http/http_service.dart';
import 'package:gallabox/core/services/storage/storage_service_provider.dart';

/// Provider that maps an [HttpService] interface to implementation
final httpServiceProvider = Provider<HttpService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return DioHttpService(storageService);
});
