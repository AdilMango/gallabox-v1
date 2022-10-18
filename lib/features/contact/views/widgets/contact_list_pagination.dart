import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/widgets/shimmer/shimmer.dart';
import 'package:gallabox/features/contact/providers/contact_provider.dart';
import 'package:gallabox/features/contact/views/widgets/contact_item.dart';

/// Contact List widget
class ContactList extends StatelessWidget {
  /// Creates an instance of [ContactList]
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(contactsProvider);
        return state.when(
          data: (items) {
            return items.isEmpty
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(contactsProvider.notifier).fetchFirstPage();
                          },
                          icon: const Icon(Icons.replay),
                        ),
                        const Chip(label: Text('No items Found!')),
                      ],
                    ),
                  )
                : ContactItem(contacts: items);
          },
          loading: () => const SliverToBoxAdapter(
            child: Center(child: ShimmerWidget()),
          ),
          error: (e, stk) => SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: const [
                  Icon(Icons.info),
                  SizedBox(height: 20),
                  Text(
                    'Something Went Wrong!',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          onGoingLoading: (items) => ContactItem(contacts: items),
          onGoingError: (items, e, stk) => ContactItem(contacts: items),
        );
      },
    );
  }
}
