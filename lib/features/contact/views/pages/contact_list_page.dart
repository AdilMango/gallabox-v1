import 'package:flutter/material.dart';
import 'package:gallabox/features/contact/views/widgets/contact_list.dart';

/// Widget for contact list
class ContactListPage extends StatelessWidget {
  /// Creates a new instance of [ContactListPage]
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ContactList());
  }
}
