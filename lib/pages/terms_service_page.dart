import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TermsServicePage extends StatelessWidget {
  const TermsServicePage({super.key});

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
  // JARAK ANTARPARAGRAF
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
  // =====================================
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 18, child: Text('•', style: bodyStyle)),

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
                  // HEADER
                  // TIDAK DIUBAH
                  // =====================================
                  Container(
                    width: double.infinity,
                    height: 50 * scale,
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
                          'Ketentuan Layanan',
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
                  // KONTEN KETENTUAN LAYANAN
                  // MENYESUAIKAN UKURAN LAYAR
                  // =====================================
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, contentConstraints) {
                        final double contentWidth =
                            contentConstraints.maxWidth - 30;

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 18, 14, 12),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: contentWidth,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                    'KETENTUAN PENGGUNAAN APLIKASI ECOWALK',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  // =====================================
                                  // TANGGAL PEMBARUAN
                                  // =====================================
                                  const Text(
                                    'Diperbaharui tanggal 16 Februari 2024',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
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
                                    'Selamat datang di ECOWALK! Dengan menggunakan aplikasi\n'
                                    'ini, Anda setuju dengan ketentuan dan persyaratan berikut:',
                                  ),

                                  const SizedBox(height: paragraphSpacing),

                                  // =====================================
                                  // POIN 1
                                  // =====================================
                                  paragraph(
                                    '1. Dengan menggunakan aplikasi ECOWALK, Anda dapat\n'
                                    'menemukan informasi tentang tempat wisata, rekomendasi\n'
                                    'tempat, perbandingan harga, dan layanan peta berbasis lokasi.',
                                  ),

                                  const SizedBox(height: paragraphSpacing),

                                  // =====================================
                                  // POIN 2
                                  // =====================================
                                  paragraph(
                                    '2. Anda bertanggung jawab atas keakuratan data, termasuk\n'
                                    'ulasan dan foto, yang Anda masukkan.',
                                  ),

                                  const SizedBox(height: paragraphSpacing),

                                  // =====================================
                                  // POIN 3
                                  // =====================================
                                  paragraph(
                                    '3. Perubahan Layanan ECOWALK berhak mengubah,\n'
                                    'menambah, atau menghentikan layanan tanpa pemberitahuan\n'
                                    'sebelumnya. Pengguna bertanggung jawab atas keamanan\n'
                                    'akun mereka, termasuk kata sandi. Pengguna juga dilarang\n'
                                    'menggunakan aplikasi untuk tujuan yang dapat merugikan\n'
                                    'pihak lain.\n'
                                    'Informasi yang diberikan oleh sumber seperti tiket atau biaya\n'
                                    'transportasi tidak akurat, dan kami tidak bertanggung jawab\n'
                                    'atas kesalahan tersebut.',
                                  ),

                                  const SizedBox(height: paragraphSpacing),

                                  // =====================================
                                  // POIN 4
                                  // =====================================
                                  paragraph('4. Penolakan Tanggung Jawab'),

                                  // =====================================
                                  // SUBPOIN PERTAMA
                                  // =====================================
                                  bulletPoint(
                                    'ECOWALK hanya menyediakan informasi sebagai referensi\n'
                                    'dan bukan penyedia layanan wisata atau transportasi.',
                                  ),

                                  // =====================================
                                  // SUBPOIN KEDUA
                                  // =====================================
                                  bulletPoint(
                                    'Kami tidak bertanggung jawab atas perubahan harga,\n'
                                    'ketersediaan tempat, atau keterlambatan transportasi.',
                                  ),

                                  const SizedBox(height: paragraphSpacing),

                                  // =====================================
                                  // PARAGRAF PENUTUP
                                  // =====================================
                                  paragraph(
                                    'Dengan menggunakan aplikasi ini, Anda menyetujui semua\n'
                                    'ketentuan di atas.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
