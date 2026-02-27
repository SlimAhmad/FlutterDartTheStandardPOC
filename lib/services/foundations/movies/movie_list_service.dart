import 'package:hello_world/brokers/apiBrokers/api_broker.dart';
import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/brokers/loggings/logging_broker.dart';
import 'package:hello_world/brokers/storages/i_storage_broker.dart';
import 'package:hello_world/brokers/storages/storage_broker.dart';
import 'package:hello_world/services/foundations/Movies/i_movie_list_service.dart';
import 'package:hello_world/models/movies/movie_list_response.dart';
import 'package:hello_world/models/movies/movie_list_exceptions.dart';
import 'package:http_exception/http_exception.dart';
import 'package:hello_world/services/foundations/movies/movie_list_service.dart';

part 'parts/movie_list_service_exceptions.dart';


class MovieListService implements IMovieListService {
   final ApiBrokerMovieList apiBrokerMovieList;
   final LoggingBroker loggingBroker;
   
   MovieListService({
    ApiBrokerMovieList? apiBrokerMovieList,
    LoggingBroker? loggingBroker,
  })  : apiBrokerMovieList = apiBrokerMovieList ?? ApiBrokerMovieList(), 
        loggingBroker = loggingBroker ?? LoggingBroker();

  @override
    Future<MovieListResponse> retrieveAllMovieListsAsync() =>
    tryCatchList(() async {
      return apiBrokerMovieList.getAllMovieListsAsync();
    });
}