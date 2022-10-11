import 'package:gallabox/core/models/paginated_response.dart';
import 'package:gallabox/core/services/http/http_service.dart';
import 'package:gallabox/features/contact/models/contact.dart';
import 'package:gallabox/features/contact/repositories/contact_repository.dart';

/// Http implementation of the [HttpContactRepository]
class HttpContactRepository implements ContactRepository {
  /// Creates a instance of [HttpContactRepository]
  HttpContactRepository(this.httpService);

  /// Http service used to access an http client and make calls
  final HttpService httpService;

  @override
  String get path => 'account/5fabbd9cadeec70004392ed4 /contacts';

  @override
  Future<dynamic> getContact({required String contactId}) {
    // TODO: implement getContact
    throw UnimplementedError();
  }

  @override
  Future<PaginatedResponse<Contact>> getContacts({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      '$path/account',
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'page': page,
      },
    );
    return PaginatedResponse.fromJson(
      results: [
        const Contact(
          id: 'id-1',
          name: 'name1',
          email: ['adil1'],
          phone: ['908'],
        ),
        const Contact(
          id: 'id-12',
          name: 'name2',
          email: ['adil2'],
          phone: ['90809'],
        ),
      ],
    );
  }
}
