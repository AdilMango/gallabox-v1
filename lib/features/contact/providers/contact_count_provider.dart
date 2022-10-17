import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/models/paginated_response.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/providers/paginated_contact_provider.dart';

/// Contact count provider
final contactCountProvider = Provider<AsyncValue<int>>((ref) {
  debugPrint('contact count provider');
  return ref.watch(paginatedContactProvider(0)).whenData(
        (
          PaginatedResponse<Contact> pageData,
        ) =>
            pageData.totalResults,
      );
});
