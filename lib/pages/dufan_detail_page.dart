import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class DufanDetailPage extends StatefulWidget {
  const DufanDetailPage({super.key});

  @override
  State<DufanDetailPage> createState() => _DufanDetailPageState();
}

class _DufanDetailPageState extends State<DufanDetailPage> {
  bool isFavorite = false;

  final Color darkText = const Color(0xFF202020);

  // =====================================
  // STYLE FONT INTER
  // =====================================
  TextStyle interStyle({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color color = const Color(0xFF202020),
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double s = (constraints.maxWidth / 390)
                .clamp(0.8, 1.2)
                .toDouble();

            return Column(
              children: [
                _buildHeader(s),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroImage(s),
                        _buildDestinationInfo(s),
                        _buildPriceInfo(s),
                        _buildReviewSection(s),
                        _buildMapSection(s),

                        // =====================================
                        // TOMBOL BERI ULASAN
                        // =====================================
                        _buildReviewButton(s),

                        SizedBox(height: 32 * s),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // =====================================
  // HEADER
  // =====================================
  Widget _buildHeader(double s) {
    return Container(
      width: double.infinity,
      height: 52 * s,
      color: ecoGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * s),
          ),
          SizedBox(width: 4 * s),
          Text(
            'Dunia Fantasi (DUFAN)',
            style: interStyle(
              fontSize: 15 * s,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // FOTO UTAMA DUFAN
  // =====================================
  Widget _buildHeroImage(double s) {
    return SizedBox(
      width: double.infinity,
      height: 290 * s,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/dufan2.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE7E7E7),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          // GRADASI PUTIH DI BAWAH FOTO
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 130 * s,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.32, 0.70, 1.0],
                  colors: [
                    Color(0x00FFFFFF),
                    Color(0x55FFFFFF),
                    Color(0xDDFFFFFF),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),

          // RATING PADA FOTO
          Positioned(
            left: 13 * s,
            bottom: 43 * s,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 11 * s,
                vertical: 6 * s,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF3D8A78),
                borderRadius: BorderRadius.circular(7 * s),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 15 * s),
                  SizedBox(width: 4 * s),
                  Text(
                    '4.75',
                    style: interStyle(
                      fontSize: 12 * s,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TOMBOL FAVORIT
          Positioned(
            right: 12 * s,
            bottom: 12 * s,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Container(
                width: 46 * s,
                height: 46 * s,
                decoration: const BoxDecoration(
                  color: Color(0xFF468E7C),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 28 * s,
                ),
              ),
            ),
          ),

          // JUDUL DUFAN
          Positioned(
            left: 13 * s,
            right: 65 * s,
            bottom: 14 * s,
            child: Text(
              'Dunia Fantasi (DUFAN)',
              style: interStyle(
                fontSize: 20 * s,
                fontWeight: FontWeight.w800,
                color: darkText,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // INFORMASI TEMPAT WISATA
  // =====================================
  Widget _buildDestinationInfo(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4 * s),

          // JAM OPERASIONAL
          Row(
            children: [
              Icon(Icons.access_time, size: 16 * s, color: Colors.black),
              SizedBox(width: 5 * s),
              Text(
                'Open',
                style: interStyle(
                  fontSize: 12 * s,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF21894F),
                ),
              ),
              Text(
                ' | 10:00 - 22:00',
                style: interStyle(fontSize: 12 * s, color: darkText),
              ),
            ],
          ),

          SizedBox(height: 7 * s),

          // ALAMAT
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 18 * s,
              ),
              SizedBox(width: 5 * s),
              Expanded(
                child: Text(
                  'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, '
                  'Jkt Utara, Daerah Khusus Ibukota Jakarta 14430',
                  style: interStyle(
                    fontSize: 11 * s,
                    color: darkText,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20 * s),

          // DESKRIPSI
          Text(
            'Dufan (Dunia Fantasi) adalah taman hiburan '
            'yang terletak di kawasan Taman Impian Ancol, '
            'Jakarta Utara. Dufan merupakan salah satu '
            'taman hiburan terbesar dan terpopuler di '
            'Indonesia.',
            textAlign: TextAlign.justify,
            style: interStyle(fontSize: 12 * s, color: darkText, height: 1.5),
          ),
        ],
      ),
    );
  }

  // =====================================
  // HARGA TIKET
  // =====================================
  Widget _buildPriceInfo(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 19 * s),
          Text(
            'Harga Tiket Mulai Dari',
            style: interStyle(
              fontSize: 9 * s,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),

          SizedBox(height: 5 * s),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10 * s, vertical: 6 * s),
            decoration: BoxDecoration(
              color: ecoGreen,
              borderRadius: BorderRadius.circular(4 * s),
            ),
            child: Text(
              'Rp. 190.000 - Rp. 400.000',
              style: interStyle(
                fontSize: 15 * s,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: 5 * s),

          Text(
            '*Harga tergantung hari dan jenis tiket yang dipilih.',
            style: interStyle(fontSize: 8 * s, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // =====================================
  // NILAI & ULASAN
  // =====================================
  Widget _buildReviewSection(double s) {
    return Padding(
      padding: EdgeInsets.only(top: 28 * s, left: 13 * s, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 13 * s),
            child: Text(
              'Nilai & Ulasan',
              style: interStyle(
                fontSize: 17 * s,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),

          SizedBox(height: 9 * s),

          // RATING KESELURUHAN
          Padding(
            padding: EdgeInsets.only(right: 13 * s),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8 * s,
                    vertical: 4 * s,
                  ),
                  decoration: BoxDecoration(
                    color: ecoGreen,
                    borderRadius: BorderRadius.circular(6 * s),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14 * s),
                      SizedBox(width: 4 * s),
                      Text(
                        '4.75',
                        style: interStyle(
                          fontSize: 12 * s,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 9 * s),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rekomendasi Istimewa',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: interStyle(
                          fontSize: 11 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2 * s),
                      Text(
                        '24.543 Ulasan',
                        style: interStyle(fontSize: 10 * s),
                      ),
                    ],
                  ),
                ),

                // LIHAT SEMUA
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/reviews');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * s),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lihat Semua',
                          style: interStyle(
                            fontSize: 9 * s,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 15 * s),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12 * s),

          // KARTU ULASAN HORIZONTAL
          SizedBox(
            height: 136 * s,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 13 * s),
              children: [
                _buildReviewCard(s: s, showPhotos: false),
                SizedBox(width: 7 * s),
                _buildReviewCard(s: s, showPhotos: true),
                SizedBox(width: 7 * s),
                _buildReviewCard(s: s, showPhotos: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // KARTU ULASAN PENGGUNA
  // =====================================
  Widget _buildReviewCard({required double s, required bool showPhotos}) {
    return Container(
      width: 185 * s,
      padding: EdgeInsets.all(7 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10 * s),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AVATAR, NAMA, RATING
          Row(
            children: [
              CircleAvatar(radius: 10 * s, backgroundColor: Colors.red),
              SizedBox(width: 5 * s),
              Expanded(
                child: Text(
                  'Kaisyarani Zahra',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: interStyle(
                    fontSize: 9 * s,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ),
              SizedBox(width: 3 * s),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4 * s,
                  vertical: 3 * s,
                ),
                decoration: BoxDecoration(
                  color: ecoGreen,
                  borderRadius: BorderRadius.circular(3 * s),
                ),
                child: Text(
                  '5.0 / 5.0',
                  style: interStyle(
                    fontSize: 7 * s,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6 * s),

          // ISI ULASAN
          Text(
            'pokoknya sangat bagus makcik '
            'pokoknya sangat bagus makcik '
            'pokoknya sangat bagus makcik '
            'pokoknya sangat bagus makcik '
            'pokoknya sangat bagus makcik',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: interStyle(fontSize: 7.5 * s, height: 1.25, color: darkText),
          ),

          const Spacer(),

          // FOTO KHUSUS KARTU KEDUA
          if (showPhotos) ...[
            Row(
              children: [
                _buildReviewPhoto(s),
                SizedBox(width: 3 * s),
                _buildReviewPhoto(s),
                SizedBox(width: 3 * s),
                _buildReviewPhoto(s),
              ],
            ),
            SizedBox(height: 5 * s),
          ],

          // TANGGAL ULASAN
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Diulas pada 12 Februari 2025',
              maxLines: 1,
              textAlign: TextAlign.right,
              style: interStyle(fontSize: 6.5 * s, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // FOTO KECIL ULASAN
  // =====================================
  Widget _buildReviewPhoto(double s) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2 * s),
      child: Image.asset(
        'lib/images/dufan2.png',
        width: 31 * s,
        height: 23 * s,
        fit: BoxFit.cover,
      ),
    );
  }

  // =====================================
  // LIHAT PETA
  // =====================================
  Widget _buildMapSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25 * s),

          Text(
            'Lihat Peta',
            style: interStyle(
              fontSize: 16 * s,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          SizedBox(height: 4 * s),

          Text(
            '1.68 KM dari lokasimu saat ini',
            style: interStyle(fontSize: 10 * s, color: darkText),
          ),

          SizedBox(height: 10 * s),

          ClipRRect(
            borderRadius: BorderRadius.circular(12 * s),
            child: SizedBox(
              width: double.infinity,
              height: 155 * s,
              child: Image.asset(
                'lib/images/peta.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE8EFE8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, color: ecoGreen, size: 40 * s),
                        SizedBox(height: 8 * s),
                        Text(
                          'Peta Dunia Fantasi (DUFAN)',
                          style: interStyle(
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w600,
                            color: ecoGreen,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // TOMBOL BERI ULASAN - BARU
  // =====================================
  Widget _buildReviewButton(double s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13 * s, 24 * s, 13 * s, 0),
      child: SizedBox(
        width: double.infinity,
        height: 48 * s,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/write-review');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ecoGreen,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6 * s),
            ),
          ),
          child: Text(
            'Beri Ulasan',
            style: interStyle(
              fontSize: 15 * s,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
