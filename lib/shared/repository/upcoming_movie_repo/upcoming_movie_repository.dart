import 'package:courtclick_mt/core/api/dio_service.dart';
import 'package:courtclick_mt/shared/models/authorised/upcoming_movie_model/upcoming_movie_model.dart';

class UpComingSoonRepository {
  final DioService _dioService;

  UpComingSoonRepository({DioService? dioService})
    : _dioService = dioService ?? DioService();

  Future<UpComingMoviesModel> fetchUpcomingMovies() async {
    final response = await _dioService.getData(endpoints: 'movie/upcoming');
    if (response is Map<String, dynamic>) {
      return UpComingMoviesModel.fromJson(response);
    }
    throw Exception('Invalid upcoming movies response format');
  }
}
