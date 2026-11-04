import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ViewedDetailPage extends StatelessWidget {
  const ViewedDetailPage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color lightGrey = Color(0xFFD9D9D9);

  // =====================================
  // FONT INTER
  // =====================================
  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = darkText,
    double height = 1.3,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  // =====================================
  // HALAMAN UTAMA
  // =====================================
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
              final double s = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  _buildHeader(context, s),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 35 * s,
                        right: 35 * s,
                        top: 21 * s,
                        bottom: 24 * s,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PROFIL PEMBERI ULASAN
                          _buildReviewer(s),

                          SizedBox(height: 18 * s),

                          // TEKS ULASAN
                          _buildReviewText(s),

                          SizedBox(height: 16 * s),

                          // DUA GAMBAR ABU-ABU
                          _buildReviewImages(s),

                          SizedBox(height: 3 * s),

                          // TANGGAL ULASAN
                          _buildReviewDate(s),

                          SizedBox(height: 35 * s),

                          // GARIS PEMISAH
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFE7E7E7),
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

  // =====================================
  // HEADER NILAI & ULASAN
  // =====================================
  Widget _buildHeader(BuildContext context, double s) {
    return Container(
      width: double.infinity,
      height: 54 * s,
      color: ecoGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23 * s),
          ),

          SizedBox(width: 4 * s),

          Text(
            'Nilai & Ulasan',
            style: interStyle(
              size: 15 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // PROFIL PEMBERI ULASAN
  // =====================================
  Widget _buildReviewer(double s) {
    return Row(
      children: [
        // FOTO PROFIL ABU-ABU
        Container(
          width: 28 * s,
          height: 28 * s,
          decoration: const BoxDecoration(
            color: lightGrey,
            shape: BoxShape.circle,
          ),
        ),

        SizedBox(width: 10 * s),

        // NAMA PENGGUNA
        Expanded(
          child: Text(
            'Kaisyarani Zahra',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),
        ),

        SizedBox(width: 8 * s),

        // BADGE RATING
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5 * s, vertical: 3 * s),
          decoration: BoxDecoration(
            color: ecoGreen,
            borderRadius: BorderRadius.circular(3 * s),
          ),
          child: Text(
            '5.0 / 5.0',
            style: interStyle(
              size: 7 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================
  // PARAGRAF ULASAN
  // =====================================
  Widget _buildReviewText(double s) {
    return Text(
      'Pokoknya seru banget masuk pokoknya seru banget masuk pokoknya '
      'seru banget masuk pokoknya seru banget masuk pokoknya seru banget '
      'masuk pokoknya seru banget masuk pokoknya seru banget masuk '
      'pokoknya seru banget masuk pokoknya seru banget masuk '
      'pokoknya seru banget masuk pokoknya seru banget masuk.',
      textAlign: TextAlign.left,
      softWrap: true,
      style: interStyle(size: 8 * s, height: 1.5),
    );
  }

  // =====================================
  // DUA GAMBAR ULASAN SESUAI FIGMA
  // =====================================
  Widget _buildReviewImages(double s) {
    return Row(
      children: [
        Container(width: 62 * s, height: 62 * s, color: lightGrey),

        SizedBox(width: 10 * s),

        Container(width: 62 * s, height: 62 * s, color: lightGrey),
      ],
    );
  }

  // =====================================
  // TANGGAL ULASAN
  // =====================================
  Widget _buildReviewDate(double s) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Diulas pada 12 Februari 2025',
        style: interStyle(size: 6 * s, color: const Color(0xFF666666)),
      ),
    );
  }
}
