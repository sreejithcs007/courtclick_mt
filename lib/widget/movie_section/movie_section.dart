import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/env.dart';
import 'package:courtclick_mt/modules/authorised/movie_detail/view/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class MovieSectionItem {
  final int id;
  final String title;
  final String? posterPath;
  final double? voteAverage;
  final String? overview;
  final String? releaseDate;

  const MovieSectionItem({
    required this.id,
    required this.title,
    this.posterPath,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieSectionItem> movies;
  final ValueChanged<MovieSectionItem>? onMovieTap;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    final imageBaseUrl = EnvConfig().imageBaseUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final item = movies[index];
              final fullImageUrl = item.posterPath != null
                  ? '$imageBaseUrl${item.posterPath}'
                  : null;
              final heroTag = 'movie-poster-${item.id}-$title';

              return GestureDetector(
                onTap: () {
                  onMovieTap?.call(item);
                  Navigator.push(
                    context,
                    SmoothPageRoute(
                      page: MovieDetailScreen(
                        heroTag: heroTag,
                        title: item.title,
                        posterPath: item.posterPath,
                        overview: item.overview,
                        voteAverage: item.voteAverage,
                        releaseDate: item.releaseDate,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Hero(
                      tag: heroTag,
                      child: fullImageUrl != null
                          ? Image.network(
                              fullImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[850],
                                  child: Center(
                                    child: Text(
                                      item.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey[850],
                              child: Center(
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
