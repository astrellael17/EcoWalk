import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureTaksiPage extends StatelessWidget {
  const DepartureTaksiPage({super.key});

  static const Color ecoGreen = Color(0xFF176B5B);
  static const Color darkText = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF555555);
  static const Color bluebirdColor = Color(0xFF0862CF);
  static const Color gocarColor = Color(0xFF00875A);
  static const Color gocarCheapColor = Color(0xFF52B44B);

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
              final double s = (constraints.maxWidth / 400)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  _buildHeader(context, s),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
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
                                _buildTaksiCard(
                                  s: s,
                                  badgeText: 'GoBluebird',
                                  badgeIcon: Icons.flight_takeoff,
                                  badgeColor: bluebirdColor,
                                  badgeBackground: const Color(0xFFE7F1FF),
                                  routeSubtitle: 'Taksi Resmi Bluebird',
                                  pickupLocation:
                                      'Titik penjemputan: Klapanunggal, Bogor',
                                  timeEstimate: '± 5 – 10',
                                ),

                                SizedBox(height: 14 * s),

                                _buildTaksiCard(
                                  s: s,
                                  badgeText: 'Gocar Cepat',
                                  badgeIcon: Icons.directions_car,
                                  badgeColor: gocarColor,
                                  badgeBackground: const Color(0xFFE5F5ED),
                                  routeSubtitle: 'Layanan lebih cepat',
                                  pickupLocation:
                                      'Titik penjemputan: Klapanunggal, Bogor',
                                  timeEstimate: '± 3 – 5',
                                ),

                                SizedBox(height: 14 * s),

                                _buildTaksiCard(
                                  s: s,
                                  badgeText: 'Gocar Murah',
                                  badgeIcon: Icons.directions_car,
                                  badgeColor: gocarCheapColor,
                                  badgeBackground: const Color(0xFFE8F6E8),
                                  routeSubtitle: 'Tarif lebih hemat',
                                  pickupLocation:
                                      'Titik penjemputan: Klapanunggal, Bogor',
                                  timeEstimate: '± 8 – 12',
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

  Widget _buildTaksiCard({
    required double s,
    required String badgeText,
    required IconData badgeIcon,
    required Color badgeColor,
    required Color badgeBackground,
    required String routeSubtitle,
    required String pickupLocation,
    required String timeEstimate,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * s),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 9 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: 4 * s,
            child: ColoredBox(color: badgeColor),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: 17 * s,
              right: 13 * s,
              top: 15 * s,
              bottom: 15 * s,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 47 * s,
                      height: 47 * s,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(12 * s),
                      ),
                      child: Icon(badgeIcon, color: Colors.white, size: 24 * s),
                    ),

                    SizedBox(width: 10 * s),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 7 * s),

                    Container(
                      constraints: BoxConstraints(minWidth: 76 * s),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8 * s,
                        vertical: 9 * s,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBackground,
                        borderRadius: BorderRadius.circular(12 * s),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            timeEstimate,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14 * s,
                              fontWeight: FontWeight.w700,
                              color: darkText,
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

                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFEAEAEA),
                ),

                SizedBox(height: 10 * s),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16 * s, color: secondaryText),

                    SizedBox(width: 5 * s),

                    Expanded(
                      child: Text(
                        pickupLocation,
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
                  'Estimasi penjemputan dan tarif dapat berubah sesuai kondisi lalu lintas.',
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
              'Pastikan lokasi penjemputan sudah sesuai. '
              'Estimasi kedatangan dan tarif dapat berubah '
              'tergantung kondisi lalu lintas serta '
              'ketersediaan pengemudi.',
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
