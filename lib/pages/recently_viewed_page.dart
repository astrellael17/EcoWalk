import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color dividerColor = Color(0xFFE8E8E8);

  // =====================================
  // FONT INTER
  // =====================================
  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = darkText,
    double height = 1.1,
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
  // DATA SESUAI FIGMA
  // =====================================
  List<Map<String, String>> get destinations => List.generate(
    4,
    (index) => {
      'name': 'Dunia Fantasi (DUFAN)',
      'rating': '4.75',
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta Utara',
      'price': 'Mulai dari Rp. 200.000',
    },
  );

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

              final items = destinations;

              return Column(
                children: [
                  _buildHeader(context, s),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor,
                        );
                      },
                      itemBuilder: (context, index) {
                        return _buildDestinationItem(context, s, items[index]);
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

  // =====================================
  // HEADER TERAKHIR DILIHAT
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
            'Terakhir Dilihat',
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
  // ITEM DUFAN SESUAI FIGMA
  // UKURAN DAN JARAK TETAP SAMA
  // =====================================
  Widget _buildDestinationItem(
    BuildContext context,
    double s,
    Map<String, String> destination,
  ) {
    return InkWell(
      // =====================================
      // REVISI NAVIGASI:
      // DUFAN MENUJU VIEWED DETAIL PAGE
      // =====================================
      onTap: () {
        Navigator.pushNamed(context, '/viewed-detail');
      },

      child: SizedBox(
        width: double.infinity,
        height: 94 * s,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12 * s),
          child: Row(
            children: [
              // =====================================
              // LINGKARAN ABU-ABU
              // =====================================
              Container(
                width: 52 * s,
                height: 52 * s,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: 10 * s),

              // =====================================
              // INFORMASI DUFAN
              // =====================================
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAMA DESTINASI
                    Text(
                      destination['name'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(
                        size: 13 * s,
                        weight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),

                    SizedBox(height: 3 * s),

                    // RATING DAN JAM OPERASIONAL
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: const Color(0xFFFFCB05),
                          size: 12 * s,
                        ),

                        SizedBox(width: 2 * s),

                        Flexible(
                          child: Text(
                            '${destination['rating']} | ${destination['hours']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: interStyle(size: 10 * s, height: 1.1),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3 * s),

                    // LOKASI DESTINASI
                    Text(
                      destination['location'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(size: 10 * s, height: 1.1),
                    ),

                    SizedBox(height: 3 * s),

                    // HARGA TIKET
                    Text(
                      destination['price'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(size: 10 * s, height: 1.1),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 7 * s),

              Icon(Icons.chevron_right, color: Colors.black, size: 21 * s),
            ],
          ),
        ),
      ),
    );
  }
}
