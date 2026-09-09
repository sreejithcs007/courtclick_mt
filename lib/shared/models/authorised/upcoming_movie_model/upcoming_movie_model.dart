import 'dart:convert';

UpComingMoviesModel upComingMoviesModelFromJson(String str) =>
    UpComingMoviesModel.fromJson(json.decode(str));

String upComingMoviesModelToJson(UpComingMoviesModel data) =>
    json.encode(data.toJson());

class UpComingMoviesModel {
  final Dates? dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  UpComingMoviesModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpComingMoviesModel.fromJson(Map<String, dynamic> json) =>
      UpComingMoviesModel(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"] ?? 1,
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  final String? maximum;
  final String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json["maximum"],
        minimum: json["minimum"],
      );

  Map<String, dynamic> toJson() => {
        "maximum": maximum,
        "minimum": minimum,
      };
}

class Result {
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

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
