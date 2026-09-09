import 'package:flutter/foundation.dart';

@immutable
abstract class ComingSoonEvent {
  const ComingSoonEvent();
}

class FetchUpcomingMoviesEvent extends ComingSoonEvent {
  const FetchUpcomingMoviesEvent();
}

class RefreshUpcomingMoviesEvent extends ComingSoonEvent {
  const RefreshUpcomingMoviesEvent();
}

class ToggleReminderEvent extends ComingSoonEvent {
  final int movieId;

  const ToggleReminderEvent(this.movieId);
}
