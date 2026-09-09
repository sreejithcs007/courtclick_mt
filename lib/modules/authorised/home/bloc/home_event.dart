import 'package:flutter/foundation.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class FetchHomeDataEvent extends HomeEvent {
  const FetchHomeDataEvent();
}

class RefreshHomeDataEvent extends HomeEvent {
  const RefreshHomeDataEvent();
}
