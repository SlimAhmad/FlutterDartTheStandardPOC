part of "../i_api_broker.dart";

abstract class IApibrokerMovieList {
  Future<MovieListResponse> getAllMovieListsAsync();
}