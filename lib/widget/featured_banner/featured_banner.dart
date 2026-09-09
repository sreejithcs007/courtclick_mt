import 'package:courtclick_mt/core/constanst/assets_constants/assets_contant.dart';
import 'package:courtclick_mt/modules/authorised/home/models/movie_model.dart';
import 'package:flutter/material.dart';

class FeaturedBanner extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onPlayTap;
  final VoidCallback? onMyListTap;
  final VoidCallback? onInfoTap;

  const FeaturedBanner({
    super.key,
    required this.movie,
    this.onPlayTap,
    this.onMyListTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background Hero Poster Image
        Container(
          height: screenHeight * 0.55,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(movie.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient Overlay (Top dark fade + Bottom solid fade to black)
        Container(
          height: screenHeight * 0.55,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black87,
                Colors.transparent,
                Colors.transparent,
                Colors.black,
              ],
              stops: [0.0, 0.25, 0.65, 1.0],
            ),
          ),
        ),

        // Top Navigation Bar
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Netflix Logo
                Image.asset(
                  AppImages.splashLogo,
                  height: 35,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'N',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'TV Shows',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Movies',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'My List',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom Controls Container
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge tag (e.g. #2 in Nigeria Today)
              if (movie.badgeText != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'TOP\n10',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                          height: 0.9,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      movie.badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Action Buttons Row (My List | Play | Info)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // My List
                  GestureDetector(
                    onTap: onMyListTap,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 24),
                        SizedBox(height: 4),
                        Text(
                          'My List',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  // Play Pill Button
                  ElevatedButton.icon(
                    onPressed: onPlayTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, color: Colors.black, size: 28),
                    label: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Info
                  GestureDetector(
                    onTap: onInfoTap,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, color: Colors.white, size: 24),
                        SizedBox(height: 4),
                        Text(
                          'Info',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
