import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TaksiPage extends StatefulWidget {
  const TaksiPage({super.key});

  @override
  State<TaksiPage> createState() => _TaksiPageState();
}

class _TaksiPageState extends State<TaksiPage> {
  static const Color darkText = Color(0xFF171717);

  // Status terbuka/tertutup untuk masing-masing menu
  bool _isBiayaExpanded = false;
  bool _isEstimasiExpanded = false;
  bool _isKeberangkatanExpanded = false;
  bool _isKepadatanExpanded = false;
  bool _isRuteExpanded = false;
  bool _isKelebihanKekuranganExpanded = false;

  // =====================================
  // FONT INTER
  // =====================================
  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = darkText,
    double height = 1.2,
    FontStyle style = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontStyle: style,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER TETAP DI ATAS
                  _buildHeader(context, s),

                  // KONTEN DAPAT DI-SCROLL
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 30 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FOTO TAKSI BESAR DAN LABEL REKOMENDASI
                          _buildHeroSection(s),

                          SizedBox(height: 25 * s),

                          // KONTEN BAWAH (JUDUL & LIST MENU)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18 * s),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // JUDUL
                                Text(
                                  'TAXI',
                                  style: interStyle(
                                    size: 22 * s,
                                    weight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 20 * s),

                                // =====================================
                                // BIAYA
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Biaya',
                                  isExpanded: _isBiayaExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isBiayaExpanded = !_isBiayaExpanded;
                                    });
                                  },
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rp 75.000 - 120.000',
                                        style: interStyle(size: 13 * s),
                                      ),

                                      SizedBox(height: 2 * s),

                                      Text(
                                        '(tergantung jarak, rute, dan aplikasi)',
                                        style: interStyle(
                                          size: 12 * s,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =====================================
                                // ESTIMASI
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Estimasi',
                                  isExpanded: _isEstimasiExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isEstimasiExpanded =
                                          !_isEstimasiExpanded;
                                    });
                                  },
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '± 20–30 menit',
                                        style: interStyle(size: 13 * s),
                                      ),

                                      SizedBox(height: 2 * s),

                                      Text(
                                        '(tergantung kondisi lalu lintas)',
                                        style: interStyle(
                                          size: 12 * s,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =====================================
                                // KEBERANGKATAN
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Keberangkatan',
                                  isExpanded: _isKeberangkatanExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isKeberangkatanExpanded =
                                          !_isKeberangkatanExpanded;
                                    });
                                  },
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dapat dipesan melalui aplikasi:\n'
                                        'Blue Bird, GrabCar, GoCar, atau langsung\n'
                                        'di pangkalan taksi.',
                                        style: interStyle(
                                          size: 13 * s,
                                          height: 1.4,
                                        ),
                                      ),

                                      SizedBox(height: 8 * s),

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/departure-taksi',
                                            );
                                          },
                                          child: Text(
                                            'Selengkapnya',
                                            style: interStyle(
                                              size: 12 * s,
                                              color: Colors.lightBlue,
                                              style: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =====================================
                                // INFORMASI KEPADATAN
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Informasi Kepadatan',
                                  isExpanded: _isKepadatanExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isKepadatanExpanded =
                                          !_isKepadatanExpanded;
                                    });
                                  },
                                  content: RichText(
                                    text: TextSpan(
                                      style: interStyle(
                                        size: 13 * s,
                                        height: 1.4,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text:
                                              'Kepadatan rute Klapanunggal – Trans Studio\n'
                                              'Cibubur umumnya ',
                                        ),
                                        TextSpan(
                                          text: 'Sedang\n',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '(dapat meningkat pada jam sibuk, seperti\n'
                                              'pagi dan sore hari).',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // =====================================
                                // RUTE YANG DILALUI
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Rute yang dilalui',
                                  isExpanded: _isRuteExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isRuteExpanded = !_isRuteExpanded;
                                    });
                                  },
                                  content: _buildRouteContent(s),
                                ),

                                // =====================================
                                // KELEBIHAN DAN KEKURANGAN
                                // =====================================
                                _buildAccordionItem(
                                  s,
                                  title: 'Kelebihan & Kekurangan',
                                  isGreen: true,
                                  isExpanded: _isKelebihanKekuranganExpanded,
                                  onTap: () {
                                    setState(() {
                                      _isKelebihanKekuranganExpanded =
                                          !_isKelebihanKekuranganExpanded;
                                    });
                                  },
                                  content: _buildProsConsContent(s),
                                ),
                              ],
                            ),
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
  // HEADER HALAMAN
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
            'Kendaraan Pribadi',
            style: interStyle(
              size: 16 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // BAGIAN FOTO TAKSI DAN LABEL REKOMENDASI
  // =====================================
  Widget _buildHeroSection(double s) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // FOTO TAKSI
        SizedBox(
          width: double.infinity,
          height: 210 * s,
          child: Image.asset(
            'lib/images/taxi.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.directions_car,
                  size: 50 * s,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
        ),

        // LABEL REKOMENDASI DI KANAN BAWAH
        Positioned(
          bottom: -15 * s,
          right: 20 * s,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 8 * s),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6 * s),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Rekomendasi',
              style: interStyle(
                size: 13 * s,
                weight: FontWeight.bold,
                color: ecoGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================
  // ITEM DAFTAR MENU (ACCORDION)
  // =====================================
  Widget _buildAccordionItem(
    double s, {
    required String title,
    bool isGreen = false,
    required bool isExpanded,
    required VoidCallback onTap,
    Widget? content,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * s),
      decoration: BoxDecoration(
        color: isGreen ? ecoGreen : Colors.white,
        borderRadius: BorderRadius.circular(8 * s),
        border: isGreen ? null : Border.all(color: Colors.black, width: 1.2),
        boxShadow: isGreen
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================
          // JUDUL ACCORDION
          // JARAK LEBIH RAPAT SAAT TERBUKA
          // =====================================
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * s,
                right: 16 * s,
                top: isExpanded ? 10 * s : 15 * s,
                bottom: isExpanded ? 3 * s : 15 * s,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: interStyle(
                      size: 14 * s,
                      weight: FontWeight.w700,
                      color: isGreen ? Colors.white : darkText,
                    ),
                  ),

                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isGreen ? Colors.white : darkText,
                    size: 22 * s,
                  ),
                ],
              ),
            ),
          ),

          // =====================================
          // ISI ACCORDION
          // TIDAK ADA RUANG KOSONG BERLEBIHAN
          // =====================================
          if (isExpanded && content != null)
            Padding(
              padding: EdgeInsets.only(
                left: 16 * s,
                right: 16 * s,
                top: 0,
                bottom: 10 * s,
              ),
              child: content,
            ),
        ],
      ),
    );
  }

  // =====================================
  // WIDGET KONTEN: RUTE YANG DILALUI
  // =====================================
  Widget _buildRouteContent(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRouteItem(
          s,
          icon: Icons.location_on,
          text: 'Klapanunggal',
          color: ecoGreen,
        ),

        _buildRouteLine(s),

        _buildRouteItem(
          s,
          icon: Icons.circle,
          text: 'Jl. Raya Klapanunggal – Jl. Transyogi',
          size: 6,
          color: Colors.black,
        ),

        _buildRouteLine(s),

        _buildRouteItem(
          s,
          icon: Icons.circle,
          text: 'Jl. Alternatif Cibubur',
          size: 6,
          color: Colors.black,
        ),

        _buildRouteLine(s),

        _buildRouteItem(
          s,
          icon: Icons.circle,
          text: 'Jl. Jambore',
          size: 6,
          color: Colors.black,
        ),

        _buildRouteLine(s),

        _buildRouteItem(
          s,
          icon: Icons.location_on,
          text: 'Trans Studio Cibubur',
          color: ecoGreen,
        ),
      ],
    );
  }

  Widget _buildRouteItem(
    double s, {
    required IconData icon,
    required String text,
    required Color color,
    double size = 18,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20 * s,
          child: Center(
            child: Icon(icon, color: color, size: size * s),
          ),
        ),

        SizedBox(width: 8 * s),

        Text(
          text,
          style: interStyle(size: 13 * s, weight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRouteLine(double s) {
    return Container(
      margin: EdgeInsets.only(left: 9.5 * s, top: 4 * s, bottom: 4 * s),
      height: 15 * s,
      child: CustomPaint(painter: _VerticalDashedLinePainter()),
    );
  }

  // =====================================
  // WIDGET KONTEN: KELEBIHAN & KEKURANGAN
  // =====================================
  Widget _buildProsConsContent(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kelebihan',
          style: interStyle(
            size: 14 * s,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 6 * s),

        _buildBulletText(s, 'Nyaman dan lebih privat.'),

        _buildBulletText(
          s,
          'Waktu tempuh relatif lebih cepat\n'
          'dibandingkan transportasi umum.',
        ),

        _buildBulletText(
          s,
          'Tersedia 24 jam dan mudah dipesan\n'
          'melalui aplikasi.',
        ),

        SizedBox(height: 12 * s),

        Text(
          'Kekurangan',
          style: interStyle(
            size: 14 * s,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 6 * s),

        _buildBulletText(
          s,
          'Biaya lebih mahal dibandingkan\n'
          'transportasi umum.',
        ),

        _buildBulletText(
          s,
          'Tetap berpotensi terjebak macet, terutama\n'
          'pada jam sibuk.',
        ),

        _buildBulletText(s, 'Kurang ramah lingkungan karena emisi kendaraan.'),
      ],
    );
  }

  Widget _buildBulletText(double s, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4 * s, right: 6 * s),
            child: Icon(Icons.circle, size: 5 * s, color: Colors.white),
          ),

          Expanded(
            child: Text(
              text,
              style: interStyle(size: 12 * s, color: Colors.white, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================
// GARIS PUTUS-PUTUS VERTIKAL
// =====================================
class _VerticalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final x = size.width / 2;
    const dashHeight = 3.0;
    const dashSpace = 2.0;
    double y = 0;

    while (y < size.height) {
      canvas.drawLine(
        Offset(x, y),
        Offset(x, (y + dashHeight).clamp(0.0, size.height)),
        paint,
      );

      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
