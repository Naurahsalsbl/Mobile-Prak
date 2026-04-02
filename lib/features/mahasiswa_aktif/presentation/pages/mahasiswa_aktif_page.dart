import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/presentation/provider/mahasiswa_aktif_provider.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);
    final savedMahasiswaAktif = ref.watch(savedMahasiswaAktifProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifNotifierProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section: Data Tersimpan
          _SavedMahasiswaAktifSection(
            savedMahasiswaAktif: savedMahasiswaAktif,
            ref: ref,
          ),

          // Section Title
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa Aktif',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          // List
          Expanded(
            child: mahasiswaAktifState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gagal memuat data: ${error.toString()}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(mahasiswaAktifNotifierProvider.notifier)
                          .refresh(),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
              data: (list) => _MahasiswaAktifListWithSave(
                mahasiswaAktifList: list,
                onRefresh: () =>
                    ref.invalidate(mahasiswaAktifNotifierProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget: Section data tersimpan
class _SavedMahasiswaAktifSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedMahasiswaAktif;
  final WidgetRef ref;

  const _SavedMahasiswaAktifSection({
    required this.savedMahasiswaAktif,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              savedMahasiswaAktif.maybeWhen(
                data: (items) => items.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(mahasiswaAktifNotifierProvider.notifier)
                              .clearSavedMahasiswaAktif();
                          ref.invalidate(savedMahasiswaAktifProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Semua data tersimpan dihapus'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.delete_sweep_outlined,
                          size: 14,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Hapus Semua',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedMahasiswaAktif.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text(
              'Gagal membaca data tersimpan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            data: (items) {
              if (items.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 16, color: Colors.grey.shade400),
                      const SizedBox(width: 8),
                      Text(
                        'Belum ada data. Tap ikon 💾 untuk menyimpan.',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.orange.shade100,
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.orange.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        item['title'] ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'ID: ${item['mahasiswa_aktif_id']} • ${_formatDate(item['saved_at'] ?? '')}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close,
                            size: 16, color: Colors.red),
                        onPressed: () async {
                          await ref
                              .read(mahasiswaAktifNotifierProvider.notifier)
                              .removeSavedMahasiswaAktif(
                                  item['mahasiswa_aktif_id'] ?? '');
                          ref.invalidate(savedMahasiswaAktifProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['title']} dihapus'),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return isoString;
    }
  }
}

// Widget: List mahasiswa aktif dengan tombol save
class _MahasiswaAktifListWithSave extends ConsumerWidget {
  final List<MahasiswaAktifModel> mahasiswaAktifList;
  final VoidCallback onRefresh;

  const _MahasiswaAktifListWithSave({
    required this.mahasiswaAktifList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: mahasiswaAktifList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaAktifList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${mahasiswa.id}')),
              title: Text(
                mahasiswa.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'User ID: ${mahasiswa.userId}\n${mahasiswa.body}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan mahasiswa aktif ini',
                onPressed: () async {
                  await ref
                      .read(mahasiswaAktifNotifierProvider.notifier)
                      .saveSelectedMahasiswaAktif(mahasiswa);
                  ref.invalidate(savedMahasiswaAktifProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${mahasiswa.title} berhasil disimpan ke local storage',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}