class QueryArticleCacheException implements Exception {
  const QueryArticleCacheException({
    this.message = 'An unknown exception occurred.',
  });

  final String message;
}

class QueryCategoryCacheException implements Exception {
  const QueryCategoryCacheException({
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

class SaveCategoryCacheException implements Exception {
  const SaveCategoryCacheException({
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
