import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/core/constants/app_constants.dart';
import 'package:MobilePrak/core/widgets/common_widgets.dart';
import 'package:MobilePrak/features/mahasiswa/presentation/provider/mahasiswa_provider.dart';
import 'package:MobilePrak/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ pakai provider yang benar
    final mahasiswaState = ref.watch(mahasiswaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            // ✅ invalidate provider yang benar
            onPressed: () => ref.invalidate(mahasiswaListProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),

        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa: ${error.toString()}',
          // ✅ FutureProvider tidak punya notifier
          onRetry: () => ref.invalidate(mahasiswaListProvider),
        ),

        data: (mahasiswaList) {
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(mahasiswaListProvider),

            child: ListView.builder(
              padding:
                  const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                return MahasiswaCard(
                  mahasiswa: mahasiswaList[index],
                  gradientColors:
                      AppConstants.dashboardGradients[
                          index %
                          AppConstants.dashboardGradients.length],
                );
              },
            ),
          );
        },
      ),
    );
  }
}