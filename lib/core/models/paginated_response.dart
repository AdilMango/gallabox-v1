/// Model representing a paginated Gallabox http response
class PaginatedResponse<T> {
  /// Creates a new instance of [PaginatedResponse]
  PaginatedResponse({
    this.results = const [],
  });

  /// Creates new instance of [PaginatedResponse] parsed from raw dara
  factory PaginatedResponse.fromJson({
    required List<T> results,
  }) {
    return PaginatedResponse<T>(results: results);
  }

  /// List of results of the current page
  final List<T> results;
}
