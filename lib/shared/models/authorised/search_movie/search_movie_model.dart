// To parse this JSON data, do
//
//     final searchMovieModel = searchMovieModelFromJson(jsonString);

import 'dart:convert';

SearchMovieModel searchMovieModelFromJson(String str) =>
    SearchMovieModel.fromJson(json.decode(str));

String searchMovieModelToJson(SearchMovieModel data) =>
    json.encode(data.toJson());

class SearchMovieModel {
  final int page;
  final List<SearchResult> results;
  final int totalPages;
  final int totalResults;

  SearchMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieModel(
        page: json["page"] ?? 1,
        results: json["results"] != null
            ? List<SearchResult>.from(
                json["results"].map((x) => SearchResult.fromJson(x)),
              )
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

class SearchResult {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final MediaType? mediaType;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double popularity;
  final DateTime? firstAirDate;
  final bool? softcore;
  final double? voteAverage;
  final int? voteCount;
  final List<String>? originCountry;
  final String? title;
  final String? originalTitle;
  final String? releaseDate;
  final bool? video;
  final int? gender;
  final String? knownForDepartment;
  final String? profilePath;
  final List<KnownFor>? knownFor;

  SearchResult({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity = 0.0,
    this.firstAirDate,
    this.softcore,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.video,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    id: json["id"] ?? 0,
    name: json["name"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"] != null
        ? mediaTypeValues.map[json["media_type"]]
        : null,
    originalLanguage: json["original_language"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"]!.map((x) => x)),
    popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
    firstAirDate: json["first_air_date"] == null || json["first_air_date"].toString().isEmpty
        ? null
        : DateTime.tryParse(json["first_air_date"].toString()),
    softcore: json["softcore"],
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
    originCountry: json["origin_country"] == null
        ? []
        : List<String>.from(json["origin_country"]!.map((x) => x)),
    title: json["title"],
    originalTitle: json["original_title"],
    releaseDate: json["release_date"],
    video: json["video"],
    gender: json["gender"],
    knownForDepartment: json["known_for_department"],
    profilePath: json["profile_path"],
    knownFor: json["known_for"] == null
        ? []
        : List<KnownFor>.from(
            json["known_for"]!.map((x) => KnownFor.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType != null ? mediaTypeValues.reverse[mediaType] : null,
    "original_language": originalLanguage,
    "genre_ids": genreIds == null
        ? []
        : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity,
    "first_air_date": firstAirDate == null
        ? null
        : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "origin_country": originCountry == null
        ? []
        : List<dynamic>.from(originCountry!.map((x) => x)),
    "title": title,
    "original_title": originalTitle,
    "release_date": releaseDate,
    "video": video,
    "gender": gender,
    "known_for_department": knownForDepartment,
    "profile_path": profilePath,
    "known_for": knownFor == null
        ? []
        : List<dynamic>.from(knownFor!.map((x) => x.toJson())),
  };
}

class KnownFor {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final MediaType? mediaType;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double popularity;
  final DateTime? releaseDate;
  final bool? softcore;
  final bool? video;
  final double voteAverage;
  final int voteCount;

  KnownFor({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity = 0.0,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    id: json["id"] ?? 0,
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"] != null
        ? mediaTypeValues.map[json["media_type"]]
        : null,
    originalLanguage: json["original_language"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
    releaseDate: json["release_date"] == null || json["release_date"].toString().isEmpty
        ? null
        : DateTime.tryParse(json["release_date"].toString()),
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType != null ? mediaTypeValues.reverse[mediaType] : null,
    "original_language": originalLanguage,
    "genre_ids": genreIds == null
        ? []
        : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity,
    "release_date": releaseDate == null
        ? null
        : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType { movie, person, tv }

final mediaTypeValues = EnumValues({
  "movie": MediaType.movie,
  "person": MediaType.person,
  "tv": MediaType.tv,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
