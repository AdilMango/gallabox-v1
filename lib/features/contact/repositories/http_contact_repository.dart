import 'package:flutter/cupertino.dart';
import 'package:gallabox/core/models/pagination/paginated_response.dart';
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
  String get path => 'account/6005ec415ddd71000432390d';

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
    final responseData = await httpService.put(
      '$path/contacts',
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{'page': page, 'getCount': true, 'limit': 20},
    );
    debugPrint(' *** CONTACT => ${responseData['results']['count']} *** ', wrapWidth: 2500);
    return PaginatedResponse.fromJson(
        results: List<Contact>.from(
          (responseData['results']['data'] as List<dynamic>).map<Contact>(
            (dynamic x) => Contact.fromJson(x as Map<String, dynamic>),
          ),
        ),
        totalResults: int.parse(responseData['results']['count'].toString()));
  }

  @override
  Future<List<Contact>> getContactsPagination({int page = 1, bool forceRefresh = false}) async {
    debugPrint(' ... [httpContactRepository] => getContactsPagination => $page ... ');
    try {
      final responseData = await httpService.get(
        '$path/contacts',
        forceRefresh: forceRefresh,
        queryParameters: <String, dynamic>{'page': page, 'limit': 20},
      );
      return List<Contact>.from(
        (responseData['results'] as List<dynamic>).map<Contact>(
          (dynamic x) => Contact.fromJson(x as Map<String, dynamic>),
        ),
      ).toList();
    } catch (e) {
      throw e;
    }
  }
}
