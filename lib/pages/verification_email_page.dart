import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class VerificationEmailPage extends StatefulWidget {
  const VerificationEmailPage({super.key});

  @override
  State<VerificationEmailPage> createState() => _VerificationEmailPageState();
}

class _VerificationEmailPageState extends State<VerificationEmailPage> {
  bool usingEmail = true;

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

  void send() {
    final bool incomplete = otpControllers.any(
      (controller) => controller.text.trim().isEmpty,
    );

    if (incomplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode verifikasi harus diisi lengkap.')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/profile');
  }

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

    final String target = usingEmail
        ? 'ke contohsample@gmail.com'
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

                // ======================
                // 4 KOTAK OTP
                // ======================
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

                place(
                  480,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/verification-hp',
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

// ======================================================
// 5. LUPA KATA SANDI
// ======================================================
