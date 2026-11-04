import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
              // =====================================
              // UKURAN RESPONSIF
              // =====================================
              final double scale = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final double sidePadding = 20 * scale;

              // ============
              // STYLE TEKS
              // ============
              final TextStyle bodyStyle = TextStyle(
                color: const Color(0xFF292929),
                fontSize: 12 * scale,
                height: 1.6,
                fontWeight: FontWeight.w600,
              );

              final TextStyle sectionStyle = TextStyle(
                color: const Color(0xFF292929),
                fontSize: 12 * scale,
                height: 1.4,
                fontWeight: FontWeight.w600,
              );

              // =====================================
              // WIDGET PARAGRAF
              // =====================================
              Widget paragraph(String text) {
                return Text(text, style: bodyStyle, textAlign: TextAlign.left);
              }

              // =====================================
              // WIDGET BULLET POINT
              // =====================================
              Widget bulletPoint(String text) {
                return Padding(
                  padding: EdgeInsets.only(left: 5 * scale, bottom: 5 * scale),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: bodyStyle),
                      Expanded(child: paragraph(text)),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // =====================================
                  // HEADER TENTANG KAMI
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
                          'Tentang Kami',
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
                  // KONTEN HALAMAN
                  // =====================================
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // =====================================
                            // LOGO ECOWALK KANAN ATAS
                            // =====================================
                            SizedBox(height: 12 * scale),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'lib/images/logo_ecowalk_white.png',
                                width: 68 * scale,
                                height: 28 * scale,
                                fit: BoxFit.contain,
                                color: ecoGreen,
                                colorBlendMode: BlendMode.srcIn,
                              ),
                            ),

                            // =====================================
                            // PARAGRAF PENGENALAN
                            // =====================================
                            SizedBox(height: 22 * scale),

                            paragraph(
                              'ECOWALK adalah aplikasi wisata yang membantu pengguna menemukan destinasi terbaik dengan rekomendasi berdasarkan lokasi, perbandingan harga, serta informasi transportasi.',
                            ),

                            // =====================================
                            // MISI KAMI
                            // =====================================
                            SizedBox(height: 26 * scale),

                            Text(
                              'Misi Kami',
                              style: sectionStyle.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),

                            SizedBox(height: 3 * scale),

                            paragraph(
                              'Menyediakan pengalaman wisata yang lebih mudah, informatif, dan terjangkau bagi semua orang dengan fokus pada ekowisata yang ramah lingkungan.',
                            ),

                            // =====================================
                            // APA YANG KAMI TAWARKAN?
                            // =====================================
                            SizedBox(height: 26 * scale),

                            Text(
                              'Apa yang Kami Tawarkan?',
                              style: sectionStyle,
                            ),

                            SizedBox(height: 5 * scale),

                            bulletPoint(
                              'Rekomendasi tempat wisata berdasarkan lokasi dan preferensi Anda.',
                            ),

                            bulletPoint(
                              'Informasi harga tiket, ketersediaan fasilitas, dan ulasan pengguna.',
                            ),

                            bulletPoint(
                              'Peta interaktif untuk membantu navigasi di area wisata.',
                            ),

                            bulletPoint(
                              'Perbandingan harga transportasi untuk perjalanan yang lebih hemat.',
                            ),

                            // =====================================
                            // PARAGRAF PENUTUP
                            // =====================================
                            SizedBox(height: 4 * scale),

                            paragraph(
                              'Kami percaya bahwa menjelajahi dunia harus menjadi pengalaman yang menyenangkan dan mudah diakses oleh semua orang, dengan tetap menjaga kelestarian lingkungan.',
                            ),

                            SizedBox(height: 2 * scale),

                            paragraph(
                              'Untuk pertanyaan atau saran, hubungi kami di:',
                            ),

                            // =====================================
                            // EMAIL KONTAK
                            // =====================================
                            SizedBox(height: 20 * scale),

                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.black87,
                                  size: 17 * scale,
                                ),

                                SizedBox(width: 12 * scale),

                                Text('support@ecowalk.com', style: bodyStyle),
                              ],
                            ),

                            // =====================================
                            // NOMOR TELEPON KONTAK
                            // =====================================
                            SizedBox(height: 12 * scale),

                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.black87,
                                  size: 17 * scale,
                                ),

                                SizedBox(width: 12 * scale),

                                Text('0899-1234-4567', style: bodyStyle),
                              ],
                            ),

                            // =====================================
                            // JARAK AKHIR KONTEN
                            // =====================================
                            SizedBox(height: 16 * scale),
                          ],
                        ),
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
