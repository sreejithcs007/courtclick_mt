import 'package:courtclick_mt/modules/authorised/home/bloc/home_event.dart';
import 'package:courtclick_mt/modules/authorised/home/bloc/home_state.dart';
import 'package:courtclick_mt/shared/repository/home_repo/home_repository.dart';
import 'package:courtclick_mt/shared/models/authorised/now_playing/now_playing_model.dart';
import 'package:courtclick_mt/shared/models/authorised/popular/popular_model.dart';
import 'package:courtclick_mt/shared/models/authorised/top_rated/top_rated_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc({HomeRepository? repository})
    : _repository = repository ?? HomeRepository(),
      super(const HomeInitialState()) {
    on<FetchHomeDataEvent>(_onFetchHomeData);
    on<RefreshHomeDataEvent>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingState());
    try {
      final results = await Future.wait([
        _repository.fetchTopRated(),
        _repository.fetchNowPlaying(),
        _repository.fetchPopular(),
      ]);

      final topRated = results[0] as TopRatedModel;
      final nowPlaying = results[1] as NowPlayingModel;
      final popular = results[2] as PopularMoviesModel;

      emit(
        HomeLoadedState(
          topRatedModel: topRated,
          nowPlayingModel: nowPlaying,
          popularMoviesModel: popular,
        ),
      );
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
