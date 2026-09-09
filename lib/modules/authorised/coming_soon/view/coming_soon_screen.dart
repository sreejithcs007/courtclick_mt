import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/env.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/bloc/coming_soon_bloc.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/bloc/coming_soon_event.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/bloc/coming_soon_state.dart';
import 'package:courtclick_mt/modules/authorised/movie_detail/view/movie_detail_screen.dart';
import 'package:courtclick_mt/widget/custom_state_view/custom_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ComingSoonBloc()..add(const FetchUpcomingMoviesEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
            builder: (context, state) {
              if (state is ComingSoonLoadingState ||
                  state is ComingSoonInitialState) {
                return _buildShimmerLoading();
              }

              if (state is ComingSoonErrorState) {
                return CustomErrorView(
                  message: state.errorMessage,
                  onRetry: () {
                    context.read<ComingSoonBloc>().add(
                          const FetchUpcomingMoviesEvent(),
                        );
                  },
                );
              }

              if (state is ComingSoonLoadedState) {
                final movies = state.upcomingMovieModel.results;
                final remindedIds = state.remindedMovieIds;

                if (movies.isEmpty) {
                  return const CustomEmptyView(
                    title: 'No Upcoming Movies',
                    subtitle: 'There are no upcoming movies scheduled at this time. Please check back later.',
                  );
                }

                return RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    context.read<ComingSoonBloc>().add(
                      const RefreshUpcomingMoviesEvent(),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notifications Header & Tiles
                        _buildNotificationsSection(),

                        const Divider(color: Colors.grey, height: 1),
                        const SizedBox(height: 12),

                        // Upcoming Movies List
                        ...movies.map((movie) {
                          final isReminded = remindedIds.contains(movie.id);
                          return _buildUpcomingMovieCard(
                            context,
                            movie: movie,
                            isReminded: isReminded,
                          );
                        }),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    final notifications = [
      {
        'title': 'El Chapo',
        'subtitle': 'New Arrival',
        'date': 'Nov 6',
        'image':
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=300&q=80',
      },
      {
        'title': 'Peaky Blinders',
        'subtitle': 'New Arrival',
        'date': 'Nov 6',
        'image':
            'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=300&q=80',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.notifications, color: Colors.red, size: 22),
              SizedBox(width: 8),
              Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            color: Colors.grey[900],
            child: Column(
              children: notifications.map((n) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  leading: Container(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(n['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    n['subtitle']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  subtitle: Text(
                    n['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    n['date']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingMovieCard(
    BuildContext context, {
    required dynamic movie,
    required bool isReminded,
  }) {
    final imageBaseUrl = EnvConfig().imageBaseUrl;
    final backdropPath = movie.backdropPath ?? movie.posterPath;
    final fullImageUrl = backdropPath != null
        ? '$imageBaseUrl$backdropPath'
        : 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&q=80';

    final heroTag = 'upcoming-poster-${movie.id}';
    final releaseString =
        movie.releaseDate != null && movie.releaseDate!.isNotEmpty
        ? 'Coming ${movie.releaseDate}'
        : 'Coming Soon';

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Backdrop Image with Tap -> Detail View
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                SmoothPageRoute(
                  page: MovieDetailScreen(
                    heroTag: heroTag,
                    title: movie.title,
                    posterPath: movie.posterPath ?? movie.backdropPath,
                    overview: movie.overview,
                    voteAverage: movie.voteAverage,
                    releaseDate: movie.releaseDate,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[900],
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      fullImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[850]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons Row (Remind Me | Share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ComingSoonBloc>().add(
                      ToggleReminderEvent(movie.id),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isReminded
                            ? Icons.notifications_active
                            : Icons.notifications_none,
                        color: isReminded ? Colors.amber : Colors.white,
                        size: 22,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isReminded ? 'Reminded' : 'Remind Me',
                        style: TextStyle(
                          color: isReminded ? Colors.amber : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 22),
                      SizedBox(height: 4),
                      Text(
                        'Share',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Release Subtitle & Movie Title & Overview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  releaseString,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Steamy • Soapy • Slow Burn • Suspenseful • Teen • Mystery',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(width: 140, height: 20, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(height: 80, color: Colors.black),
            ),
            const SizedBox(height: 24),
            Container(height: 200, width: double.infinity, color: Colors.black),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(width: 120, height: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
