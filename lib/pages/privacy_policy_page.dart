import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  // =====================================
  // STYLE TEKS SESUAI REFERENSI FIGMA
  // =====================================
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 12.5,
    height: 1.66,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  // =====================================
  // JARAK ANTARBAGIAN
  // =====================================
  static const double paragraphSpacing = 28;

  // =====================================
  // WIDGET PARAGRAF
  // =====================================
  Widget paragraph(String text) {
    return Text(text, style: bodyStyle, textAlign: TextAlign.left);
  }

  // =====================================
  // WIDGET BULLET
  // SESUAI REFERENSI TEMAN
  // =====================================
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16, child: Text('•', style: bodyStyle)),

          Expanded(
            child: Text(text, style: bodyStyle, textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double scale = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  // =====================================
                  // HEADER KEBIJAKAN PRIVASI
                  // TIDAK DIUBAH
                  // =====================================
                  Container(
                    width: double.infinity,
                    height: 46 * scale,
                    color: ecoGreen,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24 * scale,
                          ),
                        ),

                        SizedBox(width: 4 * scale),

                        Text(
                          'Kebijakan Privasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =====================================
                  // KONTEN KEBIJAKAN PRIVASI
                  // BISA DI-SCROLL SEPERTI REFERENSI
                  // =====================================
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(16, 18, 14, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // =====================================
                          // LOGO ECOWALK
                          // =====================================
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'lib/images/logo_ecowalk_white.png',
                              width: 66,
                              fit: BoxFit.contain,
                              color: ecoGreen,
                              colorBlendMode: BlendMode.srcIn,
                            ),
                          ),

                          // =====================================
                          // JARAK LOGO KE JUDUL
                          // =====================================
                          const SizedBox(height: 29),

                          // =====================================
                          // JUDUL DOKUMEN
                          // =====================================
                          const Text(
                            'KEBIJAKAN PRIVASI APLIKASI ECOWALK',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // =====================================
                          // TANGGAL PEMBARUAN
                          // =====================================
                          const Text(
                            'Diperbaharui tanggal 16 Februari 2024',
                            style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),

                          // =====================================
                          // JARAK TANGGAL KE PARAGRAF
                          // =====================================
                          const SizedBox(height: 33),

                          // =====================================
                          // PARAGRAF PEMBUKA
                          // =====================================
                          paragraph(
                            'Kami menghargai privasi pengguna. '
                            'Kebijakan ini menjelaskan\n'
                            'bagaimana ECOWALK mengumpulkan, '
                            'menggunakan, dan\n'
                            'melindungi data Anda.',
                          ),

                          const SizedBox(height: paragraphSpacing),

                          // =====================================
                          // 1. DATA YANG KAMI KUMPULKAN
                          // =====================================
                          paragraph(
                            '1. Data yang Kami Kumpulkan\n'
                            'Kami dapat mengumpulkan data berikut:',
                          ),

                          bulletPoint(
                            'Data Pribadi: Nama, email, '
                            'dan informasi akun.',
                          ),

                          bulletPoint(
                            'Data Lokasi: Untuk memberikan rekomendasi '
                            'wisata dan\n'
                            'perhitungan jarak.',
                          ),

                          bulletPoint(
                            'Ulasan dan Foto: Jika Anda memposting '
                            'ulasan atau berbagi\n'
                            'pengalaman wisata.',
                          ),

                          const SizedBox(height: paragraphSpacing),

                          // =====================================
                          // 2. CARA KAMI MENGGUNAKAN DATA
                          // =====================================
                          paragraph('2. Cara Kami Menggunakan Data'),

                          bulletPoint(
                            'Memberikan rekomendasi tempat wisata '
                            'berdasarkan lokasi.',
                          ),

                          bulletPoint(
                            'Memproses pencarian dan filter '
                            'destinasi sesuai preferensi.',
                          ),

                          bulletPoint(
                            'Menampilkan ulasan dan foto '
                            'yang dibagikan pengguna lain.',
                          ),

                          bulletPoint(
                            'Menyediakan informasi transportasi '
                            'berdasarkan data\n'
                            'lokasi.',
                          ),

                          const SizedBox(height: paragraphSpacing),

                          // =====================================
                          // 3. KEAMANAN DATA
                          // =====================================
                          paragraph(
                            '3. Keamanan Data\n'
                            'Kami menggunakan enkripsi dan metode '
                            'keamanan lainnya\n'
                            'untuk melindungi data Anda.',
                          ),

                          const SizedBox(height: paragraphSpacing),

                          // =====================================
                          // 4. HAK PENGGUNA
                          // =====================================
                          paragraph('4. Hak Pengguna'),

                          bulletPoint(
                            'Anda dapat memperbarui atau menghapus '
                            'informasi akun\n'
                            'kapan saja.',
                          ),

                          bulletPoint(
                            'Anda dapat menonaktifkan fitur lokasi '
                            'jika tidak ingin\n'
                            'berbagi data lokasi.',
                          ),

                          bulletPoint(
                            'Kami tidak akan membagikan data pribadi '
                            'Anda kepada\n'
                            'pihak ketiga tanpa izin.',
                          ),

                          const SizedBox(height: paragraphSpacing),

                          // =====================================
                          // PARAGRAF PENUTUP
                          // =====================================
                          paragraph(
                            'Jika Anda memiliki pertanyaan mengenai '
                            'kebijakan ini,\n'
                            'silakan hubungi: privacy@ecowalk.com',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
