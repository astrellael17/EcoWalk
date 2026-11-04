import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TransjakartaPage extends StatefulWidget {
  const TransjakartaPage({super.key});

  @override
  State<TransjakartaPage> createState() => _TransjakartaPageState();
}

class _TransjakartaPageState extends State<TransjakartaPage> {
  static const Color darkText = Color(0xFF171717);
  static const Color accordionBorder = Color(0xFF333333);
  static const Color accordionGreen = Color(0xFF176B5B);

  final Set<int> _expandedIndexes = <int>{};

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

  void _toggleAccordion(int index) {
    setState(() {
      if (_expandedIndexes.contains(index)) {
        _expandedIndexes.remove(index);
      } else {
        _expandedIndexes.add(index);
      }
    });
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
                              'TransJakarta',
                              style: interStyle(
                                size: 20 * s,
                                weight: FontWeight.bold,
                                height: 1.05,
                              ),
                            ),
                          ),
                          _buildAccordionSection(s),
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
              'lib/images/tj.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE5E5E5),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.directions_bus,
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

  Widget _buildAccordionSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18 * s),
      child: Column(
        children: [
          _buildAccordion(
            s,
            index: 0,
            title: 'Biaya',
            content: Text(
              'Rp 3.500 (tarif flat TransJakarta)',
              style: interStyle(
                size: 12 * s,
                height: 1.4,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 12 * s),
          _buildAccordion(
            s,
            index: 1,
            title: 'Estimasi',
            content: Text(
              '±60-75 menit (tergantung kondisi lalu lintas '
              'dan waktu tunggu)',
              style: interStyle(
                size: 12 * s,
                height: 1.4,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 12 * s),
          _buildAccordion(
            s,
            index: 2,
            title: 'Keberangkatan',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perkiraan keberangkatan dari Halte Duri Kepa:',
                  style: interStyle(
                    size: 12 * s,
                    height: 1.4,
                  ).copyWith(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 4 * s),
                Text(
                  'Pukul 18.00 WIB',
                  style: interStyle(
                    size: 12 * s,
                    height: 1.4,
                  ).copyWith(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 6 * s),
                Text(
                  'Bisa berubah tergantung kepadatan lalu lintas',
                  style: interStyle(
                    size: 11 * s,
                    color: const Color(0xFFE96F56),
                    height: 1.4,
                  ).copyWith(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 7 * s),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/departure');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4 * s),
                      child: Text(
                        'Selengkapnya',
                        style: interStyle(
                          size: 11 * s,
                          color: const Color(0xFF51B6D6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * s),
          _buildAccordion(
            s,
            index: 3,
            title: 'Informasi Kepadatan',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kepadatan di Halte SSSSS tergolong',
                  style: interStyle(
                    size: 12 * s,
                    height: 1.4,
                  ).copyWith(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 3 * s),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rendah',
                        style: interStyle(
                          size: 12 * s,
                          color: const Color(0xFF49A66A),
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: '/',
                        style: interStyle(size: 12 * s),
                      ),
                      TextSpan(
                        text: 'Sedang',
                        style: interStyle(
                          size: 12 * s,
                          color: const Color(0xFFD59D00),
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: '/',
                        style: interStyle(
                          size: 12 * s,
                          color: const Color(0xFFE54B4B),
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: 'Tinggi',
                        style: interStyle(
                          size: 12 * s,
                          color: const Color(0xFFE54B4B),
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * s),
          _buildAccordion(
            s,
            index: 4,
            title: 'Rute yang dilalui',
            content: _buildRouteTimeline(s),
          ),
          SizedBox(height: 12 * s),
          _buildAccordion(
            s,
            index: 5,
            title: 'Kelebihan & Kekurangan',
            isGreen: true,
            content: _buildAdvantagesContent(s),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTimeline(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineStep(
          s,
          text:
              'Dari Kedoya Selatan, naik mikrotrans atau ojek '
              'online menuju ke halte Kedoya Green Garden',
          isFirst: true,
        ),
        _buildTimelineStep(
          s,
          text: 'Naik Koridor 8 TransJakarta menuju Halte Harmoni',
        ),
        _buildTimelineStep(
          s,
          text:
              'Transit di Halte Harmoni, lalu naik ke Koridor 1 '
              'ke Halte Monas',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep(
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

  Widget _buildAdvantagesContent(double s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletText(s, 'Biaya Terjangkau'),
        _buildBulletText(
          s,
          'Jalur khusus bus mengurangi risiko terjebak macet',
        ),
        SizedBox(height: 9 * s),
        Text(
          'Kekurangan',
          style: interStyle(
            size: 13 * s,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 7 * s),
        _buildBulletText(s, 'Perlu transit dan menunggu bus di setiap halte'),
        _buildBulletText(s, 'Kepadatan penumpang pada jam sibuk'),
      ],
    );
  }

  Widget _buildBulletText(double s, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: interStyle(size: 12 * s, color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: interStyle(
                size: 12 * s,
                color: Colors.white,
                height: 1.35,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordion(
    double s, {
    required int index,
    required String title,
    required Widget content,
    bool isGreen = false,
  }) {
    final bool isExpanded = _expandedIndexes.contains(index);
    final Color backgroundColor = isGreen ? accordionGreen : Colors.white;
    final Color foregroundColor = isGreen ? Colors.white : darkText;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8 * s),
        border: isGreen ? null : Border.all(color: accordionBorder, width: 1.2),
        boxShadow: isGreen
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
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
              onTap: () => _toggleAccordion(index),
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
                        isGreen && isExpanded ? 'Kelebihan' : title,
                        style: interStyle(
                          size: 14 * s,
                          weight: FontWeight.w700,
                          color: foregroundColor,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22 * s,
                      color: foregroundColor,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
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
}
