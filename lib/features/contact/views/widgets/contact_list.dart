import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/configs/styles/ui_constants.dart';
import 'package:gallabox/core/widgets/error_view.dart';
import 'package:gallabox/core/widgets/list_item_shimmer.dart';
import 'package:gallabox/features/contact/providers/contact_count_provider.dart';
import 'package:gallabox/features/contact/providers/current_contact_provider.dart';
import 'package:gallabox/features/contact/providers/paginated_contact_provider.dart';
import 'package:gallabox/features/contact/views/widgets/contact_list_item.dart';

/// Widget holds the contact list
class ContactList extends ConsumerWidget {
  /// Creates new instance of [ContactList]
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactCount = ref.watch(contactCountProvider);
    return contactCount.when(
      data: (int count) {
        return ListView.builder(
          itemCount: count,
          itemExtent: UIConstants.personListItemHeight,
          itemBuilder: (context, index) {
            final currentContactFromIndex =
                //ignore: lines_longer_than_80_chars
                ref.watch(paginatedContactProvider(index ~/ 20)).whenData((pageData) => pageData.results[index % 20]);
            return ProviderScope(
              //ignore: lines_longer_than_80_chars
              overrides: [currentContactProvider.overrideWithValue(currentContactFromIndex)],
              child: const ContactListItem(),
            );
          },
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        debugPrint('Error fetching contact');
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        return const ErrorView();
      },
      loading: () => const ListItemShimmer(),
    );
  }
}
