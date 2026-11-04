import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class LrtPage extends StatefulWidget {
  const LrtPage({super.key});

  @override
  State<LrtPage> createState() => _LrtPageState();
}

class _LrtPageState extends State<LrtPage> {
  static const Color darkText = Color(0xFF171717);
  static const Color borderGreen = Color(0xFF1B6B58);
  static const Color accordionGreen = Color(0xFF176B5B);

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
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: true,
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
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 25 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeroImage(s),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 18 * s,
                              right: 18 * s,
                              top: 14 * s,
                              bottom: 18 * s,
                            ),
                            child: Text(
                              'LRT Jabodebek',
                              style: interStyle(
                                size: 20 * s,
                                weight: FontWeight.bold,
                                height: 1.05,
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
                                        'Mulai Rp5.000',
                                        style: interStyle(
                                          size: 13 * s,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4 * s),
                                      Text(
                                        'Tarif LRT Jabodebek dihitung berdasarkan jarak perjalanan dan waktu masuk stasiun.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Maksimal Rp20.000 saat jam sibuk hari kerja dan Rp10.000 di luar jam sibuk, akhir pekan, serta hari libur nasional.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Biaya transportasi menuju stasiun dan dari stasiun tujuan belum termasuk.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.black54,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12 * s),
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
                                        'Waktu perjalanan bergantung pada stasiun keberangkatan, waktu tunggu, dan akses menuju tujuan.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Perjalanan dari Klapanunggal juga perlu memperhitungkan waktu menuju stasiun LRT dan perjalanan lanjutan ke Trans Studio Cibubur.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12 * s),
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
                                        'Keberangkatan mengikuti jadwal operasional LRT Jabodebek pada lintas Cibubur dengan tujuan akhir Stasiun Harjamukti.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Pastikan stasiun asal dan arah perjalanan sudah sesuai sebelum naik kereta.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Jadwal dan interval kedatangan dapat berubah sesuai operasional LRT.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.redAccent,
                                          height: 1.35,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 8 * s),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/departure-lrt',
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4 * s,
                                            ),
                                            child: Text(
                                              'Selengkapnya',
                                              style: interStyle(
                                                size: 11 * s,
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12 * s),
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
                                      Text(
                                        'Kepadatan penumpang LRT dapat berbeda sesuai jam perjalanan dan stasiun yang dilalui.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Kategori kepadatan:',
                                        style: interStyle(size: 12 * s),
                                      ),
                                      SizedBox(height: 4 * s),
                                      RichText(
                                        text: TextSpan(
                                          style: interStyle(
                                            size: 12 * s,
                                            weight: FontWeight.bold,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Rendah',
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                            TextSpan(text: ' / '),
                                            TextSpan(
                                              text: 'Sedang',
                                              style: TextStyle(
                                                color: Colors.amber,
                                              ),
                                            ),
                                            TextSpan(text: ' / '),
                                            TextSpan(
                                              text: 'Tinggi',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Kategori ini merupakan informasi umum dan bukan data kepadatan real-time.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.black54,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12 * s),
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
                                SizedBox(height: 12 * s),
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
                                SizedBox(height: 24 * s),
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
            'Transportasi Umum',
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

  Widget _buildHeroImage(double s) {
    return SizedBox(
      width: double.infinity,
      height: 210 * s,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            color: const Color(0xFFE0E7E4),
            child: Image.asset(
              'lib/images/banner_lrt.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE5E5E5),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.directions_railway,
                    color: ecoGreen,
                    size: 55 * s,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: -12 * s,
            right: 18 * s,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14 * s,
                vertical: 7 * s,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.zero,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 5 * s,
                    offset: Offset(0, 2 * s),
                  ),
                ],
              ),
              child: Text(
                'Rekomendasi',
                style: interStyle(
                  size: 12 * s,
                  weight: FontWeight.bold,
                  color: ecoGreen,
                ),
              ),
            ),
          ),
        ],
      ),
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
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isGreen ? accordionGreen : Colors.white,
        borderRadius: BorderRadius.circular(8 * s),
        border: isGreen ? null : Border.all(color: borderGreen, width: 1.2),
        boxShadow: isGreen
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4 * s,
                  offset: Offset(0, 2 * s),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 3 * s,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16 * s,
                  right: 16 * s,
                  top: isExpanded ? 10 * s : 15 * s,
                  bottom: isExpanded ? 3 * s : 15 * s,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: interStyle(
                          size: 14 * s,
                          weight: FontWeight.w700,
                          color: isGreen ? Colors.white : darkText,
                        ),
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
      ),
    );
  }

  Widget _buildRouteContent(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRouteStep(
          s,
          text: 'Dari Klapanunggal, menuju stasiun LRT Jabodebek yang sesuai menggunakan transportasi darat.',
          isFirst: true,
        ),
        _buildRouteStep(
          s,
          text: 'Naik LRT Jabodebek lintas Cibubur menuju Stasiun Harjamukti.',
        ),
        _buildRouteStep(
          s,
          text: 'Turun di Stasiun Harjamukti, kemudian lanjutkan perjalanan menuju kawasan Trans Studio Cibubur.',
        ),
        _buildRouteStep(s, text: 'Tiba di Trans Studio Cibubur.', isLast: true),
      ],
    );
  }

  Widget _buildRouteStep(
    double s, {
    required String text,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24 * s,
            child: Column(
              children: [
                SizedBox(height: 2 * s),
                if (isFirst || isLast)
                  Icon(Icons.location_on, size: 16 * s, color: ecoGreen)
                else
                  Container(
                    width: 7 * s,
                    height: 7 * s,
                    margin: EdgeInsets.symmetric(vertical: 4 * s),
                    decoration: const BoxDecoration(
                      color: darkText,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.2 * s,
                      margin: EdgeInsets.symmetric(vertical: 3 * s),
                      color: const Color(0xFF8A8A8A),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 7 * s),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2 * s, bottom: isLast ? 0 : 18 * s),
              child: Text(text, style: interStyle(size: 12 * s, height: 1.45)),
            ),
          ),
        ],
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
        SizedBox(height: 4 * s),
        Text(
          'Waktu perjalanan kereta lebih terprediksi karena tidak terpengaruh kemacetan jalan raya.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4 * s),
        Text(
          'Tarif perjalanan relatif terjangkau dengan layanan kereta yang nyaman.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
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
        SizedBox(height: 4 * s),
        Text(
          'Perlu transportasi tambahan apabila lokasi awal atau tujuan tidak berada dekat stasiun.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4 * s),
        Text(
          'Penumpang harus menyesuaikan jadwal perjalanan dan berpotensi menghadapi kepadatan pada jam sibuk.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
