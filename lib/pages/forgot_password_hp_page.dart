import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ForgotPasswordHpPage extends StatefulWidget {
  const ForgotPasswordHpPage({super.key});

  @override
  State<ForgotPasswordHpPage> createState() => _ForgotPasswordHpPageState();
}

class _ForgotPasswordHpPageState extends State<ForgotPasswordHpPage> {
  bool usingEmail = false;

  final TextEditingController inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void send() {
    final String value = inputController.text.trim();

    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            usingEmail ? 'Alamat email harus diisi.' : 'Nomor Hp harus diisi.',
          ),
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/reset-password');
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    final double v = screen.height / 844;
    final double s = screen.width / 390;

    const double sidePad = 20;

    Widget place(double top, Widget child) {
      return Positioned(
        top: top * v,
        left: sidePad * s,
        right: sidePad * s,
        child: child,
      );
    }

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
                  height: 258 * v,
                  child: Image.asset(
                    'lib/images/polygon.png',
                    fit: BoxFit.fill,
                  ),
                ),

                place(
                  153,
                  Center(
                    heightFactor: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'lib/images/logo_ecowalk_white.png',
                          width: 227 * s,
                          fit: BoxFit.contain,
                          color: ecoGreen,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        SizedBox(height: 6 * v),
                        Text(
                          'LUPA KATA SANDI',
                          style: TextStyle(
                            color: ecoGreen,
                            fontSize: 18 * s,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                place(
                  281,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/images/notif.png',
                        width: 19 * s,
                        height: 19 * s,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 8 * s),
                      Expanded(
                        child: Text(
                          usingEmail
                              ? 'Periksa dan masukkan alamat Email untuk mendapatkan kode verifikasi'
                              : 'Periksa dan masukkan Nomor Hp untuk mendapatkan kode verifikasi',
                          style: TextStyle(
                            fontSize: 12 * s,
                            height: 1.3,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                place(
                  366,
                  Text(
                    usingEmail ? 'Alamat Email' : 'Nomor Hp',
                    style: TextStyle(fontSize: 12 * s, color: Colors.black54),
                  ),
                ),

                place(
                  396,
                  TextField(
                    controller: inputController,
                    keyboardType: usingEmail
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    style: TextStyle(fontSize: 14 * s, color: Colors.black),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ecoGreen, width: 1),
                      ),
                    ),
                  ),
                ),

                place(
                  470,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/forgot-password-email',
                        );
                      },
                      child: Text(
                        usingEmail ? 'Gunakan Nomor Hp' : 'Gunakan Email',
                        style: TextStyle(color: linkBlue, fontSize: 12 * s),
                      ),
                    ),
                  ),
                ),

                place(
                  519,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 6. RESET PASSWORD
// ======================================================
