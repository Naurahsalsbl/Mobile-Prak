import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _savedUsersKey = 'saved_users';

  // — Token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // — User
  Future<void> saveUser({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // — simpan user di list
  /// Tambah user ke list (tidak menghapus yang lama)
  Future<void> addUserToSavedList({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];

    // Cek duplikasi userId
    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    if (isDuplicate) return; // Jika sudah ada, lewati

    final newUser = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newUser);
    await prefs.setStringList(_savedUsersKey, rawList);
  }

  /// Ambil semua user yang sudah disimpan
  Future<List<Map<String, String>>> getSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id': (map['user_id'] ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  /// delete user tertentu dari list
  Future<void> removeSavedUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    await prefs.setStringList(_savedUsersKey, rawList);
  }

  /// delete semua user dari list
  Future<void> clearSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedUsersKey);
  }

  // — Clear All preferences
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static const String _savedMahasiswaKey = 'saved_mahasiswa';

    // — Mahasiswa
    Future<void> addMahasiswaToSavedList({
    required String mahasiswaId,
    required String name,
    }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];

    final isDuplicate = rawList.any((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return map['mahasiswa_id'] == mahasiswaId;
    });

    if (isDuplicate) return;

    final newItem = jsonEncode({
        'mahasiswa_id': mahasiswaId,
        'name': name,
        'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newItem);
    await prefs.setStringList(_savedMahasiswaKey, rawList);
    }

    Future<List<Map<String, String>>> getSavedMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];

    return rawList.map((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return {
        'mahasiswa_id': (map['mahasiswa_id'] ?? '').toString(),
        'name': (map['name'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
        };
    }).toList();
    }

    Future<void> removeSavedMahasiswa(String mahasiswaId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];

    rawList.removeWhere((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return map['mahasiswa_id'] == mahasiswaId;
    });

    await prefs.setStringList(_savedMahasiswaKey, rawList);
    }

    Future<void> clearSavedMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedMahasiswaKey);
    }

    static const String _savedMahasiswaAktifKey = 'saved_mahasiswa_aktif';

    // — Mahasiswa Aktif
    Future<void> addMahasiswaAktifToSavedList({
      required String mahasiswaAktifId,
      required String title,
    }) async {
      final prefs = await SharedPreferences.getInstance();
      final rawList = prefs.getStringList(_savedMahasiswaAktifKey) ?? [];

      final isDuplicate = rawList.any((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return map['mahasiswa_aktif_id'] == mahasiswaAktifId;
      });

      if (isDuplicate) return;

      final newItem = jsonEncode({
        'mahasiswa_aktif_id': mahasiswaAktifId,
        'title': title,
        'saved_at': DateTime.now().toIso8601String(),
      });

      rawList.add(newItem);
      await prefs.setStringList(_savedMahasiswaAktifKey, rawList);
    }

    Future<List<Map<String, String>>> getSavedMahasiswaAktif() async {
      final prefs = await SharedPreferences.getInstance();
      final rawList = prefs.getStringList(_savedMahasiswaAktifKey) ?? [];

      return rawList.map((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return {
          'mahasiswa_aktif_id': (map['mahasiswa_aktif_id'] ?? '').toString(),
          'title': (map['title'] ?? '').toString(),
          'saved_at': (map['saved_at'] ?? '').toString(),
        };
      }).toList();
    }

    Future<void> removeSavedMahasiswaAktif(String mahasiswaAktifId) async {
      final prefs = await SharedPreferences.getInstance();
      final rawList = prefs.getStringList(_savedMahasiswaAktifKey) ?? [];

      rawList.removeWhere((item) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        return map['mahasiswa_aktif_id'] == mahasiswaAktifId;
      });

      await prefs.setStringList(_savedMahasiswaAktifKey, rawList);
    }

    Future<void> clearSavedMahasiswaAktif() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_savedMahasiswaAktifKey);
    }
  }