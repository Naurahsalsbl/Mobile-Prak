import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:MobilePrak/features/dosen/data/models/dosen_model.dart';

// ========================
// VERSI HTTP
// ========================
class DosenRepositoryHttp {
  Future<List<DosenModel>> getDosenList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    }
  }
}

// ========================
// VERSI DIO
// ========================
class DosenRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  DosenRepository() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST [${options.method}] => ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE [${response.statusCode}]');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('ERROR => ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}