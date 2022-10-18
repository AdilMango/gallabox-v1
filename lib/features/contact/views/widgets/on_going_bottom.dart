import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/features/contact/providers/contact_provider.dart';

/// OnGoingWidget when pagination loading
class OnGoingBottomWidget extends StatelessWidget {
  /// Creates an instances of [OnGoingBottomWidget]
  const OnGoingBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(contactsProvider);
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              //ignore: lines_longer_than_80_chars
              onGoingLoading: (items) => const Center(child: CircularProgressIndicator()),
              onGoingError: (items, e, stk) => Center(
                child: Column(
                  children: const [
                    Icon(Icons.info),
                    SizedBox(height: 20),
                    Text(
                      'Something Went Wrong!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
