import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/services/storage/hive_storage_provider.dart';
import 'package:gallabox/core/services/storage/storage_service.dart';

/// Provider that locates an [StorageService] interface to implementation
final storageServiceProvider = Provider<StorageService>(
  (_) => HiveStorageService(),
);
