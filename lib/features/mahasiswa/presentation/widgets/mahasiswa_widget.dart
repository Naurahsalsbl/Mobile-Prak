import 'package:flutter/material.dart';
import 'package:MobilePrak/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final List<Color>? gradientColors;

  const MahasiswaCard({
    Key? key,
    required this.mahasiswa,
    this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ??
        [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
        ];

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
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  mahasiswa.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mahasiswa.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // ✅ mapping data API
                  _infoRow(Icons.badge_outlined, 'Post ID: ${mahasiswa.postId}'),

                  const SizedBox(height: 3),

                  _infoRow(Icons.email_outlined, mahasiswa.email),

                  const SizedBox(height: 3),

                  _infoRow(Icons.notes_outlined, mahasiswa.body),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: colors[0],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[600]),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}