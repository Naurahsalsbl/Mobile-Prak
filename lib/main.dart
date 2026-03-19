import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/dosen/presentation/pages/dosen_page.dart';
import 'features/mahasiswa/presentation/pages/mahasiswa_pages.dart';
import 'features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4 Tivokasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('D4 Tivokasi'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MenuCard(
              icon: Icons.person,
              title: 'Data Dosen',
              subtitle: 'Lihat daftar dosen',
              color: Colors.blue,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DosenPage())),
            ),
            const SizedBox(height: 16),
            _MenuCard(
              icon: Icons.school,
              title: 'Data Mahasiswa',
              subtitle: 'Lihat daftar mahasiswa',
              color: Colors.green,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MahasiswaPage())),
            ),
            const SizedBox(height: 16),
            _MenuCard(
              icon: Icons.assignment_turned_in,
              title: 'Mahasiswa Aktif',
              subtitle: 'Lihat daftar mahasiswa aktif',
              color: Colors.indigo,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MahasiswaAktifPage())),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}