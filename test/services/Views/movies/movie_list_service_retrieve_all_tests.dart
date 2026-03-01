import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/foundations/movies/movie_list_exceptions.dart';
import 'package:hello_world/models/foundations/movies/movie_list_response.dart';
import 'package:mocktail/mocktail.dart';

import 'movies_list_view_service_test_base.dart';

void runRetrieveAllMovieListsTests(MovieListServiceTestBase base) {
  group('retrieveAllMovieListsAsync —', () {
    group('retrieveAll |', () {
      test('GIVEN MovieLists exist in storage '
          'WHEN retrieveAllMovieListsAsync is called '
          'THEN it should return all MovieLists from storage', () async {
        // given
        final MovieListResponse randomMovieLists = base
            .createRandomMovieListResponse();
        final MovieListResponse storageMovieLists = randomMovieLists;
        final MovieListResponse expectedMovieLists = storageMovieLists;

        when(
          () => base.apiBrokerMock.getAllMovieListsAsync(),
        ).thenAnswer((_) async => storageMovieLists);

        // when
        final MovieListResponse actualMovieLists = await base.movieListService
            .retrieveAllMovieListsAsync();

        // then
        expect(actualMovieLists, equals(expectedMovieLists));

        verify(() => base.apiBrokerMock.getAllMovieListsAsync()).called(1);

        verifyNoMoreInteractions(base.apiBrokerMock);
        verifyNoMoreInteractions(base.loggingBrokerMock);
      });
    });

    group('Service Exceptions |', () {
      test(
        'GIVEN the api broker throws an exception '
        'WHEN retrieveAllMovieListsAsync is called '
        'THEN it should throw MovieListDependencyException and log the error',
        () async {
          // given
          final apiException = Exception('API unavailable.');

          when(
            () => base.apiBrokerMock.getAllMovieListsAsync(),
          ).thenThrow(apiException);

          // when
          Future<MovieListResponse> retrieveAllAction() =>
              base.movieListService.retrieveAllMovieListsAsync();

          // then
          await expectLater(
            retrieveAllAction,
            throwsA(
              isA<MovieListServiceException>().having(
                (e) => e.innerException,
                'innerException',
                isA<Exception>(),
              ),
            ),
          );
          verify(() => base.apiBrokerMock.getAllMovieListsAsync()).called(1);
          verify(
            () => base.loggingBrokerMock.logError(
              any(),
              message: any(named: 'message'),
            ),
          ).called(1);

          verifyNoMoreInteractions(base.apiBrokerMock);
        },
      );
    });
  });
}
