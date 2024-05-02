class QueryNewsCategoryException implements Exception {
  const QueryNewsCategoryException({
    this.message = 'An unknown exception occurred.',
  });
  final String message;
}

class SaveNewsCategoryException implements Exception {
  const SaveNewsCategoryException({
    this.message = 'An unknown exception occurred.',
  });
  final String message;
}
