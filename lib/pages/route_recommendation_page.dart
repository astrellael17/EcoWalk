import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class RouteRecommendationPage extends StatelessWidget {
  const RouteRecommendationPage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color lightGrey = Color(0xFFEEEEEE);

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

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context)?.settings.arguments;

    String origin = 'KLAPANUNGGAL';
    String destination = 'Trans Studio Cibubur';

    if (routeArguments is Map) {
      final originValue = routeArguments['origin'];
      final destinationValue = routeArguments['destination'];

      if (originValue is String && originValue.trim().isNotEmpty) {
        origin = originValue.trim();
      }

      if (destinationValue is String && destinationValue.trim().isNotEmpty) {
        destination = destinationValue.trim();
      }
    }

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
                          SizedBox(height: 36 * s),
                          _buildLocationCard(
                            s,
                            origin: origin,
                            destination: destination,
                          ),
                          SizedBox(height: 27 * s),
                          _buildLogo(s),
                          SizedBox(height: 17 * s),
                          _buildTravelEstimates(s),
                          SizedBox(height: 17 * s),
                          _buildMap(s),
                          SizedBox(height: 20 * s),
                          _buildTransportationSection(context, s),
                          SizedBox(height: 20 * s),
                          _buildSuggestionBox(s),
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
            'Rekomendasi',
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

  Widget _buildLocationCard(
    double s, {
    required String origin,
    required String destination,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24 * s),
      padding: EdgeInsets.symmetric(horizontal: 18 * s, vertical: 17 * s),
      decoration: BoxDecoration(
        color: ecoGreen,
        borderRadius: BorderRadius.circular(9 * s),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 19 * s,
            child: Column(
              children: [
                Container(
                  width: 11 * s,
                  height: 11 * s,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 4 * s),
                SizedBox(
                  height: 34 * s,
                  child: CustomPaint(painter: _DashedLinePainter()),
                ),
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 17 * s,
                ),
              ],
            ),
          ),
          SizedBox(width: 15 * s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Titik Asal',
                  style: interStyle(size: 9 * s, color: Colors.white70),
                ),
                SizedBox(height: 3 * s),
                Text(
                  origin,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: interStyle(
                    size: 12 * s,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8 * s),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white54,
                ),
                SizedBox(height: 10 * s),
                Text(
                  'Titik Akhir',
                  style: interStyle(size: 9 * s, color: Colors.white70),
                ),
                SizedBox(height: 3 * s),
                Text(
                  destination,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: interStyle(
                    size: 12 * s,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * s),
      child: Image.asset(
        'lib/images/logo_ecowalk_white.png',
        width: 119 * s,
        height: 35 * s,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        color: ecoGreen,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }

  Widget _buildTravelEstimates(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * s),
      child: Row(
        children: [
          _buildEstimateItem(
            s,
            icon: Icons.directions_walk,
            time: '13 menit',
            highlighted: true,
          ),
          SizedBox(width: 6 * s),
          _buildEstimateItem(
            s,
            icon: Icons.directions_car_outlined,
            time: '5 menit',
          ),
          SizedBox(width: 6 * s),
          _buildEstimateItem(s, icon: Icons.two_wheeler, time: '4 menit'),
          SizedBox(width: 6 * s),
          _buildEstimateItem(
            s,
            icon: Icons.directions_bus_outlined,
            time: '18 menit',
          ),
        ],
      ),
    );
  }

  Widget _buildEstimateItem(
    double s, {
    required IconData icon,
    required String time,
    bool highlighted = false,
  }) {
    return Expanded(
      child: Container(
        height: 29 * s,
        padding: EdgeInsets.symmetric(horizontal: 2 * s),
        decoration: BoxDecoration(
          color: highlighted ? lightGrey : Colors.white,
          borderRadius: BorderRadius.circular(6 * s),
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black87, size: 16 * s),
              SizedBox(width: 4 * s),
              Text(
                time,
                style: interStyle(size: 11 * s, weight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * s),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10 * s),
        child: SizedBox(
          width: double.infinity,
          height: 202 * s,
          child: Image.asset(
            'lib/images/peta.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE6EFE9),
                child: Center(
                  child: Icon(
                    Icons.map_outlined,
                    color: ecoGreen,
                    size: 52 * s,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTransportationSection(BuildContext context, double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Opsi Kendaraan',
            style: interStyle(size: 19 * s, weight: FontWeight.bold),
          ),
          SizedBox(height: 16 * s),
          LayoutBuilder(
            builder: (context, constraints) {
              final double spacing = 12 * s;
              final double cardWidth = 94 * s;
              final double cardHeight = 136 * s;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTransportCard(
                    s,
                    width: cardWidth,
                    height: cardHeight,
                    imagePath: 'lib/images/gojek.png',
                    title: 'Kendaraan Pribadi',
                    description:
                        'Taxi, Ojek, Motor, Mobil\n'
                        'Nyaman dan Cepat',
                    onTap: () {
                      Navigator.pushNamed(context, '/ojek-online');
                    },
                  ),
                  SizedBox(width: spacing),
                  _buildTransportCard(
                    s,
                    width: cardWidth,
                    height: cardHeight,
                    imagePath: 'lib/images/krl.png',
                    title: 'Transportasi Umum',
                    description:
                        'KRL, LRT, MRT\n'
                        'Hemat dan Murah',
                    onTap: () {
                      Navigator.pushNamed(context, '/train');
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransportCard(
    double s, {
    required double width,
    required double height,
    required String imagePath,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9 * s),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.medium,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: lightGrey,
                    child: Center(
                      child: Icon(
                        Icons.directions_transit,
                        color: ecoGreen,
                        size: 30 * s,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: height * 0.55,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5 * s,
                right: 5 * s,
                bottom: 6 * s,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(
                        size: 9 * s,
                        weight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 3 * s),
                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(
                        size: 7 * s,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionBox(double s) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24 * s),
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
      decoration: BoxDecoration(
        color: ecoGreen,
        borderRadius: BorderRadius.circular(9 * s),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mau Nyaman & Cepat? 👉 Kendaraan Pribadi',
            style: interStyle(size: 13 * s, color: Colors.white),
          ),
          SizedBox(height: 5 * s),
          Text(
            'Mau Murah & Praktis? 👉 Transportasi Umum',
            style: interStyle(size: 13 * s, color: Colors.white),
          ),
          SizedBox(height: 5 * s),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final x = size.width / 2;

    const dashHeight = 3.0;
    const dashSpace = 3.0;

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
