import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TripSummaryPage extends StatelessWidget {
  const TripSummaryPage({super.key});

  static const Color darkText = Color(0xFF171717);

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
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double s = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final bool compact = constraints.maxHeight < 760;

              return Column(
                children: [
                  _buildHeader(context, s),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FOTO DUFAN
                          _buildHeroImage(s, compact: compact),

                          SizedBox(height: (compact ? 10 : 20) * s),

                          // INFORMASI PERJALANAN
                          _buildTripInformation(s),

                          SizedBox(height: (compact ? 12 : 24) * s),

                          // RUTE PERJALANAN
                          _buildRouteSection(s, compact: compact),

                          SizedBox(height: (compact ? 12 : 27) * s),

                          // TRANSPORTASI
                          _buildTransportSection(s, compact: compact),

                          // BANNER ULASAN DI BAWAH TRANSPORTASI
                          SizedBox(height: (compact ? 28 : 40) * s),

                          _buildReviewPrompt(context, s),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // =====================================
        // TOMBOL PERGI LAGI
        // =====================================
        bottomNavigationBar: SafeArea(
          top: false,
          child: Builder(
            builder: (context) {
              final double s = (MediaQuery.sizeOf(context).width / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Padding(
                padding: EdgeInsets.only(
                  left: 12 * s,
                  right: 12 * s,
                  top: 8 * s,
                  bottom: 10 * s,
                ),
                child: SizedBox(
                  height: 46 * s,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dufan-detail');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ecoGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5 * s),
                      ),
                    ),
                    child: Text(
                      'Pergi Lagi',
                      style: interStyle(
                        size: 14 * s,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =====================================
  // HEADER REKAP PERJALANAN
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
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * s),
          ),

          SizedBox(width: 4 * s),

          Text(
            'Rekap Perjalanan',
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
  // FOTO UTAMA DUFAN
  // =====================================
  Widget _buildHeroImage(double s, {bool compact = false}) {
    final double imageHeight = (compact ? 125 : 142) * s;

    return SizedBox(
      width: double.infinity,
      height: imageHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35 * s),
          bottomRight: Radius.circular(35 * s),
        ),
        child: Image.asset(
          'lib/images/dufan.png',
          width: double.infinity,
          height: imageHeight,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE5E5E5),
              child: const Center(
                child: Icon(Icons.image_outlined, color: Colors.grey, size: 40),
              ),
            );
          },
        ),
      ),
    );
  }

  // =====================================
  // INFORMASI PERJALANAN
  // =====================================
  Widget _buildTripInformation(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dunia Fantasi (DUFAN)',
            style: interStyle(size: 19 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 8 * s),

          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: const Color(0xFF666666),
                size: 16 * s,
              ),

              SizedBox(width: 7 * s),

              Text(
                '19 Februari 2025 | 12:00 WIB',
                style: interStyle(size: 11 * s, color: const Color(0xFF666666)),
              ),
            ],
          ),

          SizedBox(height: 6 * s),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.route_outlined,
                color: const Color(0xFF666666),
                size: 17 * s,
              ),

              SizedBox(width: 7 * s),

              Expanded(
                child: Text(
                  'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, '
                  'Jkt Utara, Daerah Khusus Ibukota Jakarta 14430',
                  style: interStyle(size: 10 * s, height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================
  // RUTE PERJALANAN
  // =====================================
  Widget _buildRouteSection(double s, {bool compact = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rute Perjalanan',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: (compact ? 8 : 10) * s),

          ClipRRect(
            borderRadius: BorderRadius.circular(10 * s),
            child: SizedBox(
              width: double.infinity,
              height: (compact ? 105 : 138) * s,
              child: Image.asset(
                'lib/images/peta.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE6EFE9),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 45 * s,
                        color: ecoGreen,
                      ),
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
  // TRANSPORTASI
  // PROPORSI KARTU DAN OVERLAY DIREVISI
  // =====================================
  Widget _buildTransportSection(double s, {bool compact = false}) {
    final double cardWidth = (compact ? 125 : 135) * s;
    final double cardHeight = (compact ? 175 : 195) * s;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transportasi',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: (compact ? 7 : 9) * s),

          ClipRRect(
            borderRadius: BorderRadius.circular(12 * s),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // FOTO OJEK ONLINE
                  Image.asset(
                    'lib/images/gojek.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFE1E1E1),
                        child: Center(
                          child: Icon(
                            Icons.two_wheeler,
                            color: ecoGreen,
                            size: 45 * s,
                          ),
                        ),
                      );
                    },
                  ),

                  // KOTAK HITAM TRANSPARAN
                  // DIPERKECIL AGAR FOTO TETAP TERLIHAT
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 59 * s,
                      color: Colors.black.withOpacity(0.72),
                    ),
                  ),

                  // TEKS INFORMASI OJEK ONLINE
                  Positioned(
                    left: 6 * s,
                    right: 6 * s,
                    bottom: 7 * s,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ojek Online',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interStyle(
                            size: 11 * s,
                            weight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),

                        SizedBox(height: 2 * s),

                        Text(
                          'Gojek, Grab, Maxim',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interStyle(
                            size: 9 * s,
                            weight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),

                        SizedBox(height: 1 * s),

                        Text(
                          'Nyaman, dan cepat',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interStyle(
                            size: 9 * s,
                            weight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // BAGAIMANA PERJALANANMU?
  // =====================================
  Widget _buildReviewPrompt(BuildContext context, double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 17 * s, vertical: 14 * s),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10 * s),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 4 * s,
              offset: Offset(0, 3 * s),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Bagaimana Perjalananmu?',
                    style: interStyle(size: 14 * s, weight: FontWeight.bold),
                  ),
                ),

                Icon(Icons.close, color: Colors.black87, size: 18 * s),
              ],
            ),

            SizedBox(height: 3 * s),

            Text(
              'Yuk beri ulasan untuk tempat yang baru kamu kunjungi !',
              style: interStyle(size: 10 * s, color: const Color(0xFF525252)),
            ),

            SizedBox(height: 13 * s),

            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/write-review');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 7 * s),
                    child: Icon(
                      Icons.star_border,
                      size: 27 * s,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
