
class NullMovieListException implements Exception {
  final String message;

  const NullMovieListException({
    this.message = 'MovieList is null.',
  });

  @override
  String toString() =>
      'NotFoundMovieListException: $message';
}

class NotFoundMovieListException implements Exception {
  final String message;
  final Exception? innerException;
  final Map<String, dynamic>? data;

  const NotFoundMovieListException({
    this.message = 'MovieList not found.',
    this.innerException,
    this.data,
  });

  @override
  String toString() =>
      'NotFoundMovieListException: $message'
      '${innerException != null ? '\n  InnerException: $innerException' : ''}'
      '${data != null ? '\n  Data: $data' : ''}';
}

class LockedUserMovieListException implements Exception {
  final String message;
  final Exception innerException;

  const LockedUserMovieListException({
    this.message = 'MovieList record is locked.',
    required this.innerException,
  });

  @override
  String toString() =>
      'LockedUserMovieListException: $message'
      '\n  InnerException: $innerException';
}

class InvalidMovieListException implements Exception {
  final String message;
  final Exception? innerException;
  final Map<String, dynamic> data; 

  const InvalidMovieListException({
    this.message = 'Invalid MovieList. Please correct the errors and try again.',
    this.innerException,
    this.data = const {},
  });

  @override
  String toString() =>
      'InvalidMovieListException: $message'
      '${innerException != null ? '\n  InnerException: $innerException' : ''}'
      '\n  Data: $data';
}

class FailedMovieListServiceException implements Exception {
  final String message;
  final Exception innerException;

  const FailedMovieListServiceException({
    this.message = 'Failed MovieList service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedMovieListServiceException: $message'
      '\n  InnerException: $innerException';
}

class FailedMovieListRequestException implements Exception {
  final String message;
  final Exception innerException;

  const FailedMovieListRequestException({
    this.message = 'Failed MovieList request error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedMovieListRequestException: $message'
      '\n  InnerException: $innerException';
}

class FailedMovieListDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const FailedMovieListDependencyException({
    this.message = 'Failed MovieList dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedMovieListDependencyException: $message'
      '\n  InnerException: $innerException';
}

class FailedMovieListConfigurationException implements Exception {
  final String message;
  final Exception innerException;

  const FailedMovieListConfigurationException({
    this.message = 'Failed MovieList configuration error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedMovieListConfigurationException: $message'
      '\n  InnerException: $innerException';
}

//Categorical exceptions:

class MovieListValidationException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListValidationException({
    this.message = 'MovieList validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListValidationException: $message'
      '\n  InnerException: $innerException';
}

class MovieListServiceException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListServiceException({
    this.message = 'MovieList service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListServiceException: $message'
      '\n  InnerException: $innerException';
}

class MovieListDependencyValidationException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListDependencyValidationException({
    this.message = 'MovieList dependency validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListDependencyValidationException: $message'
      '\n  InnerException: $innerException';
}

class MovieListDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListDependencyException({
    this.message = 'MovieList dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListDependencyException: $message'
      '\n  InnerException: $innerException';
}
