part of '../movie_list_view_service.dart';

extension MovieListViewServiceExceptions on MovieListViewService {
  Future<MovieListResponseView> tryCatchList(
    Future<MovieListResponseView> Function() returningMovieListViewsFunction,
  ) async {
    try {
      return await returningMovieListViewsFunction();
    } on MovieListDependencyException catch (MovieListDependencyException) {
      throw await _createAndLogDependencyExceptionAsync(
        MovieListDependencyException,
      );
    } on MovieListServiceException catch (MovieListServiceException) {
      throw await _createAndLogDependencyExceptionAsync(
        MovieListServiceException,
      );
    } on Exception catch (exception) {
      var failedMovieListViewServiceException =
          FailedMovieListViewServiceException(
            message:
                "Failed MovieList service error occurred, contact support.",
            innerException: exception,
          );

      throw await _createAndLogServiceExceptionAsync(
        failedMovieListViewServiceException,
      );
    }
  }

  Future<MovieListViewValidationException>
  _createAndLogValidationExceptionAsync(Exception exception) async {
    var movieListViewValidationException = MovieListViewValidationException(
      message:
          "MovieList validation error occurred, fix the errors and try again.",
      innerException: exception,
    );

    loggingBroker.logError(movieListViewValidationException);

    return movieListViewValidationException;
  }

  Future<MovieListViewDependencyValidationException>
  _createAndLogDependencyValidationExceptionAsync(Exception exception) async {
    var movieListViewDependencyValidationException =
        MovieListViewDependencyValidationException(
          message:
              "MovieList validation error occurred, fix errors and try again.",
          innerException: exception,
        );

    loggingBroker.logError(movieListViewDependencyValidationException);

    return movieListViewDependencyValidationException;
  }

  Future<MovieListViewDependencyException>
  _createAndLogDependencyExceptionAsync(Exception exception) async {
    var movieListViewDependencyException = MovieListViewDependencyException(
      message: "MovieList dependency error occurred, contact support.",
      innerException: exception,
    );

    loggingBroker.logError(movieListViewDependencyException);

    return movieListViewDependencyException;
  }

  Future<MovieListViewServiceException> _createAndLogServiceExceptionAsync(
    Exception exception,
  ) async {
    var movieListViewServiceException = MovieListViewServiceException(
      message: "MovieList service error occurred, contact support.",
      innerException: exception,
    );

    loggingBroker.logError(movieListViewServiceException);

    return movieListViewServiceException;
  }
}
