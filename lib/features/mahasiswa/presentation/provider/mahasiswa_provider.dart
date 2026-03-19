import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/features/mahasiswa/data/repositories/mahasiswa_repositories.dart';
import 'package:MobilePrak/features/mahasiswa/data/models/mahasiswa_model.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final mahasiswaListProvider = FutureProvider<List<MahasiswaModel>>((ref) async {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return repository.getMahasiswaList();
});