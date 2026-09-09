import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/env.dart';
import 'package:courtclick_mt/modules/authorised/movie_detail/view/movie_detail_screen.dart';
import 'package:courtclick_mt/modules/authorised/search/bloc/search_bloc.dart';
import 'package:courtclick_mt/modules/authorised/search/bloc/search_event.dart';
import 'package:courtclick_mt/modules/authorised/search/bloc/search_state.dart';
import 'package:courtclick_mt/shared/models/authorised/search_movie/search_movie_model.dart';
import 'package:courtclick_mt/widget/search_text_field/search_text_field.dart';
import 'package:courtclick_mt/widget/shimmer_loading/search_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc()..add(const FetchSearchMoviesEvent(query: 's')),
      child: const _SearchScreenView(),
    );
  }
}

class _SearchScreenView extends StatefulWidget {
  const _SearchScreenView();

  @override
  State<_SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<_SearchScreenView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToDetail(SearchResult result) {
    final heroTag = 'search-item-${result.id}';
    final imagePath = result.posterPath ?? result.backdropPath ?? result.profilePath;
    final itemTitle = (result.title != null && result.title!.isNotEmpty)
        ? result.title!
        : (result.name ?? '');
    final dateStr = result.releaseDate ??
        (result.firstAirDate != null
            ? result.firstAirDate!.toString().split(' ').first
            : '');

    Navigator.push(
      context,
      SmoothPageRoute(
        page: MovieDetailScreen(
          heroTag: heroTag,
          title: itemTitle,
          posterPath: imagePath,
          overview: result.overview,
          voteAverage: result.voteAverage,
          releaseDate: dateStr,
        ),
      ),
    );
  }

  String _getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&q=80';
    }
    if (path.startsWith('http')) return path;
    return '${EnvConfig().imageBaseUrl}$path';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Search Text Field with Debouncer
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: CustomSearchTextField(
                controller: _searchController,
                debounceDurationMs: 400,
                onChanged: (query) {
                  final text = query.trim();
                  context.read<SearchBloc>().add(
                    FetchSearchMoviesEvent(query: text.isEmpty ? 's' : text),
                  );
                },
                onSubmitted: (query) {
                  final text = query.trim();
                  context.read<SearchBloc>().add(
                    FetchSearchMoviesEvent(query: text.isEmpty ? 's' : text),
                  );
                },
                onClear: () {
                  context.read<SearchBloc>().add(
                    const FetchSearchMoviesEvent(query: 's'),
                  );
                },
              ),
            ),

            // Main Content Area
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState ||
                      state is SearchInitialState) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(
                            'Top Searches',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(child: SearchShimmerLoading()),
                      ],
                    );
                  }

                  if (state is SearchErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${state.errorMessage}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              final text = _searchController.text.trim();
                              context.read<SearchBloc>().add(
                                FetchSearchMoviesEvent(
                                  query: text.isEmpty ? 's' : text,
                                ),
                              );
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchLoadedState) {
                    var results = state.searchMovieModel.results.where((r) {
                      final titleStr = (r.title != null && r.title!.isNotEmpty)
                          ? r.title!
                          : (r.name ?? '');
                      return titleStr.isNotEmpty;
                    }).toList();

                    final isDefaultSearch =
                        state.query == 's' || state.query.isEmpty;
                    final sectionTitle = isDefaultSearch
                        ? 'Top Searches'
                        : 'Search Results';

                    if (isDefaultSearch && results.length > 10) {
                      results = results.take(10).toList();
                    }

                    if (results.isEmpty) {
                      return Center(
                        child: Text(
                          'No results found for "${state.query}"',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(
                            sectionTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: results.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final item = results[index];
                              final itemTitle =
                                  (item.title != null && item.title!.isNotEmpty)
                                      ? item.title!
                                      : (item.name ?? '');
                              final imagePath = item.posterPath ??
                                  item.backdropPath ??
                                  item.profilePath;
                              final imageUrl = _getImageUrl(imagePath);
                              final heroTag = 'search-item-${item.id}';

                              return GestureDetector(
                                onTap: () => _navigateToDetail(item),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 3),
                                  color: const Color(0xFF424242),
                                  height: 76,
                                  child: Row(
                                    children: [
                                      // Thumbnail Image
                                      SizedBox(
                                        width: 135,
                                        height: 76,
                                        child: Hero(
                                          tag: heroTag,
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stack) {
                                                  return Container(
                                                    color: Colors.grey[900],
                                                    child: const Icon(
                                                      Icons.movie,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),

                                      // Title
                                      Expanded(
                                        child: Text(
                                          itemTitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      // Play Circle Icon Button
                                      IconButton(
                                        icon: const Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                        onPressed: () =>
                                            _navigateToDetail(item),
                                      ),
                                      const SizedBox(width: 8),
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

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
