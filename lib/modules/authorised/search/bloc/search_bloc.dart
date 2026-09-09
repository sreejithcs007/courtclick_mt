import 'package:courtclick_mt/modules/authorised/search/bloc/search_event.dart';
import 'package:courtclick_mt/modules/authorised/search/bloc/search_state.dart';
import 'package:courtclick_mt/shared/repository/search_repo/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _repository;

  SearchBloc({SearchRepository? repository})
      : _repository = repository ?? SearchRepository(),
        super(const SearchInitialState()) {
    on<FetchSearchMoviesEvent>(_onFetchSearchMovies);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onFetchSearchMovies(
    FetchSearchMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoadingState());
    try {
      final searchModel = await _repository.fetchSearchMovies(query: event.query);
      emit(SearchLoadedState(
        searchMovieModel: searchModel,
        query: event.query,
      ));
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    add(const FetchSearchMoviesEvent(query: 's'));
  }
}
