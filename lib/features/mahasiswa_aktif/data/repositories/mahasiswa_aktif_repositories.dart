import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

// VERSI HTTP
class MahasiswaAktifRepositoryHttp {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data: ${response.statusCode}');
    }
  }
}

// VERSI DIO
class MahasiswaAktifRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get('/posts');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}