import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureLrtPage extends StatelessWidget {
  const DepartureLrtPage({super.key});

  static const Color ecoGreen = Color(0xFF176B5B);
  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);
  static const Color lrtOrange = Color(0xFFFF5722);
  static const Color lightOrange = Color(0xFFFFEDE6);

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
                            _buildLrtCard(
                              s: s,
                              title: 'Keberangkatan',
                              routePath: 'Klapanunggal ➔ Harjamukti',
                              instruction: 'Menuju kawasan stasiun dengan transportasi darat',
                              timeEstimate: '± 25 – 35',
                              estimateLabel: 'Estimasi',
                            ),
                            SizedBox(height: 14 * s),
                            _buildLrtCard(
                              s: s,
                              title: 'Lintas LRT',
                              routePath: 'Dukuh Atas BNI ➔ Harjamukti',
                              instruction:
                                  'Lintas Cibubur, arah menuju Cibubur',
                              timeEstimate: '± 42 – 48',
                              estimateLabel: 'Estimasi LRT',
                            ),
                            SizedBox(height: 14 * s),
                            _buildLrtCard(
                              s: s,
                              title: 'Stasiun',
                              routePath: 'Cawang ➔ Taman Mini',
                              instruction:
                                  'Urutan lintas Cibubur ke arah Harjamukti',
                              timeEstimate: '± 6 – 8',
                              estimateLabel: 'Estimasi LRT',
                            ),
                            SizedBox(height: 14 * s),
                            _buildLrtCard(
                              s: s,
                              title: 'Stasiun',
                              routePath: 'Kampung Rambutan ➔ Ciracas',
                              instruction:
                                  'Lanjutan perjalanan menuju Harjamukti',
                              timeEstimate: '± 4 – 6',
                              estimateLabel: 'Estimasi LRT',
                            ),
                            SizedBox(height: 14 * s),
                            _buildLrtCard(
                              s: s,
                              title: 'Stasiun Tujuan',
                              routePath: 'Harjamukti',
                              instruction: 'Stasiun ujung terdekat dengan Trans Studio Cibubur',
                              timeEstimate: '± 1 – 2',
                              estimateLabel: 'Estimasi LRT',
                            ),
                            SizedBox(height: 14 * s),
                            _buildLrtCard(
                              s: s,
                              title: 'Menuju Tujuan',
                              routePath: 'Harjamukti ➔ Trans Studio Cibubur',
                              instruction:
                                  'Dapat berjalan kaki ±11 menit\n'
                                  '(menurut rujukan Google Maps pengguna)',
                              timeEstimate: '± 11',
                              estimateLabel: 'Estimasi',
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

  Widget _buildLrtCard({
    required double s,
    required String title,
    required String routePath,
    required String instruction,
    required String timeEstimate,
    required String estimateLabel,
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
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13 * s,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),
          SizedBox(height: 11 * s),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4 * s,
                height: 44 * s,
                decoration: BoxDecoration(
                  color: lrtOrange,
                  borderRadius: BorderRadius.circular(3 * s),
                ),
              ),
              SizedBox(width: 9 * s),
              Container(
                width: 44 * s,
                height: 44 * s,
                decoration: BoxDecoration(
                  color: lrtOrange,
                  borderRadius: BorderRadius.circular(11 * s),
                ),
                child: Icon(
                  Icons.directions_subway,
                  color: Colors.white,
                  size: 23 * s,
                ),
              ),
              SizedBox(width: 10 * s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'LRT Jabodebek',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14 * s,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 3 * s),
                    Text(
                      routePath,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                width: 89 * s,
                padding: EdgeInsets.symmetric(
                  horizontal: 5 * s,
                  vertical: 9 * s,
                ),
                decoration: BoxDecoration(
                  color: lightOrange,
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
                          fontSize: 14 * s,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),
                    SizedBox(height: 3 * s),
                    Text(
                      estimateLabel,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9 * s,
                        color: secondaryText,
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
              Icon(Icons.route_outlined, size: 16 * s, color: secondaryText),
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
              'LRT tidak berangkat langsung dari Klapanunggal. '
              'Sesuaikan akses darat menuju Harjamukti.',
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
