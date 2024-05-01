class QueryNewsCategoryException implements Exception {
  const QueryNewsCategoryException({
    this.message = 'An unknown exception occurred.',
  });
  final String message;
}
