import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color linkBlue = Color(0xFF159DD8);
  static const Color separatorColor = Color(0xFFE5E5E5);

  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = darkText,
    double height = 1.2,
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
  // DATA NOTIFIKASI CONTOH SESUAI FIGMA
  // =====================================
  List<Map<String, dynamic>> get notifications => [
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'weather',
      'title': 'Cuaca Sedang Cerah',
      'date': '19 Februari 2025',
      'description': 'Yuk keluar dan jalan-jalan!',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
    {
      'type': 'trip',
      'title': 'Dunia Fantasi (DUFAN)',
      'date': '19 Februari 2025',
      'description': 'Transportasi Umum',
      'status': 'Selesai',
    },
  ];

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

              final items = notifications;

              return Column(
                children: [
                  _buildHeader(context, s),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24 * s,
                        vertical: 2 * s,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          thickness: 1,
                          color: separatorColor,
                        );
                      },
                      itemBuilder: (context, index) {
                        final notification = items[index];

                        if (notification['type'] == 'weather') {
                          return _buildWeatherNotification(
                            context,
                            s,
                            notification,
                          );
                        }

                        return _buildTripNotification(context, s, notification);
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
  // HEADER NOTIFIKASI
  // =====================================
  Widget _buildHeader(BuildContext context, double s) {
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
            'Notifikasi',
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
  // NOTIFIKASI PERJALANAN DUFAN
  // BISA DIKLIK MENUJU REKAP PERJALANAN
  // =====================================
  Widget _buildTripNotification(
    BuildContext context,
    double s,
    Map<String, dynamic> notification,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/trip-summary');
      },
      child: SizedBox(
        width: double.infinity,
        height: 85 * s,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GAMBAR ABU-ABU SESUAI FIGMA
            Container(
              width: 57 * s,
              height: 51 * s,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(9 * s),
              ),
            ),

            SizedBox(width: 14 * s),

            // INFORMASI PERJALANAN
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['title'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interStyle(size: 13 * s, weight: FontWeight.bold),
                  ),

                  SizedBox(height: 3 * s),

                  Text(
                    notification['date'] as String,
                    style: interStyle(
                      size: 8 * s,
                      color: const Color(0xFF626262),
                    ),
                  ),

                  SizedBox(height: 3 * s),

                  Text(
                    notification['description'] as String,
                    style: interStyle(size: 9 * s, color: darkText),
                  ),

                  SizedBox(height: 3 * s),

                  // =====================================
                  // PERGI LAGI TETAP MENUJU DETAIL DUFAN
                  // =====================================
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/dufan-detail');
                    },
                    child: Text(
                      'Pergi Lagi',
                      style: interStyle(
                        size: 9 * s,
                        weight: FontWeight.w500,
                        color: linkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 5 * s),

            // STATUS SELESAI
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 9 * s,
                  height: 9 * s,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF236553),
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 7 * s),
                ),

                SizedBox(width: 3 * s),

                Text(
                  notification['status'] as String,
                  style: interStyle(size: 7 * s, weight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // NOTIFIKASI CUACA
  // =====================================
  Widget _buildWeatherNotification(
    BuildContext context,
    double s,
    Map<String, dynamic> notification,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 95 * s,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ICON MATAHARI SESUAI FIGMA
          SizedBox(
            width: 57 * s,
            height: 57 * s,
            child: CustomPaint(painter: _SunIconPainter()),
          ),

          SizedBox(width: 14 * s),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: interStyle(size: 13 * s, weight: FontWeight.bold),
                ),

                SizedBox(height: 3 * s),

                Text(
                  notification['date'] as String,
                  style: interStyle(
                    size: 8 * s,
                    color: const Color(0xFF626262),
                  ),
                ),

                SizedBox(height: 3 * s),

                Text(
                  notification['description'] as String,
                  style: interStyle(size: 9 * s),
                ),

                SizedBox(height: 3 * s),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/category');
                  },
                  child: Text(
                    'Lihat Destinasi Wisata',
                    style: interStyle(
                      size: 9 * s,
                      weight: FontWeight.w500,
                      color: linkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================
// CUSTOM ICON MATAHARI
// =====================================
class _SunIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.shortestSide * 0.24;
    final double rayStart = size.shortestSide * 0.35;
    final double rayEnd = size.shortestSide * 0.48;

    final Paint rayPaint = Paint()
      ..color = const Color(0xFFFFC900)
      ..strokeWidth = size.shortestSide * 0.045
      ..strokeCap = StrokeCap.round;

    // SINAR MATAHARI
    for (int i = 0; i < 12; i++) {
      final double angle = (i * 30) * math.pi / 180;

      final Offset start = Offset(
        centerX + math.cos(angle) * rayStart,
        centerY + math.sin(angle) * rayStart,
      );

      final Offset end = Offset(
        centerX + math.cos(angle) * rayEnd,
        centerY + math.sin(angle) * rayEnd,
      );

      canvas.drawLine(start, end, rayPaint);
    }

    // LINGKARAN MATAHARI
    final Paint sunPaint = Paint()
      ..color = const Color(0xFFFFE000)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), radius, sunPaint);

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFFFBC00)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
