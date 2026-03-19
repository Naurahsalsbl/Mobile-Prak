import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/core/constants/app_constants.dart';
import 'package:MobilePrak/core/widgets/common_widgets.dart';
import 'package:MobilePrak/features/mahasiswa_aktif/presentation/provider/mahasiswa_aktif_provider.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifListProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () => ref.invalidate(mahasiswaAktifListProvider),
        ),
        data: (list) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaAktifListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final colors = AppConstants.dashboardGradients[index % AppConstants.dashboardGradients.length];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colors[0].withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: colors[0].withOpacity(0.1)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              item.title.substring(0, 1).toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 6),
                              Row(children: [Icon(Icons.badge_outlined, size: 13, color: Colors.grey[600]), const SizedBox(width: 5), Text('User ID: ${item.userId}', style: TextStyle(fontSize: 12, color: Colors.grey[700]))]),
                              const SizedBox(height: 3),
                              Row(children: [Icon(Icons.book_outlined, size: 13, color: Colors.grey[600]), const SizedBox(width: 5), Text('Post ID: ${item.id}', style: TextStyle(fontSize: 12, color: Colors.grey[700]))]),
                              const SizedBox(height: 3),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: const Text('Active', style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colors[0]),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}