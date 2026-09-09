import 'dart:convert';

AllWeekModel allWeekModelFromJson(String str) => AllWeekModel.fromJson(json.decode(str));

String allWeekModelToJson(AllWeekModel data) => json.encode(data.toJson());

class AllWeekModel {
  final int page;
  final List<AllWeekResult> results;
  final int totalPages;
  final int totalResults;

  AllWeekModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory AllWeekModel.fromJson(Map<String, dynamic> json) => AllWeekModel(
        page: json["page"] ?? 1,
        results: json["results"] != null
            ? List<AllWeekResult>.from(json["results"].map((x) => AllWeekResult.fromJson(x)))
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

class AllWeekResult {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String? title;
  final String? originalTitle;
  final String overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final String? name;

  AllWeekResult({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    required this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.name,
  });

  factory AllWeekResult.fromJson(Map<String, dynamic> json) => AllWeekResult(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        id: json["id"] ?? 0,
        title: json["title"] ?? json["name"] ?? '',
        originalTitle: json["original_title"] ?? json["original_name"] ?? '',
        overview: json["overview"] ?? '',
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [],
        popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
        releaseDate: json["release_date"] ?? json["first_air_date"],
        voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
      };
}
