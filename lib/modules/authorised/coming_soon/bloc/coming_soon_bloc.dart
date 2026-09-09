import 'package:courtclick_mt/modules/authorised/coming_soon/bloc/coming_soon_event.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/bloc/coming_soon_state.dart';
import 'package:courtclick_mt/modules/authorised/coming_soon/repository/coming_soon_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  final ComingSoonRepository _repository;

  ComingSoonBloc({ComingSoonRepository? repository})
    : _repository = repository ?? ComingSoonRepository(),
      super(const ComingSoonInitialState()) {
    on<FetchUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<RefreshUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<ToggleReminderEvent>(_onToggleReminder);
  }

  Future<void> _onFetchUpcomingMovies(
    ComingSoonEvent event,
    Emitter<ComingSoonState> emit,
  ) async {
    emit(const ComingSoonLoadingState());
    try {
      final upcomingModel = await _repository.fetchUpcomingMovies();
      emit(ComingSoonLoadedState(upcomingMovieModel: upcomingModel));
    } catch (e) {
      emit(ComingSoonErrorState(errorMessage: e.toString()));
    }
  }

  void _onToggleReminder(
    ToggleReminderEvent event,
    Emitter<ComingSoonState> emit,
  ) {
    final currentState = state;
    if (currentState is ComingSoonLoadedState) {
      final updatedReminders = Set<int>.from(currentState.remindedMovieIds);
      if (updatedReminders.contains(event.movieId)) {
        updatedReminders.remove(event.movieId);
      } else {
        updatedReminders.add(event.movieId);
      }
      emit(currentState.copyWith(remindedMovieIds: updatedReminders));
    }
  }
}
