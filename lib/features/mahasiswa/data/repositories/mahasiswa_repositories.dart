import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:MobilePrak/features/mahasiswa/data/models/mahasiswa_model.dart';

// VERSI HTTP
class MahasiswaRepositoryHttp {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
    }
  }
}

// VERSI DIO
class MahasiswaRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('/comments');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}