import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/features/dosen/data/repositories/dosen_repositories.dart';
import 'package:MobilePrak/features/dosen/data/models/dosen_model.dart';

final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  return DosenRepository();
});

final dosenListProvider = FutureProvider<List<DosenModel>>((ref) async {
  final repository = ref.watch(dosenRepositoryProvider);
  return repository.getDosenList();
});