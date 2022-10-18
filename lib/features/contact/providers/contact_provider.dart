import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/models/pagination/pagination_notifier.dart';
import 'package:gallabox/core/models/pagination/pagination_state.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/repositories/contact_repository.dart';

/// Contact Provider to get all contact list from server
//ignore: lines_longer_than_80_chars
final contactsProvider = StateNotifierProvider<PaginationNotifier<Contact>, PaginationState<Contact>>((ref) {
  return PaginationNotifier(
    limit: 20,
    fetchNextItems: (int page) {
      final contactRepository = ref.watch(contactRepositoryProvider);
      return contactRepository.getContactsPagination(page: page);
    },
  )..init();
});
