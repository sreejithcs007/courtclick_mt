import 'package:courtclick_mt/shared/models/authorised/search_movie/search_movie_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchLoadedState extends SearchState {
  final SearchMovieModel searchMovieModel;
  final String query;

  const SearchLoadedState({
    required this.searchMovieModel,
    required this.query,
  });
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  const SearchErrorState({required this.errorMessage});
}
