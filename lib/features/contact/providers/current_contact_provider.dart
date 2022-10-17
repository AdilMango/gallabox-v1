import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/features/contact/models/contact.dart';

/// The provider that provides the Contact data for each list item
///
/// Initially it throws an UnimplementedError because we won't use it
/// before overriding it
final currentContactProvider = Provider<AsyncValue<Contact>>((ref) {
  throw UnimplementedError();
});
