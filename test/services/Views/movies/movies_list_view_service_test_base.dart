import 'package:faker/faker.dart';
import 'package:hello_world/brokers/dateTimes/date_time_broker.dart';
import 'package:hello_world/brokers/loggings/logging_broker.dart';
import 'package:hello_world/models/foundations/movieslist/movie_list.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';
import 'package:hello_world/services/foundations/movies/movie_list_service.dart';
import 'package:hello_world/services/views/movies_list/i_movie_list_view_service.dart';
import 'package:hello_world/services/views/movies_list/movie_list_view_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockMovieListService extends Mock implements MovieListService {}

class MockDateTimeBroker extends Mock implements DateTimeBroker {}

class MockLoggingBroker extends Mock implements LoggingBroker {}

class MovieListViewServiceTestBase {
  late MockMovieListService movieListServiceMock;
  late MockDateTimeBroker dateTimeBrokerMock;
  late MockLoggingBroker loggingBrokerMock;
  late IMovieListViewService movieListViewService;

  final _faker = Faker();
  final _uuid = const Uuid();

  void setUpMovieListViewServiceTests() {
    movieListServiceMock = MockMovieListService();
    dateTimeBrokerMock = MockDateTimeBroker();
    loggingBrokerMock = MockLoggingBroker();

    registerFallbackValue(
      MovieListResponseView(
        results: [],
        page: 1,
        totalPages: 1,
        totalResults: 0,
      ),
    );
    registerFallbackValue(Exception('test'));

    movieListViewService = MovieListViewService(
      movieListService: movieListServiceMock,
      dateTimeBroker: dateTimeBrokerMock,
      loggingBroker: loggingBrokerMock,
    );

    when(
      () => loggingBrokerMock.logError(any(), message: any(named: 'message')),
    ).thenReturn(null);

    when(
      () =>
          loggingBrokerMock.logCritical(any(), message: any(named: 'message')),
    ).thenReturn(null);

    when(() => loggingBrokerMock.logInformation(any())).thenReturn(null);

    when(() => loggingBrokerMock.logWarning(any())).thenReturn(null);
  }

  String randomId() => _uuid.v4();

  String randomName() => _faker.person.name();

  String randomEmail() => _faker.internet.email();

  String randomString() => _faker.animal.name();

  int randomNumber() => _faker.randomGenerator.integer(10);

  DateTime randomPastDate() => DateTime.now().subtract(
    Duration(days: _faker.randomGenerator.integer(365, min: 1)),
  );

  MovieListResponseView createRandomMovieListResponse() {
    return MovieListResponseView(
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
