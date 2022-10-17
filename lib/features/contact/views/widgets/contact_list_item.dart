import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/widgets/error_view.dart';
import 'package:gallabox/core/widgets/list_item_shimmer.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/providers/current_contact_provider.dart';

/// Widget holding a list item in the contact list
class ContactListItem extends ConsumerWidget {
  /// Creates a new instance of [ContactListItem]
  const ContactListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactAsync = ref.watch(currentContactProvider);
    return Container(
      child: contactAsync.when(
        data: (Contact contact) {
          return Text(contact.name ?? 'no name');
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current popular person');
          log(error.toString());
          if (error is FormatException) {
            log('Format Exception: ${error.source}');
          }
          return const ErrorView();
        },
        loading: () => const ListItemShimmer(),
      ),
    );
  }
}
