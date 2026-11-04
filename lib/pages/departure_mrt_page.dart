import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureMrtPage extends StatelessWidget {
  const DepartureMrtPage({super.key});

  static const Color ecoGreen = Color(0xFF176B5B);
  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);
  static const Color warningRed = Color(0xFFE34B43);

  @override
  Widget build(BuildContext context) {
    final double s = (MediaQuery.sizeOf(context).width / 400)
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
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 1',
                              badgeColor: const Color(0xFF00695C),
                              badgeBackground: const Color(0xFFE4F3EE),
                              routeSubtitle: 'Feeder ➔ MRT',
                              description: 'Berangkat dari Klapanunggal menuju stasiun penghubung MRT',
                              travelTime: '1j 15',
                            ),
                            SizedBox(height: 14 * s),
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 2',
                              badgeColor: const Color(0xFF1565C0),
                              badgeBackground: const Color(0xFFE6F0FC),
                              routeSubtitle: 'Feeder Reguler',
                              description: 'Transit menuju koridor MRT dengan rute reguler',
                              travelTime: '1j 20',
                            ),
                            SizedBox(height: 14 * s),
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 3',
                              badgeColor: const Color(0xFF6A1B9A),
                              badgeBackground: const Color(0xFFF2E8F8),
                              routeSubtitle: 'MRT Cepat',
                              description: 'Rute lebih cepat dengan perpindahan moda yang lebih singkat',
                              travelTime: '1j 25',
                            ),
                            SizedBox(height: 14 * s),
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 4',
                              badgeColor: const Color(0xFFEF6C00),
                              badgeBackground: const Color(0xFFFFEFE1),
                              routeSubtitle: 'MRT Reguler',
                              description: 'Pilihan standar untuk perjalanan ke arah Cibubur',
                              travelTime: '1j 28',
                            ),
                            SizedBox(height: 14 * s),
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 5',
                              badgeColor: const Color(0xFF00838F),
                              badgeBackground: const Color(0xFFE2F3F4),
                              routeSubtitle: 'Transit 2x',
                              description: 'Perlu dua kali perpindahan sebelum menuju tujuan akhir',
                              travelTime: '1j 32',
                            ),
                            SizedBox(height: 14 * s),
                            _buildMrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'MRT 6',
                              badgeColor: const Color(0xFFC2185B),
                              badgeBackground: const Color(0xFFFBE6EF),
                              routeSubtitle: 'MRT Alternatif',
                              description: 'Rute alternatif saat pilihan utama lebih padat',
                              travelTime: '1j 38',
                            ),
                          ],
                        ),
                      ),
                    ],
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
              alignment: const Alignment(-0.5, 1.0),
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

  Widget _buildMrtCard({
    required double s,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBackground,
    required String routeSubtitle,
    required String description,
    required String travelTime,
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
                height: 44 * s,
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
                child: Icon(Icons.train, color: Colors.white, size: 23 * s),
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
                        height: 1.25,
                        color: secondaryText,
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
                        travelTime,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),
                    SizedBox(height: 2 * s),
                    Text(
                      'estimasi',
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
              Icon(Icons.route_outlined, size: 16 * s, color: secondaryText),
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
            'Estimasi dapat berubah tergantung jadwal feeder dan waktu transit',
            style: TextStyle(
              fontFamily: 'Inter',
              color: warningRed,
              fontStyle: FontStyle.italic,
              fontSize: 10 * s,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
