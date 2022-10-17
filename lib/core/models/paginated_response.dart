/// Model representing a paginated Gallabox http response
class PaginatedResponse<T> {
  /// Creates a new instance of [PaginatedResponse]
  PaginatedResponse({
    this.results = const [],
    this.totalResults = 1,
  });

  /// Creates new instance of [PaginatedResponse] parsed from raw dara
  factory PaginatedResponse.fromJson({
    int totalResults = 0,
    required List<T> results,
  }) {
    return PaginatedResponse<T>(results: results, totalResults: totalResults);
  }

  /// List of results of the current page
  final List<T> results;

  /// Total number of results in all pages
  final int totalResults;
}
