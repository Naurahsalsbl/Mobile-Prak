import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/core/services/local_storage_service.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repositories.dart';

// Repository Provider
final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

// LocalStorage Provider
final mahasiswaAktifLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Provider semua mahasiswa aktif yang disimpan
final savedMahasiswaAktifProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(mahasiswaAktifLocalStorageProvider);
  return storage.getSavedMahasiswaAktif();
});

// StateNotifier
class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;
  final LocalStorageService _storage;

  MahasiswaAktifNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadMahasiswaAktifList();
  }

  Future<void> loadMahasiswaAktifList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaAktifList();
  }

  Future<void> saveSelectedMahasiswaAktif(MahasiswaAktifModel mahasiswa) async {
    await _storage.addMahasiswaAktifToSavedList(
      mahasiswaAktifId: mahasiswa.id.toString(),
      title: mahasiswa.title,
    );
  }

  Future<void> removeSavedMahasiswaAktif(String mahasiswaAktifId) async {
    await _storage.removeSavedMahasiswaAktif(mahasiswaAktifId);
  }

  Future<void> clearSavedMahasiswaAktif() async {
    await _storage.clearSavedMahasiswaAktif();
  }
}

// Notifier Provider
final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  final storage = ref.watch(mahasiswaAktifLocalStorageProvider);
  return MahasiswaAktifNotifier(repository, storage);
});