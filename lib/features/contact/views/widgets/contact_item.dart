import 'package:flutter/material.dart';
import 'package:gallabox/features/contact/models/contact.dart';

/// Contact widget
class ContactItem extends StatelessWidget {
  /// Creates an instance of [ContactItem]
  const ContactItem({
    super.key,
    required this.contacts,
  });

  /// Contacts list
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            title: Text('${contacts[index].name}'),
          );
        },
        childCount: contacts.length,
      ),
    );
  }
}
