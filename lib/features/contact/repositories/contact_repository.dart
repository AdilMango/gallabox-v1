import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/models/paginated_response.dart';
import 'package:gallabox/core/services/http/http_service_provider.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/repositories/http_contact_repository.dart';

/// Provider to map [HttpContactRepository] implementation to
/// [ContactRepository] interface
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return HttpContactRepository(httpService);
});

/// Contact repository interface
abstract class ContactRepository {
  /// Server endpoints for contact
  String get path;

  /// Request to get a list of contacts
  Future<PaginatedResponse<Contact>> getContacts({
    int page = 1,
    bool forceRefresh = false,
  });

  /// Request to get a single Contact by Id
  Future<dynamic> getContact({required String contactId});
}
