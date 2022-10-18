import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/features/contact/providers/contact_provider.dart';
import 'package:gallabox/features/contact/views/widgets/contact_list_pagination.dart';
import 'package:gallabox/features/contact/views/widgets/no_more_item.dart';
import 'package:gallabox/features/contact/views/widgets/on_going_bottom.dart';

/// Widget for contact list
class ContactListPage extends ConsumerWidget {
  /// Creates a new instance of [ContactListPage]
  ContactListPage({super.key});

  /// Scroll controller for contact list scroll view
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      //ignore: omit_local_variable_types
      final double maxScroll = scrollController.position.maxScrollExtent;
      //ignore: omit_local_variable_types
      final double currentScroll = scrollController.position.pixels;
      //ignore: omit_local_variable_types
      final double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref.read(contactsProvider.notifier).fetchNextPage();
      }
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        restorationId: 'contact list',
        slivers: const [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('Contact Pagination'),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          ContactList(),
          NoMoreItems(),
          OnGoingBottomWidget(),
        ],
      ),
    );
  }
}
