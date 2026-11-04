import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class MrtPage extends StatefulWidget {
  const MrtPage({super.key});

  @override
  State<MrtPage> createState() => _MrtPageState();
}

class _MrtPageState extends State<MrtPage> {
  static const Color darkText = Color(0xFF171717);
  static const Color borderGreen = Color(0xFF1B6B58);
  static const Color accordionBorder = Color(0xFF333333);
  static const Color accordionGreen = Color(0xFF528C7A);

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
                      padding: EdgeInsets.only(bottom: 28 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeroBanner(s, imagePath: 'lib/images/mrt.png'),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 18 * s,
                              right: 18 * s,
                              top: 16 * s,
                              bottom: 18 * s,
                            ),
                            child: Text(
                              'MRT Jakarta',
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
                                        'Rp3.000 – Rp14.000',
                                        style: interStyle(
                                          size: 13 * s,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4 * s),
                                      Text(
                                        'Tarif MRT Jakarta ditentukan berdasarkan stasiun keberangkatan dan stasiun tujuan.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Biaya transportasi menuju stasiun, perpindahan moda, dan perjalanan lanjutan belum termasuk.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.black54,
                                          height: 1.4,
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
                                        'Perjalanan MRT dari Lebak Bulus menuju Bundaran HI memerlukan waktu sekitar 30 menit.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Total waktu perjalanan dari Klapanunggal menuju Trans Studio Cibubur akan lebih lama karena membutuhkan akses menuju stasiun MRT serta transportasi penghubung.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Estimasi keseluruhan bergantung pada lokasi keberangkatan, jadwal, dan waktu transit.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.black54,
                                          height: 1.4,
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
                                        'MRT Jakarta melayani perjalanan pada lintas Lebak Bulus – Bundaran HI melalui stasiun-stasiun di Jakarta Selatan dan Jakarta Pusat.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                          style: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Keberangkatan mengikuti jadwal operasional MRT Jakarta dari stasiun yang dipilih.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Periksa arah perjalanan dan jadwal kereta karena MRT tidak memiliki stasiun langsung di kawasan Cibubur.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.redAccent,
                                          height: 1.4,
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
                                              '/departure-mrt',
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4 * s,
                                            ),
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
                                      Text(
                                        'Kepadatan penumpang MRT Jakarta dapat berubah sesuai jam keberangkatan dan stasiun yang dilalui.',
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
                                            size: 13 * s,
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
                                        'Pada jam berangkat dan pulang kerja, jumlah penumpang berpotensi meningkat, terutama di stasiun kawasan perkantoran.',
                                        style: interStyle(
                                          size: 12 * s,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: 6 * s),
                                      Text(
                                        'Informasi ini bersifat umum, bukan data kepadatan secara real-time.',
                                        style: interStyle(
                                          size: 11 * s,
                                          color: Colors.black54,
                                          height: 1.4,
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

  Widget _buildHeroBanner(double s, {required String imagePath}) {
    return SizedBox(
      width: double.infinity,
      height: 210 * s,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 210 * s,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE6ECE9),
                alignment: Alignment.center,
                child: Icon(Icons.subway, size: 60 * s, color: borderGreen),
              );
            },
          ),
          Positioned(
            right: 18 * s,
            bottom: -12 * s,
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
      margin: EdgeInsets.only(bottom: 12 * s),
      decoration: BoxDecoration(
        color: isGreen ? accordionGreen : Colors.white,
        borderRadius: BorderRadius.circular(8 * s),
        border: isGreen ? null : Border.all(color: accordionBorder, width: 1.2),
        boxShadow: isGreen
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 4 * s,
                  offset: Offset(0, 2 * s),
                ),
              ]
            : null,
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
                  top: 2 * s,
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
          text: 'Dari Klapanunggal, gunakan transportasi darat menuju stasiun MRT Jakarta yang sesuai dengan rencana perjalanan.',
          isFirst: true,
        ),
        _buildRouteStep(
          s,
          text: 'Naik MRT Jakarta pada jalur Lebak Bulus – Bundaran HI menuju Stasiun Dukuh Atas BNI, sesuai stasiun asal.',
        ),
        _buildRouteStep(
          s,
          text: 'Dari Dukuh Atas, berpindah ke LRT Jabodebek lintas Cibubur menuju Stasiun Harjamukti.',
        ),
        _buildRouteStep(
          s,
          text: 'Dari Stasiun Harjamukti, lanjutkan perjalanan menuju Trans Studio Cibubur.',
          isLast: true,
        ),
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
        SizedBox(height: 6 * s),
        Text(
          'Perjalanan MRT lebih terjadwal dan tidak terpengaruh kemacetan jalan raya.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4 * s),
        Text(
          'Stasiun dan kereta dilengkapi fasilitas yang mendukung kenyamanan penumpang.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
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
        Text(
          'Jangkauan MRT Jakarta belum mencakup Klapanunggal dan Trans Studio Cibubur secara langsung.',
          style: interStyle(
            size: 12 * s,
            color: Colors.white,
            height: 1.4,
            style: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4 * s),
        Text(
          'Membutuhkan transportasi penghubung dan perpindahan moda yang dapat menambah waktu serta biaya perjalanan.',
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
