import 'package:courtclick_mt/shared/models/authorised/upcoming_movie_model/upcoming_movie_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ComingSoonState {
  const ComingSoonState();
}

class ComingSoonInitialState extends ComingSoonState {
  const ComingSoonInitialState();
}

class ComingSoonLoadingState extends ComingSoonState {
  const ComingSoonLoadingState();
}

class ComingSoonLoadedState extends ComingSoonState {
  final UpComingMoviesModel upcomingMovieModel;
  final Set<int> remindedMovieIds;

  const ComingSoonLoadedState({
    required this.upcomingMovieModel,
    this.remindedMovieIds = const {},
  });

  ComingSoonLoadedState copyWith({
    UpComingMoviesModel? upcomingMovieModel,
    Set<int>? remindedMovieIds,
  }) {
    return ComingSoonLoadedState(
      upcomingMovieModel: upcomingMovieModel ?? this.upcomingMovieModel,
      remindedMovieIds: remindedMovieIds ?? this.remindedMovieIds,
    );
  }
}

class ComingSoonErrorState extends ComingSoonState {
  final String errorMessage;

  const ComingSoonErrorState({required this.errorMessage});
}
