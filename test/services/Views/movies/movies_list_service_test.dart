// Run with:  flutter test test/services/foundations/movieLists/movieList_service_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'movie_list_view_service_retrieve_all_tests.dart';
import 'movies_list_view_service_test_base.dart';

void main() {
  final base = MovieListViewServiceTestBase();

  setUp(() => base.setUpMovieListViewServiceTests());

  group('MovieListViewService |', () {
    runRetrieveAllMovieListsTests(base);
  });
}
