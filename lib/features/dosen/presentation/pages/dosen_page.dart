import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MobilePrak/features/dosen/presentation/provider/dosen_provider.dart';
import 'package:MobilePrak/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenAsync = ref.watch(dosenListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dosenListProvider),
          ),
        ],
      ),
      body: dosenAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Terjadi kesalahan:\n$error',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(dosenListProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (dosenList) => DosenListView(
          dosenList: dosenList,
          onRefresh: () => ref.invalidate(dosenListProvider),
          useModernCard: true,
        ),
      ),
    );
  }
}