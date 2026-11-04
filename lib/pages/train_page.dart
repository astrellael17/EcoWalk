import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  static const Color darkText = Color(0xFF171717);
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

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 45 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FOTO KERETA
                          _buildHeroImage(s),

                          // INFORMASI TRANSPORTASI UMUM
                          _buildTransportInformation(s),

                          SizedBox(height: 20 * s),

                          // PETA PERJALANAN
                          _buildMap(s),

                          SizedBox(height: 17 * s),

                          // ANALISIS PERJALANAN
                          _buildTravelAnalysis(s),

                          SizedBox(height: 25 * s),

                          // OPSI TRANSPORTASI UMUM
                          _buildPublicTransportOptions(context, s),
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
  // FOTO KERETA
  // ASSET: train.png
  // =====================================
  Widget _buildHeroImage(double s) {
    return SizedBox(
      width: double.infinity,
      height: 174 * s,
      child: Image.asset(
        'lib/images/train.png',
        width: double.infinity,
        height: 174 * s,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFE5E5E5),
            alignment: Alignment.center,
            child: Icon(Icons.train, size: 55 * s, color: ecoGreen),
          );
        },
      ),
    );
  }

  // =====================================
  // INFORMASI TRANSPORTASI UMUM
  // =====================================
  Widget _buildTransportInformation(double s) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19 * s, right: 19 * s, top: 14 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transportasi Umum',
                style: interStyle(size: 18 * s, weight: FontWeight.bold),
              ),

              SizedBox(height: 9 * s),

              Row(
                children: [
                  Icon(Icons.payments_outlined, color: darkText, size: 16 * s),

                  SizedBox(width: 6 * s),

                  Text('Rp. 0 - 20.000', style: interStyle(size: 12 * s)),
                ],
              ),

              SizedBox(height: 5 * s),

              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: darkText,
                    size: 16 * s,
                  ),

                  SizedBox(width: 6 * s),

                  Text('1 Jam 45 Menit', style: interStyle(size: 12 * s)),
                ],
              ),
            ],
          ),
        ),

        // LABEL TERMURAH
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
              'Termurah',
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
  // ANALISIS PERJALANAN
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
          Text(
            'Analisis Perjalanan',
            style: interStyle(size: 14 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 15 * s),

          // =====================================
          // DIBANDINGKAN Kendaraan Pribadi
          // =====================================
          Text(
            'Dibandingkan Kendaraan Pribadi',
            style: interStyle(
              size: 12 * s,
              weight: FontWeight.w500,
              color: ecoGreen,
            ),
          ),

          SizedBox(height: 7 * s),

          _buildAnalysisRow(s, label: 'Waktu', value: '20-40 mnt Lebih cepat'),

          _buildAnalysisDivider(),

          _buildAnalysisRow(s, label: 'Hemat', value: 'Transportasi Umum'),

          _buildAnalysisDivider(),

          _buildAnalysisRow(s, label: 'Kenyamanan', value: 'Kendaraan Pribadi'),
        ],
      ),
    );
  }

  // =====================================
  // BARIS ANALISIS
  // =====================================
  Widget _buildAnalysisRow(
    double s, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6 * s),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: interStyle(size: 11 * s)),
          ),

          SizedBox(width: 6 * s),

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
  // OPSI TRANSPORTASI UMUM
  // OJEK ONLINE SUDAH DIHAPUS
  // =====================================
  Widget _buildPublicTransportOptions(BuildContext context, double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Opsi Transportasi Umum',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 13 * s),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 9 * s),
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
                // TRANS JAKARTA
                // =====================================
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/transjakarta');
                  },
                  child: _buildTransportOption(
                    s,
                    name: 'Trans Jakarta',
                    time: '40 menit',
                    imagePath: 'lib/images/icontransjkt.png',
                    fallbackEmoji: '🚌',
                  ),
                ),

                _buildOptionDivider(),

                // =====================================
                // MRT JAKARTA
                // =====================================
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/mrt');
                  },
                  child: _buildTransportOption(
                    s,
                    name: 'MRT Jakarta',
                    time: '25 menit',
                    imagePath: 'lib/images/iconmrt.png',
                    fallbackEmoji: '🚇',
                  ),
                ),

                _buildOptionDivider(),

                // =====================================
                // LRT JABODEBEK
                // =====================================
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/lrt');
                  },
                  child: _buildTransportOption(
                    s,
                    name: 'LRT Jabodetabek',
                    time: '30 menit',
                    imagePath: 'lib/images/iconlrt.png',
                    fallbackEmoji: '🚋',
                  ),
                ),

                _buildOptionDivider(),

                // =====================================
                // KRL COMMUTER LINE
                // =====================================
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/detail-train');
                  },
                  child: _buildTransportOption(
                    s,
                    name: 'KRL Commuter Line',
                    time: '35 menit',
                    imagePath: 'lib/images/iconkrl.png',
                    fallbackEmoji: '🚆',
                  ),
                ),

                _buildOptionDivider(),

                // =====================================
                // MIKROTRANS (JAKLINGKO)
                // =====================================
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/jaklingko');
                  },
                  child: _buildTransportOption(
                    s,
                    name: 'Mikrotrans (JakLingko)',
                    time: '30 menit',
                    imagePath: 'lib/images/iconmikrotrans.png',
                    fallbackEmoji: '🚐',
                  ),
                ),

                // Ojek Online dan divider terakhir
                // dihapus dari daftar kendaraan umum.
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // WIDGET OPSI KENDARAAN
  // IKON BERWARNA TETAP DIPERTAHANKAN
  // =====================================
  Widget _buildTransportOption(
    double s, {
    required String name,
    required String time,
    required String imagePath,
    required String fallbackEmoji,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24 * s,
                height: 24 * s,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      fallbackEmoji,
                      style: TextStyle(fontSize: 18 * s),
                    );
                  },
                ),
              ),

              SizedBox(width: 12 * s),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: interStyle(size: 14 * s, weight: FontWeight.w600),
                  ),

                  SizedBox(height: 2 * s),

                  Text(
                    '± $time',
                    style: interStyle(size: 11 * s, color: Colors.grey[600]!),
                  ),
                ],
              ),
            ],
          ),

          Text(
            'Detail',
            style: interStyle(size: 12 * s, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // =====================================
  // DIVIDER OPSI TRANSPORTASI
  // =====================================
  Widget _buildOptionDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2));
  }
}
