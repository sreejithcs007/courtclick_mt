import 'package:courtclick_mt/core/api/api_response.dart';
import 'package:courtclick_mt/env.dart';
import 'package:dio/dio.dart';

class DioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig().baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // GET
  Future<dynamic> getData({required String endpoints}) async {
    try {
      final response = await dio.get('/$endpoints');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to load products. Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Something went wrong: ${e.message}');
    }
  }

  // POST
  Future<ApiResponse> postData({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await dio.post('/$endpoints', data: body);

      print('================ network ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(body: response.data, error: false, errorMsg: '');
      } else {
        return ApiResponse(
          body: {},
          error: true,
          errorMsg: 'Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse(
        body: {},
        error: true,
        errorMsg: e.message ?? 'Something went wrong',
      );
    }
  }

  // UPDATE
  Future<Map<String, dynamic>> update({
    required String endpoints,
    required Map<String, dynamic> body,
    required int id,
  }) async {
    try {
      final response = await dio.put('/$endpoints/$id', data: body);

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception('Status Code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

  // DELETE
  Future<void> deleteData({required int id, required String endpoints}) async {
    try {
      final response = await dio.delete('/$endpoints/$id');

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to delete product. Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }
}
