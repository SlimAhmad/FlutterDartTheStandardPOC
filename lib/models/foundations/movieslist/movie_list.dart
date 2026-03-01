class MovieList {
  final String description;
  final int? favoriteCount;
  final int? id;
  final int? itemCount;
  final String? iso639_1;
  final String? listType;
  final String? name;
  final String? posterPath;

  MovieList({
    required this.description,
    this.favoriteCount,
    this.id,
    this.itemCount,
    this.iso639_1,
    this.listType,
    this.name,
    this.posterPath,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      description: json['overview'] ?? '',
      favoriteCount: json['favorite_count'] ?? 0,
      id: json['id'] ?? 0,
      itemCount: json['item_count'] ?? 0,
      iso639_1: json['iso_639_1'] ?? '',
      listType: json['list_type'] ?? '',
      name: json['title'] ?? '',
      posterPath: json['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'favorite_count': favoriteCount,
      'id': id,
      'item_count': itemCount,
      'iso_639_1': iso639_1,
      'list_type': listType,
      'name': name,
      'poster_path': posterPath,
    };
  }
}
