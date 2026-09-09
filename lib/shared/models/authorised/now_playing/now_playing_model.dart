import 'dart:convert';

NowPlayingModel nowPlayingModelFromJson(String str) => NowPlayingModel.fromJson(json.decode(str));

String nowPlayingModelToJson(NowPlayingModel data) => json.encode(data.toJson());

class NowPlayingModel {
  final int page;
  final List<NowPlayingResult> results;
  final int totalPages;
  final int totalResults;

  NowPlayingModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) => NowPlayingModel(
        page: json["page"] ?? 1,
        results: json["results"] != null
            ? List<NowPlayingResult>.from(json["results"].map((x) => NowPlayingResult.fromJson(x)))
            : [],
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class NowPlayingResult {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;

  NowPlayingResult({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory NowPlayingResult.fromJson(Map<String, dynamic> json) => NowPlayingResult(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [],
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "title": title,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
