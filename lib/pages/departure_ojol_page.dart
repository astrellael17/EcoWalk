import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureOjolPage extends StatelessWidget {
  const DepartureOjolPage({super.key});

  static const Color ecoGreen = Color(0xFF176B5B);
  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    final double s = (MediaQuery.of(context).size.width / 400)
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
                    padding: EdgeInsets.only(bottom: 28 * s),
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
                              _buildOjolCard(
                                s: s,
                                badgeText: 'Ojek Cepat',
                                badgeIcon: Icons.two_wheeler,
                                badgeColor: const Color(0xFF00C853),
                                badgeBackground: const Color(0xFFE5F8EC),
                                routeSubtitle: 'Titik Jemput – Tujuan',
                                description: 'Driver terdekat tersedia (12 driver di sekitar)',
                                timeEstimate: '3–5',
                              ),

                              SizedBox(height: 14 * s),

                              _buildOjolCard(
                                s: s,
                                badgeText: 'Ojek Reguler',
                                badgeIcon: Icons.two_wheeler,
                                badgeColor: const Color(0xFFFF9800),
                                badgeBackground: const Color(0xFFFFF1DB),
                                routeSubtitle: 'Sesuai Titik Penjemputan',
                                description: 'Estimasi penjemputan standar',
                                timeEstimate: '5–8',
                              ),

                              SizedBox(height: 14 * s),

                              _buildOjolCard(
                                s: s,
                                badgeText: 'Ojek Murah',
                                badgeIcon: Icons.two_wheeler,
                                badgeColor: const Color(0xFF03A9F4),
                                badgeBackground: const Color(0xFFE5F5FE),
                                routeSubtitle: 'Titik Temu Jalan Utama',
                                description: 'Tarif lebih hemat dengan jalan kaki singkat',
                                timeEstimate: '8–12',
                              ),

                              SizedBox(height: 22 * s),

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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23 * s),
          ),

          SizedBox(width: 5 * s),

          Text(
            'Keberangkatan',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 17 * s,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * s),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17 * s),
        child: SizedBox(
          width: double.infinity,
          height: 210 * s,
          child: ClipRect(
            child: Transform.scale(
              scale: 1.08,
              alignment: const Alignment(-0.75, 0),
              child: Image.asset(
                'lib/images/maps.jpg',
                width: double.infinity,
                height: 210 * s,
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

  Widget _buildOjolCard({
    required double s,
    required String badgeText,
    required IconData badgeIcon,
    required Color badgeColor,
    required Color badgeBackground,
    required String routeSubtitle,
    required String description,
    required String timeEstimate,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 14 * s),
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
                height: 43 * s,
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(3 * s),
                ),
              ),

              SizedBox(width: 9 * s),

              Container(
                width: 43 * s,
                height: 43 * s,
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
                      badgeText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15 * s,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    SizedBox(height: 3 * s),

                    Text(
                      routeSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11 * s,
                        color: secondaryText,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 6 * s),

              Container(
                width: 89 * s,
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
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15 * s,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),

                    SizedBox(height: 2 * s),

                    Text(
                      'menit',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10 * s,
                        color: secondaryText,
                      ),
                    ),
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
              Icon(Icons.info_outline, size: 16 * s, color: secondaryText),

              SizedBox(width: 6 * s),

              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11 * s,
                    height: 1.35,
                    color: darkText,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 7 * s),

          Text(
            'Bisa berubah tergantung ketersediaan driver dan kondisi lalu lintas',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: 10 * s,
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
              'Pastikan titik penjemputan sesuai dan mudah '
              'dijangkau pengemudi',
              style: TextStyle(
                fontFamily: 'Inter',
                color: darkText,
                fontSize: 11 * s,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
