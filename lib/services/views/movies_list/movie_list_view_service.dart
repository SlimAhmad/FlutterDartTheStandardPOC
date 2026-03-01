import 'package:hello_world/brokers/dateTimes/i_date_time_broker.dart';
import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/models/foundations/movies/movie_list_exceptions.dart';
import 'package:hello_world/models/views/movie_list_view/exceptions/movie_list_view.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_mapping_view.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';
import 'package:hello_world/services/foundations/movies/movie_list_service.dart';
import 'package:hello_world/services/views/movies_list/i_movie_list_view_service.dart';
import 'package:hello_world/services/views/movies_list/movie_list_view_service.dart';

part 'parts/movie_list_view_service_exceptions.dart';

class MovieListViewService implements IMovieListViewService {
  final MovieListService movieListService;
  final IDateTimeBroker dateTimeBroker;
  final ILoggingBroker loggingBroker;

  MovieListViewService({
    required this.movieListService,
    required this.dateTimeBroker,
    required this.loggingBroker,
  });

  @override
  Future<MovieListResponseView> retrieveAllMovieViewsAsync() =>
      tryCatchList(() async {
        final movieListResponse = await movieListService
            .retrieveAllMovieListsAsync();
        return movieListResponse.toView();
      });
}
