import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repositories.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

final mahasiswaAktifListProvider = FutureProvider<List<MahasiswaAktifModel>>((ref) async {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  return repository.getMahasiswaAktifList();
});