import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  static const Color backgroundColor = Color(0xFFD4E3DF);
  static const Color darkText = Color(0xFF111111);

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
        backgroundColor: backgroundColor,
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
                      padding: EdgeInsets.only(bottom: 30 * s),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainWeather(s),

                          _buildWeatherInformation(s),

                          SizedBox(height: 21 * s),

                          _buildTodayWeather(s),

                          SizedBox(height: 27 * s),

                          _buildDailyForecast(s),

                          SizedBox(height: 32 * s),

                          _buildDailyActivities(s),
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
  // HEADER HIJAU
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
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * s),
          ),

          SizedBox(width: 4 * s),

          Text(
            'Cuaca',
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

  // =====================================
  // PERKIRAAN CUACA UTAMA
  // =====================================
  Widget _buildMainWeather(double s) {
    return Padding(
      padding: EdgeInsets.only(left: 13 * s, right: 13 * s, top: 23 * s),
      child: SizedBox(
        width: double.infinity,
        height: 140 * s,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // INFORMASI CUACA DI KIRI
            Positioned(
              top: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perkiraan Cuaca',
                    style: interStyle(size: 19 * s, weight: FontWeight.bold),
                  ),

                  SizedBox(height: 2 * s),

                  Text('Klapanunggal, Bogor', style: interStyle(size: 12 * s)),

                  SizedBox(height: 18 * s),

                  Text(
                    '30°C',
                    style: interStyle(
                      size: 45 * s,
                      weight: FontWeight.bold,
                      height: 1,
                    ),
                  ),

                  SizedBox(height: 7 * s),

                  Text(
                    'Cerah Berawan',
                    style: interStyle(size: 13 * s, weight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // GAMBAR AWAN DAN MATAHARI DIPERBESAR
            Positioned(
              top: -8 * s,
              right: 0,
              child: Image.asset(
                'lib/images/cuaca.png',
                width: 200 * s,
                height: 155 * s,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: 200 * s,
                    height: 155 * s,
                    child: Icon(
                      Icons.wb_cloudy_outlined,
                      color: const Color(0xFF078BC3),
                      size: 110 * s,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // INFORMASI CUACA
  // KOTAK KELEMBAPAN DAN KUALITAS UDARA
  // =====================================
  Widget _buildWeatherInformation(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildInfoCard(
              s,
              label: 'Kelembapan',
              value: '92%',
              icon: Icons.cloud_outlined,
            ),
          ),

          SizedBox(width: 14 * s),

          Expanded(
            child: _buildInfoCard(
              s,
              label: 'Kualitas Udara',
              value: '39.1',
              icon: Icons.air,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // KOTAK HIJAU INFORMASI CUACA
  // =====================================
  Widget _buildInfoCard(
    double s, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      height: 78 * s,
      padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 8 * s),
      decoration: BoxDecoration(
        color: ecoGreen,
        borderRadius: BorderRadius.circular(9 * s),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ICON DAN LABEL SEJAJAR
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 15 * s),

              SizedBox(width: 6 * s),

              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: interStyle(
                    size: 10 * s,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 5 * s),

          // NILAI DI BAWAH LABEL
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: interStyle(
                size: 23 * s,
                weight: FontWeight.bold,
                color: Colors.white,
                height: 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // BAGIAN HARI INI
  // =====================================
  Widget _buildTodayWeather(double s) {
    final List<String> hours = ['Sekarang', '07:00', '08:00', '09:00', '10:00'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13 * s),
          child: Text(
            'Hari ini',
            style: interStyle(size: 14 * s, weight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 10 * s),

        SizedBox(
          height: 101 * s,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 13 * s),
            itemCount: hours.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 9 * s);
            },
            itemBuilder: (context, index) {
              return _buildHourlyCard(s, time: hours[index]);
            },
          ),
        ),
      ],
    );
  }

  // =====================================
  // KARTU CUACA PER JAM
  // =====================================
  Widget _buildHourlyCard(double s, {required String time}) {
    return Container(
      // LEBAR KARTU DISESUAIKAN AGAR
      // KARTU TERAKHIR HANYA TERLIHAT SEDIKIT
      width: 84 * s,
      height: 101 * s,
      padding: EdgeInsets.symmetric(horizontal: 5 * s, vertical: 8 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10 * s),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'lib/images/cuaca.png',
              width: 58 * s,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.wb_cloudy_outlined,
                  color: Colors.lightBlue,
                  size: 35 * s,
                );
              },
            ),
          ),

          Text(
            '30°C',
            style: interStyle(size: 11 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 3 * s),

          Text(
            time,
            style: interStyle(size: 10 * s, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // =====================================
  // PERKIRAAN HARI INI DAN BESOK
  // =====================================
  Widget _buildDailyForecast(double s) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13 * s),
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 13 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10 * s),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.17),
            blurRadius: 5 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildForecastRow(
            s,
            day: 'Hari Ini',
            weather: 'Cerah Berawan',
            temperature: '30°C / 20°C',
          ),

          SizedBox(height: 10 * s),

          _buildForecastRow(
            s,
            day: 'Besok',
            weather: 'Cerah Berawan',
            temperature: '30°C / 20°C',
          ),
        ],
      ),
    );
  }

  // =====================================
  // BARIS PERKIRAAN CUACA
  // =====================================
  Widget _buildForecastRow(
    double s, {
    required String day,
    required String weather,
    required String temperature,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 72 * s,
          child: Text(
            day,
            style: interStyle(size: 11 * s, weight: FontWeight.w500),
          ),
        ),

        Image.asset(
          'lib/images/cuaca.png',
          width: 27 * s,
          height: 27 * s,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.wb_cloudy_outlined,
              size: 22 * s,
              color: Colors.lightBlue,
            );
          },
        ),

        SizedBox(width: 7 * s),

        Expanded(
          child: Text(
            weather,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: interStyle(size: 11 * s),
          ),
        ),

        SizedBox(width: 5 * s),

        Text(
          temperature,
          style: interStyle(size: 11 * s, weight: FontWeight.bold),
        ),
      ],
    );
  }

  // =====================================
  // AKTIVITAS HARIAN
  // =====================================
  Widget _buildDailyActivities(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aktivitas Harian',
            style: interStyle(size: 14 * s, weight: FontWeight.bold),
          ),

          // JARAK JUDUL KE AKTIVITAS
          SizedBox(height: 12 * s),

          _buildActivityRow(
            s,
            icon: Icons.sentiment_very_satisfied_outlined,
            text: 'Berjalan-jalan adalah pilihan terbaik saat ini!',
            subtitle: 'Lihat Destinasi Wisata',
          ),

          // JARAK ANTAR AKTIVITAS DIPERKECIL
          SizedBox(height: 9 * s),

          _buildActivityRow(
            s,
            icon: Icons.umbrella_outlined,
            text: 'Jangan lupa bawa payung untuk berjaga-jaga',
          ),

          SizedBox(height: 9 * s),

          _buildActivityRow(
            s,
            icon: Icons.home_outlined,
            text: 'Aktivitas outdoor direkomendasikan',
          ),
        ],
      ),
    );
  }

  // =====================================
  // BARIS AKTIVITAS HARIAN
  // =====================================
  Widget _buildActivityRow(
    double s, {
    required IconData icon,
    required String text,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30 * s,
          child: Icon(icon, size: 27 * s, color: Colors.black87),
        ),

        SizedBox(width: 13 * s),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: interStyle(size: 10 * s, color: Colors.black87),
              ),

              if (subtitle != null) ...[
                SizedBox(height: 4 * s),

                Text(
                  subtitle,
                  style: interStyle(
                    size: 8 * s,
                    color: const Color(0xFF1599D0),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
