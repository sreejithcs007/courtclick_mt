abstract class SearchEvent {
  const SearchEvent();
}

class FetchSearchMoviesEvent extends SearchEvent {
  final String query;

  const FetchSearchMoviesEvent({this.query = ''});
}

class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();
}
