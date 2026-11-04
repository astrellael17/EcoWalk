import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class DeparturePage extends StatelessWidget {
  const DeparturePage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);
  static const Color warningRed = Color(0xFFF04444);
  static const Color corridorYellow = Color(0xFFF5AC17);
  static const Color busOrange = Color(0xFFE68A13);

  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = darkText,
    double height = 1.2,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontStyle: fontStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double s = (MediaQuery.of(context).size.width / 390)
        .clamp(0.8, 1.2)
        .toDouble();

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
          child: Column(
            children: [
              _buildHeader(context, s),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30 * s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18 * s),
                        _buildMap(s),
                        SizedBox(height: 20 * s),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12 * s),
                          child: Column(
                            children: [
                              _buildDepartureCard(
                                s: s,
                                badgeText: 'Koridor',
                                badgeIcon: Icons.directions_bus,
                                badgeColor: corridorYellow,
                                badgeBackground: const Color(0xFFFFF3D8),
                                routeSubtitle: 'Ta → Kota',
                                timeEstimate: '11',
                                timeUnit: 'mnt',
                                statusText: 'Terlambat 11 mnt',
                              ),
                              SizedBox(height: 14 * s),
                              ...List.generate(
                                5,
                                (index) => Padding(
                                  padding: EdgeInsets.only(bottom: 14 * s),
                                  child: _buildDepartureCard(
                                    s: s,
                                    badgeText: 'Bus 2',
                                    badgeIcon: Icons.directions_bus,
                                    badgeColor: busOrange,
                                    badgeBackground: const Color(0xFFFFF0DE),
                                    routeSubtitle: 'lorem ipsum → blablabla',
                                    timeEstimate: '23.23',
                                    timeUnit: '',
                                    statusText: 'Dijadwalkan',
                                  ),
                                ),
                              ),
                              SizedBox(height: 8 * s),
                              _buildInformationBox(s),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double s) {
    return Container(
      width: double.infinity,
      height: 56 * s,
      color: ecoGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23 * s),
          ),
          SizedBox(width: 5 * s),
          Text(
            'Keberangkatan',
            style: interStyle(
              size: 17 * s,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(double s) {
    final double mapHeight = 210 * s;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17 * s),
        child: SizedBox(
          width: double.infinity,
          height: mapHeight,
          child: ClipRect(
            child: Transform.scale(
              scale: 1.12,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'lib/images/maps.jpg',
                width: double.infinity,
                height: mapHeight,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.medium,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5ECE9),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.map_outlined,
                      color: ecoGreen,
                      size: 48 * s,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepartureCard({
    required double s,
    required String badgeText,
    required IconData badgeIcon,
    required Color badgeColor,
    required Color badgeBackground,
    required String routeSubtitle,
    required String timeEstimate,
    required String timeUnit,
    required String statusText,
  }) {
    final bool isLate = badgeText == 'Koridor';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13 * s, vertical: 14 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * s),
        border: Border.all(color: const Color(0xFFE3E5E4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4 * s,
                height: 45 * s,
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(3 * s),
                ),
              ),
              SizedBox(width: 9 * s),
              Container(
                width: 44 * s,
                height: 44 * s,
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(11 * s),
                ),
                child: Icon(badgeIcon, color: Colors.white, size: 23 * s),
              ),
              SizedBox(width: 10 * s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Keberangkatan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(size: 14 * s, weight: FontWeight.w700),
                    ),
                    SizedBox(height: 3 * s),
                    Text(
                      '$badgeText · $routeSubtitle',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: interStyle(size: 11 * s, color: secondaryText),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 7 * s),
              Container(
                width: 83 * s,
                padding: EdgeInsets.symmetric(
                  horizontal: 5 * s,
                  vertical: 9 * s,
                ),
                decoration: BoxDecoration(
                  color: badgeBackground,
                  borderRadius: BorderRadius.circular(12 * s),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        timeEstimate,
                        maxLines: 1,
                        style: interStyle(
                          size: 16 * s,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (timeUnit.isNotEmpty) ...[
                      SizedBox(height: 2 * s),
                      Text(
                        timeUnit,
                        style: interStyle(size: 10 * s, color: secondaryText),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * s),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEAEAEA)),
          SizedBox(height: 10 * s),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isLate
                    ? Icons.access_time_outlined
                    : Icons.event_available_outlined,
                size: 16 * s,
                color: isLate ? warningRed : secondaryText,
              ),
              SizedBox(width: 6 * s),
              Expanded(
                child: Text(
                  statusText,
                  style: interStyle(
                    size: 11 * s,
                    color: isLate ? warningRed : secondaryText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7 * s),
          Text(
            'Bisa berubah tergantung kepadatan lalu lintas',
            style: interStyle(
              size: 10 * s,
              color: warningRed,
              fontStyle: FontStyle.italic,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationBox(double s) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15 * s, vertical: 16 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16 * s),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: ecoGreen, size: 28 * s),
          SizedBox(width: 12 * s),
          Container(
            width: 1,
            height: 49 * s,
            color: ecoGreen.withOpacity(0.22),
          ),
          SizedBox(width: 12 * s),
          Expanded(
            child: Text(
              'Pastikan halte dan rute perjalanan sudah sesuai. '
              'Jadwal keberangkatan dapat berubah tergantung '
              'kondisi lalu lintas serta operasional bus.',
              style: interStyle(
                size: 11 * s,
                color: darkText,
                weight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
