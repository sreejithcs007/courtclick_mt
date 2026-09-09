import 'package:courtclick_mt/env.dart';
import 'package:courtclick_mt/shared/models/authorised/movie_model/movie_model.dart';
import 'package:flutter/material.dart';

class PreviewsSection extends StatelessWidget {
  final List<MovieModel> previews;
  final ValueChanged<MovieModel>? onPreviewTap;

  const PreviewsSection({super.key, required this.previews, this.onPreviewTap});

  static const List<Color> _borderColors = [
    Colors.amber,
    Colors.redAccent,
    Colors.cyan,
    Colors.purpleAccent,
    Colors.greenAccent,
  ];

  String _getImageUrl(String url) {
    if (url.startsWith('/')) {
      return '${EnvConfig().imageBaseUrl}$url';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    if (previews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Previews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: previews.length,
            itemBuilder: (context, index) {
              final item = previews[index];
              final borderColor = _borderColors[index % _borderColors.length];
              final fullImageUrl = _getImageUrl(item.imageUrl);

              return GestureDetector(
                onTap: () => onPreviewTap?.call(item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor, width: 2.5),
                          image: DecorationImage(
                            image: NetworkImage(fullImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black),
                            ],
                          ),
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
