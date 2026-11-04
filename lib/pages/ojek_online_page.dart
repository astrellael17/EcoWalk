import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class OjekOnlinePage extends StatelessWidget {
  const OjekOnlinePage({super.key});

  static const Color darkText = Color(0xFF171717);
  static const Color greyText = Color(0xFF555555);
  static const Color cardGrey = Color(0xFFF4F4F4);

  // =====================================
  // FONT INTER
  // =====================================
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

  // =====================================
  // HALAMAN UTAMA
  // =====================================
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
              final double s = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  _buildHeader(context, s),

                  // KONTEN DAPAT DI-SCROLL
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 30 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FOTO OJEK ONLINE
                          _buildHeroImage(s),

                          // INFORMASI DAN LABEL TERCEPAT
                          _buildOjekInformation(s),

                          SizedBox(height: 20 * s),

                          // PETA PERJALANAN
                          _buildMap(s),

                          SizedBox(height: 17 * s),

                          // ANALISIS PERJALANAN
                          _buildTravelAnalysis(s),

                          SizedBox(height: 24 * s),

                          // OPSI KENDARAAN PRIBADI
                          _buildPersonalVehicleOptions(context, s),
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

  // =====================================
  // HEADER REKOMENDASI
  // =====================================
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

  // =====================================
  // FOTO OJEK ONLINE
  // =====================================
  Widget _buildHeroImage(double s) {
    return SizedBox(
      width: double.infinity,
      height: 174 * s,
      child: ClipRect(
        child: Image.asset(
          'lib/images/ojek.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 174 * s,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE6EFE9),
              alignment: Alignment.center,
              child: Icon(Icons.two_wheeler, size: 45 * s, color: ecoGreen),
            );
          },
        ),
      ),
    );
  }

  // =====================================
  // INFORMASI OJEK ONLINE
  // =====================================
  Widget _buildOjekInformation(double s) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19 * s, right: 19 * s, top: 14 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kendaraan Pribadi',
                style: interStyle(size: 18 * s, weight: FontWeight.bold),
              ),

              SizedBox(height: 9 * s),

              // HARGA
              Row(
                children: [
                  Icon(Icons.payments_outlined, size: 16 * s, color: darkText),

                  SizedBox(width: 6 * s),

                  Text('Rp. 30.000 - 45.000', style: interStyle(size: 12 * s)),
                ],
              ),

              SizedBox(height: 5 * s),

              // WAKTU PERJALANAN
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 16 * s,
                    color: darkText,
                  ),

                  SizedBox(width: 6 * s),

                  Text('-+ 20 - 40 Menit', style: interStyle(size: 12 * s)),
                ],
              ),
            ],
          ),
        ),

        // =====================================
        // LABEL TERCEPAT
        // =====================================
        Positioned(
          top: -13 * s,
          right: 19 * s,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13 * s, vertical: 7 * s),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6 * s),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 5 * s,
                  offset: Offset(0, 2 * s),
                ),
              ],
            ),
            child: Text(
              'Tercepat',
              style: interStyle(
                size: 11 * s,
                weight: FontWeight.w600,
                color: ecoGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================
  // PETA PERJALANAN
  // =====================================
  Widget _buildMap(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19 * s),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10 * s),
        child: SizedBox(
          width: double.infinity,
          height: 203 * s,
          child: Image.asset(
            'lib/images/peta.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE6EFE9),
                alignment: Alignment.center,
                child: Icon(Icons.map_outlined, size: 48 * s, color: ecoGreen),
              );
            },
          ),
        ),
      ),
    );
  }

  // =====================================
  // KOTAK ANALISIS PERJALANAN
  // =====================================
  Widget _buildTravelAnalysis(double s) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 19 * s),
      padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 15 * s),
      decoration: BoxDecoration(
        color: cardGrey,
        borderRadius: BorderRadius.circular(11 * s),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 5 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL UTAMA
          Text(
            'Analisis Perjalanan',
            style: interStyle(size: 14 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 15 * s),

          // =====================================
          // DIBANDINGKAN Transportasi UMUM
          // =====================================
          Text(
            'Dibandingkan Transportasi Umum',
            style: interStyle(
              size: 12 * s,
              weight: FontWeight.w500,
              color: ecoGreen,
            ),
          ),

          SizedBox(height: 7 * s),

          _buildAnalysisRow(s, label: 'Waktu', value: 'Lebih cepat & nyaman'),

          _buildAnalysisDivider(),

          _buildAnalysisRow(s, label: 'Hemat', value: 'Transportasi Umum'),

          _buildAnalysisDivider(),

          _buildAnalysisRow(s, label: 'Kenyamanan', value: 'Kendaraan Pribadi'),
        ],
      ),
    );
  }

  // =====================================
  // SATU BARIS ANALISIS
  // =====================================
  Widget _buildAnalysisRow(
    double s, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: interStyle(size: 11 * s)),
          ),

          SizedBox(width: 7 * s),

          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: interStyle(size: 11 * s),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // GARIS PEMISAH ANALISIS
  // =====================================
  Widget _buildAnalysisDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2));
  }

  // =====================================
  // OPSI KENDARAAN PRIBADI
  // TAKSI - OJEK ONLINE - MOTOR - MOBIL
  // =====================================
  Widget _buildPersonalVehicleOptions(BuildContext context, double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL KATEGORI
          Text(
            'Opsi Kendaraan Pribadi',
            style: interStyle(size: 16 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 15 * s),

          // KOTAK DAFTAR KENDARAAN
          Container(
            decoration: BoxDecoration(
              color: cardGrey,
              borderRadius: BorderRadius.circular(11 * s),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 5 * s,
                  offset: Offset(0, 3 * s),
                ),
              ],
            ),
            child: Column(
              children: [
                // =====================================
                // 1. TAxi
                // =====================================
                _buildVehicleOptionRow(
                  s,
                  emoji: '🚕',
                  title: 'Taxi',
                  time: '± 30 menit',
                  onTap: () {
                    Navigator.pushNamed(context, '/taksi');
                  },
                ),

                _buildAnalysisDivider(),

                // =====================================
                // 2. OJEK ONLINE
                // DIPINDAHKAN DARI TRANSPORTASI UMUM
                // =====================================
                _buildVehicleOptionRow(
                  s,
                  emoji: '🛵',
                  title: 'Ojek Online',
                  time: '15 menit',
                  onTap: () {
                    Navigator.pushNamed(context, '/detail-ojol');
                  },
                ),

                _buildAnalysisDivider(),

                // =====================================
                // 3. MOTOR
                // =====================================
                _buildVehicleOptionRow(
                  s,
                  emoji: '🏍️',
                  title: 'Motor',
                  time: '± 25 menit',
                  onTap: () {
                    Navigator.pushNamed(context, '/motor-pribadi');
                  },
                ),

                _buildAnalysisDivider(),

                // =====================================
                // 4. MOBIL
                // =====================================
                _buildVehicleOptionRow(
                  s,
                  emoji: '🚗',
                  title: 'Mobil',
                  time: '± 35 menit',
                  onTap: () {
                    Navigator.pushNamed(context, '/mobil-pribadi');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // ITEM DAFTAR KENDARAAN PRIBADI
  // =====================================
  Widget _buildVehicleOptionRow(
    double s, {
    required String emoji,
    required String title,
    required String time,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 12 * s),
        child: Row(
          children: [
            // IKON KENDARAAN BERWARNA
            SizedBox(
              width: 24 * s,
              height: 30 * s,
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: 21 * s, height: 1.1),
                ),
              ),
            ),

            SizedBox(width: 12 * s),

            // TEKS JUDUL DAN WAKTU
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: interStyle(size: 13 * s, weight: FontWeight.w600),
                  ),

                  SizedBox(height: 3 * s),

                  Text(
                    time,
                    style: interStyle(
                      size: 11 * s,
                      color: ecoGreen,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // TOMBOL DETAIL
            Text(
              'Detail',
              style: interStyle(size: 12 * s, weight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
