import 'package:faker/faker.dart';
import 'package:hello_world/brokers/apiBrokers/api_broker.dart';
import 'package:hello_world/brokers/loggings/logging_broker.dart';
import 'package:hello_world/models/movies/movie_list.dart';
import 'package:hello_world/models/movies/movie_list_response.dart';
import 'package:hello_world/services/foundations/Movies/i_movie_list_service.dart';
import 'package:hello_world/services/foundations/movies/movie_list_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockApiBrokerMovieList extends Mock implements ApiBrokerMovieList {}
class MockLoggingBroker extends Mock implements LoggingBroker {}

class MovieListServiceTestBase {
  late MockApiBrokerMovieList apiBrokerMock;
  late MockLoggingBroker loggingBrokerMock;
  late IMovieListService movieListService;

  final _faker = Faker();
  final _uuid = const Uuid();

  void setUpMovieListServiceTests() {
    apiBrokerMock = MockApiBrokerMovieList();
    loggingBrokerMock = MockLoggingBroker();

    registerFallbackValue(
      MovieListResponse(
        results: [],
        page: 1,
        totalPages: 1,
        totalResults: 0,
      ),
    );
    registerFallbackValue(Exception('test'));

    movieListService = MovieListService(
      apiBrokerMovieList: apiBrokerMock,
      loggingBroker: loggingBrokerMock,
    );

    when(() => loggingBrokerMock.logError(any(), message: any(named: 'message')))
        .thenReturn(null);

    when(() => loggingBrokerMock.logCritical(any(), message: any(named: 'message')))
        .thenReturn(null);

    when(() => loggingBrokerMock.logInformation(any())).thenReturn(null);
    
    when(() => loggingBrokerMock.logWarning(any())).thenReturn(null);
  }

  String randomId() =>
     _uuid.v4();

  String randomName() => 
    _faker.person.name();

  String randomEmail() => 
    _faker.internet.email();

  String randomString() => 
    _faker.animal.name();

  int randomNumber() => 
    _faker.randomGenerator.integer(10);

  DateTime randomPastDate() =>
      DateTime.now().subtract(Duration(days: _faker.randomGenerator.integer(365, min: 1)));

  MovieListResponse createRandomMovieListResponse() {
    return MovieListResponse(
      results: createRandomMovieListList(),
      page: 1,
      totalPages: 1,
      totalResults: 1,
    );
  }

  MovieList createRandomMovieList() {
    return MovieList(
      name: randomName(),
      description: randomName(),
      posterPath: randomName(),
      id: randomNumber(),
      favoriteCount: randomNumber(),   
      itemCount: randomNumber(),
      iso639_1: randomString(),
      listType: randomString(),
    );
  }

  List<MovieList> createRandomMovieListList({int count = 3}) =>
      List.generate(count, (_) => createRandomMovieList());
}
