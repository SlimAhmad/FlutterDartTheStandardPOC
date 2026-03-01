import 'package:hello_world/models/foundations/movies/movie_list_response.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';

// foundation → view
extension MovieListResponseMapping on MovieListResponse {
  MovieListResponseView toView() {
    return MovieListResponseView(
      page: page,
      results: results,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}

// view → foundation (only if you really need it)
extension MovieListResponseViewMapping on MovieListResponseView {
  MovieListResponse toModel() {
    return MovieListResponse(
      page: page,
      results: results,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
