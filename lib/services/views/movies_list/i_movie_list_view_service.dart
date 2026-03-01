import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';

abstract class IMovieListViewService {
  Future<MovieListResponseView> retrieveAllMovieViewsAsync();
}
