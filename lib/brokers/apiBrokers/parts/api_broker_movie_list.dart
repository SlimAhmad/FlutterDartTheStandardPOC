part of "../api_broker.dart";

class ApiBrokerMovieList extends ApiBroker implements IApibrokerMovieList {

     ApiBrokerMovieList({
        http.Client? httpClient,
        Map<String, dynamic>? configuration,
        PreferenceBroker? preferenceBroker,
      }) : super(
              httpClient: httpClient ?? http.Client(),
              preferenceBroker: preferenceBroker ?? PreferenceBroker(),
      );

   String relativeUrl = "/trending/movie/day";

   @override
   Future<MovieListResponse> getAllMovieListsAsync() async {
    return await getAsync<MovieListResponse>(
      relativeUrl,
      (json) => MovieListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}