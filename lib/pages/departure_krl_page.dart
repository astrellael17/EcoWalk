import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureKrlPage extends StatelessWidget {
  const DepartureKrlPage({super.key});

  static const Color ecoGreen = Color(0xFF176B5B);
  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);
  static const Color krlRed = Color(0xFFD32F2F);
  static const Color lightRed = Color(0xFFFFEBEE);

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
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '07.00',
                            ),
                            SizedBox(height: 14 * s),
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '07.20',
                            ),
                            SizedBox(height: 14 * s),
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '07.40',
                            ),
                            SizedBox(height: 14 * s),
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '08.00',
                            ),
                            SizedBox(height: 14 * s),
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '08.20',
                            ),
                            SizedBox(height: 14 * s),
                            _buildKrlCard(
                              s: s,
                              title: 'Keberangkatan',
                              badgeText: 'KRL Lin Bogor',
                              badgeColor: const Color(0xFFD32F2F),
                              routePath: 'Nambo ➔ Cawang',
                              instruction: 'Arah Jakarta Kota',
                              departureTime: '08.40',
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
              alignment: Alignment.bottomLeft,
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

  Widget _buildKrlCard({
    required double s,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required String routePath,
    required String instruction,
    required String departureTime,
  }) {
    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14 * s),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4 * s, color: badgeColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12 * s, 13 * s, 12 * s, 14 * s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12 * s,
                          fontWeight: FontWeight.w700,
                          color: secondaryText,
                        ),
                      ),
                      SizedBox(height: 11 * s),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 46 * s,
                            height: 46 * s,
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(11 * s),
                            ),
                            child: Icon(
                              Icons.directions_train,
                              color: Colors.white,
                              size: 24 * s,
                            ),
                          ),
                          SizedBox(width: 10 * s),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  badgeText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13 * s,
                                    fontWeight: FontWeight.w700,
                                    color: darkText,
                                  ),
                                ),
                                SizedBox(height: 4 * s),
                                Text(
                                  routePath,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * s,
                                    color: secondaryText,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7 * s),
                          Container(
                            width: 88 * s,
                            padding: EdgeInsets.symmetric(
                              horizontal: 5 * s,
                              vertical: 9 * s,
                            ),
                            decoration: BoxDecoration(
                              color: lightRed,
                              borderRadius: BorderRadius.circular(12 * s),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Berangkat',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 9 * s,
                                    color: secondaryText,
                                  ),
                                ),
                                SizedBox(height: 3 * s),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    departureTime,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 17 * s,
                                      fontWeight: FontWeight.w700,
                                      color: darkText,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3 * s),
                                Text(
                                  'WIB',
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
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFEAEAEA),
                      ),
                      SizedBox(height: 10 * s),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.route_outlined,
                            size: 16 * s,
                            color: secondaryText,
                          ),
                          SizedBox(width: 6 * s),
                          Expanded(
                            child: Text(
                              instruction,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11 * s,
                                height: 1.4,
                                color: darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10 * s),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 14 * s,
                          ),
                          SizedBox(width: 5 * s),
                          Expanded(
                            child: Text(
                              'Jadwal dapat berubah akibat gangguan operasional atau penyesuaian perjalanan kereta.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontSize: 10 * s,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
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
            height: 65 * s,
            color: ecoGreen.withOpacity(0.22),
          ),
          SizedBox(width: 12 * s),
          Expanded(
            child: Text(
              'Setelah tiba di Stasiun Cawang, perjalanan dapat dilanjutkan menuju Trans Studio Cibubur dengan transportasi darat (mikrotrans, ojek online, atau taksi online) sekitar ± 15–25 menit (± 7–10 km).',
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
