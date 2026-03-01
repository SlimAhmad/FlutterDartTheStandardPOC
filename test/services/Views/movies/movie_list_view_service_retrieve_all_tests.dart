import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/views/movie_list_view/exceptions/movie_list_view.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_mapping_view.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';
import 'package:mocktail/mocktail.dart';

import 'movies_list_view_service_test_base.dart';

void runRetrieveAllMovieListsTests(MovieListViewServiceTestBase base) {
  group('retrieveAllMovieListsAsync —', () {
    group('retrieveAll |', () {
      test('ShouldRetrieveAllMovieLists', () async {
        // given
        final MovieListResponseView randomMovieLists = base
            .createRandomMovieListResponse();
        final MovieListResponseView storageMovieLists = randomMovieLists;
        final MovieListResponseView expectedMovieLists = storageMovieLists;

        when(
          () => base.movieListServiceMock.retrieveAllMovieListsAsync(),
        ).thenAnswer((_) async => storageMovieLists.toModel());

        // when
        final MovieListResponseView actualMovieLists = await base
            .movieListViewService
            .retrieveAllMovieViewsAsync();

        // then
        expect(actualMovieLists, equals(expectedMovieLists));

        verify(
          () => base.movieListServiceMock.retrieveAllMovieListsAsync(),
        ).called(1);

        verifyNoMoreInteractions(base.movieListServiceMock);
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
            () => base.movieListServiceMock.retrieveAllMovieListsAsync(),
          ).thenThrow(apiException);

          // when
          Future<MovieListResponseView> retrieveAllAction() =>
              base.movieListViewService.retrieveAllMovieViewsAsync();

          // then
          await expectLater(
            retrieveAllAction,
            throwsA(
              isA<MovieListViewServiceException>().having(
                (e) => e.innerException,
                'innerException',
                isA<Exception>(),
              ),
            ),
          );
          verify(
            () => base.movieListServiceMock.retrieveAllMovieListsAsync(),
          ).called(1);
          verify(
            () => base.loggingBrokerMock.logError(
              any(),
              message: any(named: 'message'),
            ),
          ).called(1);

          verifyNoMoreInteractions(base.movieListServiceMock);
        },
      );
    });
  });
}
