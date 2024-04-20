class QueryArticleCacheException implements Exception {
  const QueryArticleCacheException({
    this.message = 'An unknown exception occurred.',
  });

  final String message;
}

class SaveArticleCacheException implements Exception {
  const SaveArticleCacheException({
    this.message = 'An unknown exception occurred.',
  });

  final String message;
}

class CacheInitializationError implements Exception {
  const CacheInitializationError({
    this.message = 'An unknown exception occurred.',
  });

  final String message;
}
