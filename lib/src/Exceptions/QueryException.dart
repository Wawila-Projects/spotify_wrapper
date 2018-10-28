class QueryException implements Exception  {
  ///Message describing the error.
  final String message;

  const QueryException(this.message);

  factory QueryException.OrLimit() {
    return QueryException('Only 1 OR es allowed per query');
  }

  factory QueryException.WildcardLimit() {
    return QueryException('Only 2 * are allowed per query');
  }
}