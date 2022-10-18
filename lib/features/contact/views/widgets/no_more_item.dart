import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/features/contact/providers/contact_provider.dart';

/// No more items after pagination ends widget
class NoMoreItems extends ConsumerWidget {
  /// Creates an instance of [NoMoreItems]
  const NoMoreItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactsProvider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        data: (items) {
          final _noMoreItems = ref.read(contactsProvider.notifier).noMoreItems;
          return _noMoreItems
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'No More Items Found!',
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
