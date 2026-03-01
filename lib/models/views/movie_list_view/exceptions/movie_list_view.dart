class NullMovieListViewException implements Exception {
  final String message;

  const NullMovieListViewException({this.message = 'MovieList is null.'});

  @override
  String toString() => 'NullMovieListViewException: $message';
}

class InvalidMovieListViewException implements Exception {
  final String message;

  const InvalidMovieListViewException({
    this.message =
        'Invalid MovieList view. Please correct the errors and try again.',
  });

  @override
  String toString() => 'InvalidMovieListViewException: $message';
}

class FailedMovieListViewServiceException implements Exception {
  final String message;
  final Exception innerException;

  const FailedMovieListViewServiceException({
    this.message =
        'Failed MovieList view service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedMovieListViewServiceException: $message'
      '\n  InnerException: $innerException';
}

//Categorical exceptions:

class MovieListViewValidationException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListViewValidationException({
    this.message = 'MovieList validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListViewValidationException: $message'
      '\n  InnerException: $innerException';
}

class MovieListViewServiceException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListViewServiceException({
    this.message = 'MovieList service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListViewServiceException: $message'
      '\n  InnerException: $innerException';
}

class MovieListViewDependencyValidationException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListViewDependencyValidationException({
    this.message =
        'MovieList dependency validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListViewDependencyValidationException: $message'
      '\n  InnerException: $innerException';
}

class MovieListViewDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const MovieListViewDependencyException({
    this.message = 'MovieList dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'MovieListViewDependencyException: $message'
      '\n  InnerException: $innerException';
}
