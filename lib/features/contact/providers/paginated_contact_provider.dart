import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/models/pagination/paginated_response.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/repositories/contact_repository.dart';

/// FutureProvider that fetches paginated contact list
final paginatedContactProvider = FutureProvider.family<PaginatedResponse<Contact>, int>(
      (ref, int pageIndex) async {
    debugPrint(' paginated contact provider ');
    final contactRepository = ref.watch(contactRepositoryProvider);
    return contactRepository.getContacts(page: pageIndex);
  },
);
