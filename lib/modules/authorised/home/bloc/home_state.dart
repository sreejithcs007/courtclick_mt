import 'package:courtclick_mt/shared/models/authorised/now_playing/now_playing_model.dart';
import 'package:courtclick_mt/shared/models/authorised/popular/popular_model.dart';
import 'package:courtclick_mt/shared/models/authorised/top_rated/top_rated_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final TopRatedModel topRatedModel;
  final NowPlayingModel nowPlayingModel;
  final PopularMoviesModel popularMoviesModel;

  const HomeLoadedState({
    required this.topRatedModel,
    required this.nowPlayingModel,
    required this.popularMoviesModel,
  });
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState({required this.errorMessage});
}
