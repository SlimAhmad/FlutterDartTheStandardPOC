import 'package:equatable/equatable.dart';
import 'package:hello_world/models/foundations/movieslist/movie_list.dart';

class MovieListResponseView extends Equatable {
  final int page;
  final List<MovieList> results;
  final int totalPages;
  final int totalResults;

  const MovieListResponseView({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponseView.fromJson(Map<String, dynamic> json) {
    return MovieListResponseView(
      page: json['page'] ?? 0,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => MovieList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
