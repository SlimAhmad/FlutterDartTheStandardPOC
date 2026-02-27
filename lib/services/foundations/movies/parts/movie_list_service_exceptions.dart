
part of '../movie_list_service.dart';

extension MovieListServiceExceptions on MovieListService {
  
   Future<MovieListResponse> tryCatchList(Future<MovieListResponse> Function() function) async {
    try {
      return await function();
    } on FailedDependencyHttpException catch (failedDependencyHttpException) {

      final failedMovieListDependencyException =
          FailedMovieListDependencyException(
            message: "Failed MovieList dependency error occurred, contact support.",
            innerException: failedDependencyHttpException);

      throw await _createAndLogCriticalDependencyExceptionAsync(failedMovieListDependencyException);

    } on NotFoundHttpException catch (notFoundHttpException) {

      final notFoundMovieListException = NotFoundMovieListException(
        message: "Failed MovieList configuration error occurred, contact support.",
        innerException: notFoundHttpException,
      );

      throw await _createAndLogCriticalDependencyExceptionAsync(notFoundMovieListException);

    }on Exception catch(exception) {

      final failedMovieListServiceException =
          FailedMovieListServiceException(
             message: "Failed MovieList service error occurred, contact support.",
             innerException: exception);

      throw await _createAndLogServiceExceptionAsync(failedMovieListServiceException);
    }
   }

  Future<MovieListValidationException> _createAndLogValidationExceptionAsync(
    Exception exception,
  ) async {
    final movieListValidationException = MovieListValidationException(
      message: 'MovieList validation error occurred, fix the errors and try again.',
      innerException: exception,
    );
    loggingBroker.logError(movieListValidationException);
    return movieListValidationException;
  }

  Future<MovieListDependencyValidationException>
      _createAndLogDependencyValidationExceptionAsync(
    Exception exception
  ) async {
    final movieListDependencyValidationException = MovieListDependencyValidationException(
      message: 'MovieList dependency validation error occurred, fix the errors and try again.',
      innerException: exception,
    );
    loggingBroker.logError(movieListDependencyValidationException);
    return movieListDependencyValidationException;
  }

  Future<MovieListDependencyException> _createAndLogCriticalDependencyExceptionAsync(
    Exception exception,
  ) async {
    final movieListDependencyException = MovieListDependencyException(
      message: 'MovieList dependency error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logCritical(movieListDependencyException);
    return movieListDependencyException;
  }

  Future<MovieListDependencyException> _createAndLogDependencyExceptionAsync(
    Exception exception
  ) async {
    final movieListDependencyException = MovieListDependencyException(
      message: 'MovieList dependency error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logError(movieListDependencyException);
    return movieListDependencyException;
  }

  Future<MovieListServiceException> _createAndLogServiceExceptionAsync(
    Exception exception
  ) async {
    final movieListServiceException = MovieListServiceException(
      message: 'MovieList service error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logError(movieListServiceException);
    return movieListServiceException;
  }
}
