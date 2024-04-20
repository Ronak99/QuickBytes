class QueryArticleNewsException implements Exception {
  const QueryArticleNewsException({
    this.message = 'An unknown exception occurred.',
  });
  final String message;
}
