import 'package:courtclick_mt/core/api/dio_service.dart';
import 'package:courtclick_mt/shared/models/authorised/now_playing/now_playing_model.dart';
import 'package:courtclick_mt/shared/models/authorised/popular/popular_model.dart';
import 'package:courtclick_mt/shared/models/authorised/top_rated/top_rated_model.dart';

class HomeRepository {
  final DioService _dioService;

  HomeRepository({DioService? dioService})
      : _dioService = dioService ?? DioService();

  Future<TopRatedModel> fetchTopRated() async {
    final response = await _dioService.getData(endpoints: 'movie/top_rated');
    if (response is Map<String, dynamic>) {
      return TopRatedModel.fromJson(response);
    }
    throw Exception('Invalid top_rated response format');
  }

  Future<NowPlayingModel> fetchNowPlaying() async {
    final response = await _dioService.getData(endpoints: 'movie/now_playing');
    if (response is Map<String, dynamic>) {
      return NowPlayingModel.fromJson(response);
    }
    throw Exception('Invalid now_playing response format');
  }

  Future<PopularMoviesModel> fetchPopular() async {
    final response = await _dioService.getData(endpoints: 'movie/popular');
    if (response is Map<String, dynamic>) {
      return PopularMoviesModel.fromJson(response);
    }
    throw Exception('Invalid popular response format');
  }
}
