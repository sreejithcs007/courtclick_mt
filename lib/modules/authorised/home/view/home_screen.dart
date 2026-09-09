import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/view/coming_soon_screen.dart';
import 'package:courtclick_mt/modules/authorised/downloads/view/downloads_screen.dart';
import 'package:courtclick_mt/modules/authorised/home/bloc/home_bloc.dart';
import 'package:courtclick_mt/modules/authorised/home/bloc/home_event.dart';
import 'package:courtclick_mt/modules/authorised/home/bloc/home_state.dart';
import 'package:courtclick_mt/modules/authorised/search/view/search_screen.dart';
import 'package:courtclick_mt/shared/models/authorised/movie_model/movie_model.dart';
import 'package:courtclick_mt/modules/authorised/more/view/more_screen.dart';
import 'package:courtclick_mt/modules/authorised/movie_detail/view/movie_detail_screen.dart';
import 'package:courtclick_mt/widget/custom_state_view/custom_state_view.dart';
import 'package:courtclick_mt/widget/featured_banner/featured_banner.dart';
import 'package:courtclick_mt/widget/movie_section/movie_section.dart';
import 'package:courtclick_mt/widget/netflix_bottom_nav/netflix_bottom_nav.dart';
import 'package:courtclick_mt/widget/previews_section/previews_section.dart';
import 'package:courtclick_mt/widget/shimmer_loading/home_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String profileName;

  const HomeScreen({super.key, this.profileName = 'Emenalo'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  Widget _buildTabBody() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeContentWithBloc();
      case 1:
        return const SearchScreen();
      case 2:
        return const ComingSoonScreen();
      case 3:
        return const DownloadsScreen();
      case 4:
        return MoreScreen(activeProfile: widget.profileName);
      default:
        return _buildHomeContentWithBloc();
    }
  }

  Widget _buildHomeContentWithBloc() {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const FetchHomeDataEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState || state is HomeInitialState) {
            return const HomeShimmerLoading();
          }

          if (state is HomeErrorState) {
            return CustomErrorView(
              message: state.errorMessage,
              onRetry: () {
                context.read<HomeBloc>().add(const FetchHomeDataEvent());
              },
            );
          }

          if (state is HomeLoadedState) {
            final topRated = state.topRatedModel.results;
            final nowPlaying = state.nowPlayingModel.results;
            final popular = state.popularMoviesModel.results;

            if (topRated.isEmpty && nowPlaying.isEmpty && popular.isEmpty) {
              return const CustomEmptyView(
                title: 'No Movies Available',
                subtitle: 'Unable to fetch movies right now. Please pull down to refresh.',
              );
            }

            final featuredMovie = topRated.isNotEmpty
                ? MovieModel(
                    id: topRated.first.id.toString(),
                    title: topRated.first.title,
                    imageUrl:
                        topRated.first.backdropPath ??
                        topRated.first.posterPath ??
                        '',
                    badgeText: '#1 Top Rated Today',
                  )
                : const MovieModel(id: '0', title: '', imageUrl: '');

            final previewsList = nowPlaying.map((m) {
              return MovieModel(
                id: m.id.toString(),
                title: m.title,
                imageUrl: m.posterPath ?? '',
              );
            }).toList();

            final topRatedItems = topRated.map((m) {
              return MovieSectionItem(
                id: m.id,
                title: m.title,
                posterPath: m.posterPath,
                voteAverage: m.voteAverage,
                overview: m.overview,
                releaseDate: m.releaseDate,
              );
            }).toList();

            final popularItems = popular.map((m) {
              return MovieSectionItem(
                id: m.id,
                title: m.title,
                posterPath: m.posterPath,
                voteAverage: m.voteAverage,
                overview: m.overview,
                releaseDate: m.releaseDate,
              );
            }).toList();

            return RefreshIndicator(
              color: Colors.red,
              onRefresh: () async {
                context.read<HomeBloc>().add(const RefreshHomeDataEvent());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Banner
                    FeaturedBanner(
                      movie: featuredMovie,
                      onPlayTap: () {
                        if (topRated.isNotEmpty) {
                          final topItem = topRated.first;
                          Navigator.push(
                            context,
                            SmoothPageRoute(
                              page: MovieDetailScreen(
                                heroTag: 'hero-banner-${topItem.id}',
                                title: topItem.title,
                                posterPath:
                                    topItem.posterPath ?? topItem.backdropPath,
                                overview: topItem.overview,
                                voteAverage: topItem.voteAverage,
                                releaseDate: topItem.releaseDate,
                              ),
                            ),
                          );
                        }
                      },
                      onMyListTap: () {
                        debugPrint('My List tapped');
                      },
                      onInfoTap: () {
                        if (topRated.isNotEmpty) {
                          final topItem = topRated.first;
                          Navigator.push(
                            context,
                            SmoothPageRoute(
                              page: MovieDetailScreen(
                                heroTag: 'hero-banner-info-${topItem.id}',
                                title: topItem.title,
                                posterPath:
                                    topItem.posterPath ?? topItem.backdropPath,
                                overview: topItem.overview,
                                voteAverage: topItem.voteAverage,
                                releaseDate: topItem.releaseDate,
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    // Previews Section (Now Playing)
                    PreviewsSection(
                      previews: previewsList,
                      onPreviewTap: (movie) {
                        debugPrint('Preview tapped: ${movie.title}');
                      },
                    ),

                    const SizedBox(height: 16),

                    // Top Rated Section
                    MovieSection(
                      title: 'Top Rated Movies',
                      movies: topRatedItems,
                    ),

                    const SizedBox(height: 16),

                    // Popular Movies Section
                    MovieSection(title: 'Popular Movies', movies: popularItems),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildTabBody(),
      bottomNavigationBar: NetflixBottomNav(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}
