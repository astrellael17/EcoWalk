import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class VerificationHpPage extends StatefulWidget {
  const VerificationHpPage({super.key});

  @override
  State<VerificationHpPage> createState() => _VerificationHpPageState();
}

class _VerificationHpPageState extends State<VerificationHpPage> {
  bool usingEmail = false;

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // =====================================
  // MEMBACA DATA DARI HALAMAN SEBELUMNYA
  // =====================================
  Map<String, dynamic> get routeData {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map) {
      return Map<String, dynamic>.from(arguments);
    }

    return <String, dynamic>{};
  }

  String get verificationSource {
    final source = routeData['source'];
    return source is String ? source : '';
  }

  String get phoneNumber {
    final phone = routeData['phone'];
    return phone is String ? phone : '';
  }

  // =====================================
  // VALIDASI KODE OTP DAN NAVIGASI
  // =====================================
  void send() {
    final bool incomplete = otpControllers.any(
      (controller) => controller.text.trim().isEmpty,
    );

    if (incomplete) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode verifikasi harus diisi lengkap.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    // =====================================
    // ALUR UBAH NOMOR HP
    // =====================================
    if (verificationSource == 'change-phone') {
      // Simulasi validasi OTP.
      // Kembali ke Pengaturan setelah 4 digit terisi.
      Navigator.popUntil(
        context,
        (route) => route.settings.name == '/settings' || route.isFirst,
      );
      return;
    }

    // =====================================
    // ALUR LUPA KATA SANDI
    // =====================================
    if (verificationSource == 'forgot-password') {
      Navigator.pushReplacementNamed(context, '/reset-password');
      return;
    }

    // =====================================
    // ALUR VERIFIKASI SEBELUMNYA
    // =====================================
    Navigator.pushReplacementNamed(context, '/profile');
  }

  // =====================================
  // WIDGET KOTAK OTP
  // =====================================
  Widget otpBox({
    required TextEditingController controller,
    required double size,
    required double s,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: TextField(
        controller: controller,
        expands: true,
        minLines: null,
        maxLines: null,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          fontSize: 24 * s,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFFAFAFA),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ecoGreen, width: 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    final double v = screen.height / 844;
    final double s = screen.width / 390;

    const double sidePad = 20;
    final double boxSize = 76 * s;

    Widget place(double top, Widget child, {double pad = sidePad}) {
      return Positioned(
        top: top * v,
        left: pad * s,
        right: pad * s,
        child: child,
      );
    }

    // =====================================
    // NOMOR TUJUAN VERIFIKASI
    // =====================================
    final String target = usingEmail
        ? 'ke contohsample@gmail.com'
        : phoneNumber.isNotEmpty
        ? 'ke $phoneNumber'
        : 'ke +62876543210912';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: screen.width,
            height: screen.height,
            child: Stack(
              children: [
                // =====================================
                // BACKGROUND POLYGON
                // =====================================
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 340 * v,
                  child: Image.asset(
                    'lib/images/polygon.png',
                    fit: BoxFit.fill,
                  ),
                ),

                // =====================================
                // LOGO ECOWALK
                // =====================================
                place(
                  153,
                  Center(
                    heightFactor: 1,
                    child: Image.asset(
                      'lib/images/logo_ecowalk_white.png',
                      width: 227 * s,
                      fit: BoxFit.contain,
                      color: ecoGreen,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),

                // =====================================
                // JUDUL VERIFIKASI
                // =====================================
                place(
                  261,
                  Row(
                    children: [
                      Icon(Icons.check, size: 18 * s, color: Colors.black),
                      SizedBox(width: 8 * s),
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                          fontSize: 12 * s,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // =====================================
                // KETERANGAN KODE VERIFIKASI
                // =====================================
                place(
                  298,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/images/hp.png',
                        width: 23 * s,
                        height: 23 * s,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 8 * s),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Periksa dan ketik kode verifikasi yang telah dikirimkan ',
                                style: TextStyle(
                                  fontSize: 11 * s,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                              ),
                              TextSpan(
                                text: target,
                                style: TextStyle(
                                  fontSize: 11 * s,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // =====================================
                // 4 KOTAK OTP
                // =====================================
                place(
                  369,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 4; i++)
                        otpBox(
                          controller: otpControllers[i],
                          size: boxSize,
                          s: s,
                        ),
                    ],
                  ),
                  pad: 17,
                ),

                // =====================================
                // VERIFIKASI MENGGUNAKAN EMAIL
                // =====================================
                place(
                  480,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/verification-email',
                        );
                      },
                      child: Text(
                        usingEmail
                            ? 'Verifikasi menggunakan No. Hp'
                            : 'Verifikasi menggunakan Email',
                        style: TextStyle(
                          color: linkBlue,
                          fontSize: 11 * s,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // =====================================
                // TOMBOL KIRIM
                // =====================================
                place(
                  521,
                  SizedBox(
                    width: double.infinity,
                    height: 44 * v,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ecoGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: send,
                      child: Text(
                        'KIRIM',
                        style: TextStyle(
                          fontSize: 12 * s,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // =====================================
                // KIRIM ULANG KODE
                // =====================================
                place(
                  588,
                  Center(
                    heightFactor: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Kirim Ulang Kode',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11 * s,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
