import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/services/storage/hive_storage_provider.dart';
import 'package:gallabox/core/services/storage/storage_service.dart';
import 'package:gallabox/core/services/storage/storage_service_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      await Hive.initFlutter();
      final StorageService initializedStorageService = HiveStorageService();
      await initializedStorageService.init();
      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(initializedStorageService),
          ],
          child: const Center(),
        ),
      );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}
