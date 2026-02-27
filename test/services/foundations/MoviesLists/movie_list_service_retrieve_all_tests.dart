import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/movies/movie_list_exceptions.dart';
import 'package:hello_world/models/movies/movie_list_response.dart';
import 'package:mocktail/mocktail.dart';

import 'movies_list_service_test_base.dart';

void runRetrieveAllMovieListsTests(MovieListServiceTestBase base) {
  group('retrieveAllMovieListsAsync —', () {
    group('retrieveAll |', () {
      test(
        'GIVEN MovieLists exist in storage '
        'WHEN retrieveAllMovieListsAsync is called '
        'THEN it should return all MovieLists from storage',
        () async {
          // Arrange
          final MovieListResponse randomMovieLists = base.createRandomMovieListResponse();
          final MovieListResponse storageMovieLists = randomMovieLists;
          final MovieListResponse expectedMovieLists = storageMovieLists;

          when(() => base.apiBrokerMock.getAllMovieListsAsync())
              .thenAnswer((_) async => storageMovieLists);

          // Act
          final MovieListResponse actualMovieLists =
              await base.movieListService.retrieveAllMovieListsAsync();

          // Assert
          expect(actualMovieLists, equals(expectedMovieLists));

          verify(() => base.apiBrokerMock.getAllMovieListsAsync())
            .called(1);

          verifyNoMoreInteractions(base.apiBrokerMock);
          verifyNoMoreInteractions(base.loggingBrokerMock);
        },
      );    
    });

    group('Service Exceptions |', () {
      test(
        'GIVEN the api broker throws an exception '
        'WHEN retrieveAllMovieListsAsync is called '
        'THEN it should throw MovieListDependencyException and log the error',
        () async {
          // Arrange
          final apiException = Exception('API unavailable.');

          when(() => base.apiBrokerMock.getAllMovieListsAsync())
              .thenThrow(apiException);

          // Act
          Future<MovieListResponse> retrieveAllAction() =>
              base.movieListService.retrieveAllMovieListsAsync();

          // Assert
          await expectLater(
            retrieveAllAction,
            throwsA(
              isA<MovieListDependencyException>().having(
                (e) => e.innerException,
                'innerException',
                isA<FailedMovieListDependencyException>(),
              ),
            ),
          );
          verify(() => base.apiBrokerMock.getAllMovieListsAsync()).called(1);
          verify(() => base.loggingBrokerMock
              .logError(any(), message: any(named: 'message'))).called(1);
              
          verifyNoMoreInteractions(base.apiBrokerMock);
        },
      );
    });
 
  });
}
