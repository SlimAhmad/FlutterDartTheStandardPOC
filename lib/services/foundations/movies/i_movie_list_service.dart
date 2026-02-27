import 'package:hello_world/models/movies/movie_list_response.dart';

abstract class IMovieListService {
    Future<MovieListResponse> retrieveAllMovieListsAsync();
}