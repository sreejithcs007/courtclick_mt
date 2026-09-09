import 'package:courtclick_mt/modules/authorised/home/models/movie_model.dart';
import 'package:flutter/material.dart';

class ContinueWatchingSection extends StatelessWidget {
  final String profileName;
  final List<MovieModel> movies;
  final ValueChanged<MovieModel>? onMovieTap;

  const ContinueWatchingSection({
    super.key,
    required this.profileName,
    required this.movies,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Continue Watching for $profileName',
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

              return GestureDetector(
                onTap: () => onMovieTap?.call(item),
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      // Video Poster with Play Overlay & Progress Bar
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Center Play Icon Overlay
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withValues(alpha: 0.6),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            // Progress bar at bottom of poster
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: LinearProgressIndicator(
                                value: item.progress ?? 0.5,
                                backgroundColor: Colors.grey[800],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                                minHeight: 3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Card Bottom Control Bar (Info icon | Menu icon)
                      Container(
                        height: 36,
                        color: Colors.grey[900],
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.info_outline, color: Colors.grey, size: 18),
                            Icon(Icons.more_vert, color: Colors.grey, size: 18),
                          ],
                        ),
                      ),
                    ],
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
