import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class MotorPribadiPage extends StatefulWidget {
  const MotorPribadiPage({super.key});

  @override
  State<MotorPribadiPage> createState() => _MotorPribadiPageState();
}

class _MotorPribadiPageState extends State<MotorPribadiPage> {
  static const Color darkText = Color(0xFF171717);
  static const Color borderGreen = Color(0xFF1B6B58);

  bool _isBiayaExpanded = false;
  bool _isEstimasiExpanded = false;
  bool _isKeberangkatanExpanded = false;
  bool _isKepadatanExpanded = false;
  bool _isRuteExpanded = false;
  bool _isKelebihanKekuranganExpanded = false;

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
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 24 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderAndBanner(
                            context,
                            s,
                            imagePath: 'lib/images/motor.jpeg',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 18 * s,
                              right: 18 * s,
                              top: 16 * s,
                              bottom: 16 * s,
                            ),
                            child: Text(
                              'MOTOR PRIBADI',
                              style: interStyle(
                                size: 22 * s,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18 * s),
                            child: Column(
                              children: [
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
                                        'Rp 20.000 - 40.000',
                                        style: interStyle(
                                          size: 13 * s,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2 * s),
                                      Text(
                                        '(estimasi biaya bensin, tergantung jarak perjalanan, jenis BBM, dan konsumsi bahan bakar motor)',
                                        style: interStyle(
                                          size: 12 * s,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                        '± 15 – 30 menit',
                                        style: interStyle(
                                          size: 13 * s,
                                          weight: FontWeight.bold,
                                        ),
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
                                        'Pengguna dapat berangkat kapan saja tanpa harus mengikuti jadwal transportasi umum. Waktu keberangkatan lebih fleksibel dan perjalanan dapat dilakukan langsung menuju tujuan tanpa perlu transit.',
                                        style: interStyle(
                                          size: 13 * s,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 7 * s),
                                      Text(
                                        'Waktu tempuh dapat berubah tergantung kondisi lalu lintas.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.red,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: interStyle(size: 13 * s),
                                          children: const [
                                            TextSpan(
                                              text: 'Kepadatan rute Klapanunggal – Trans Studio Cibubur umumnya ',
                                            ),
                                            TextSpan(
                                              text: 'Sedang',
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2 * s),
                                      Text(
                                        '(dapat meningkat pada jam sibuk, seperti pagi dan sore hari).',
                                        style: interStyle(
                                          size: 12 * s,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

  Widget _buildHeader(BuildContext context, double s) {
    return Container(
      width: double.infinity,
      height: 54 * s,
      color: borderGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23 * s),
          ),
          SizedBox(width: 4 * s),
          Text(
            'Kendaraan Pribadi',
            style: interStyle(
              size: 18 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAndBanner(
    BuildContext context,
    double s, {
    required String imagePath,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: 210 * s,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Icon(
                  Icons.directions_bike,
                  size: 60 * s,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: -10 * s,
          right: 18 * s,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 6 * s),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.zero,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Rekomendasi',
              style: interStyle(
                size: 12 * s,
                weight: FontWeight.bold,
                color: borderGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }

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
        color: isGreen ? const Color(0xFF457B6B) : Colors.white,
        borderRadius: BorderRadius.circular(10 * s),
        border: isGreen ? null : Border.all(color: borderGreen, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * s,
                right: 16 * s,
                top: isExpanded ? 10 * s : 14 * s,
                bottom: isExpanded ? 3 * s : 14 * s,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: interStyle(
                        size: 15 * s,
                        weight: FontWeight.bold,
                        color: isGreen ? Colors.white : darkText,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isGreen ? Colors.white : darkText,
                    size: 24 * s,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded && content != null)
            Padding(
              padding: EdgeInsets.only(
                left: 16 * s,
                right: 16 * s,
                top: 2 * s,
                bottom: 10 * s,
              ),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildRouteContent(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: borderGreen, size: 16 * s),
            SizedBox(width: 8 * s),
            Text(
              'Klapanunggal',
              style: interStyle(size: 13 * s, weight: FontWeight.bold),
            ),
          ],
        ),
        _buildDashedLine(s),
        Padding(
          padding: EdgeInsets.only(left: 24 * s),
          child: Text(
            'Jl. Raya Klapanunggal – Jl. Transyogi',
            style: interStyle(size: 13 * s),
          ),
        ),
        _buildDashedLine(s),
        Padding(
          padding: EdgeInsets.only(left: 24 * s),
          child: Text(
            'Jl. Alternatif Cibubur',
            style: interStyle(size: 13 * s),
          ),
        ),
        _buildDashedLine(s),
        Padding(
          padding: EdgeInsets.only(left: 24 * s),
          child: Text('Jl. Jambore', style: interStyle(size: 13 * s)),
        ),
        _buildDashedLine(s),
        Row(
          children: [
            Icon(Icons.location_on, color: borderGreen, size: 16 * s),
            SizedBox(width: 8 * s),
            Text(
              'Trans Studio Cibubur',
              style: interStyle(size: 13 * s, weight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashedLine(double s) {
    return Padding(
      padding: EdgeInsets.only(left: 7 * s, top: 4 * s, bottom: 4 * s),
      child: CustomPaint(
        size: Size(1, 16 * s),
        painter: _VerticalDashedLinePainter(),
      ),
    );
  }

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
        _buildBulletPoint(
          s,
          'Waktu lebih fleksibel dan dapat menyesuaikan rute.',
        ),
        _buildBulletPoint(s, 'Biaya relatif lebih hemat.'),
        _buildBulletPoint(s, 'Tidak perlu transit dan menunggu kendaraan.'),
        SizedBox(height: 14 * s),
        Text(
          'Kekurangan',
          style: interStyle(
            size: 14 * s,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6 * s),
        _buildBulletPoint(s, 'Terpapar risiko kecelakaan lebih tinggi.'),
        _buildBulletPoint(
          s,
          'Kurang nyaman saat cuaca buruk (hujan atau panas).',
        ),
        _buildBulletPoint(s, 'Tetap berpotensi terjebak macet pada jam sibuk.'),
      ],
    );
  }

  Widget _buildBulletPoint(double s, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: interStyle(
              size: 13 * s,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: interStyle(size: 13 * s, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    double y = 0;
    const dashHeight = 4.0;
    const dashSpace = 3.0;

    while (y < size.height) {
      canvas.drawLine(
        Offset(0, y),
        Offset(0, (y + dashHeight).clamp(0.0, size.height)),
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
