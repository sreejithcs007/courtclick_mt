import 'package:courtclick_mt/core/api/dio_service.dart';
import 'package:courtclick_mt/shared/models/authorised/search_movie/search_movie_model.dart';

class SearchRepository {
  final DioService _dioService;

  SearchRepository({DioService? dioService})
      : _dioService = dioService ?? DioService();

  Future<SearchMovieModel> fetchSearchMovies({String query = 's'}) async {
    final searchParam = query.trim().isEmpty ? 's' : query.trim();
    final encodedQuery = Uri.encodeComponent(searchParam);
    final response = await _dioService.getData(
      endpoints: 'search/multi?query=$encodedQuery',
    );

    if (response is Map<String, dynamic>) {
      return SearchMovieModel.fromJson(response);
    }
    throw Exception('Invalid search response format');
  }
}
