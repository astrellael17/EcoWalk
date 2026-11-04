import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void resetPassword() {
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      showMessage('Semua kolom harus diisi.');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Konfirmasi kata sandi tidak sama.');
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Widget buildField({
    required TextEditingController controller,
    required String hint,
    required bool hidden,
    required VoidCallback onToggle,
    required double s,
  }) {
    return TextField(
      controller: controller,
      obscureText: hidden,
      style: TextStyle(fontSize: 13 * s, color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.lock, size: 20 * s, color: Colors.black87),
        prefixIconConstraints: BoxConstraints(minWidth: 36 * s, minHeight: 0),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 30 * s, minHeight: 0),
          icon: Icon(
            hidden ? Icons.visibility_off : Icons.visibility,
            size: 19 * s,
            color: Colors.black54,
          ),
          onPressed: onToggle,
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 30 * s, minHeight: 0),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12 * s,
          color: Colors.black54,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ecoGreen, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    final double v = screen.height / 844;
    final double s = screen.width / 390;

    const double sidePad = 22;

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
                  306,
                  Text(
                    'Masukkan Kata Sandi Baru',
                    style: TextStyle(
                      fontSize: 12 * s,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                place(
                  348,
                  buildField(
                    controller: passwordController,
                    hint: 'Kata Sandi Baru',
                    hidden: hidePassword,
                    s: s,
                    onToggle: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),

                place(
                  421,
                  buildField(
                    controller: confirmPasswordController,
                    hint: 'Konfirmasi Kata Sandi',
                    hidden: hideConfirmPassword,
                    s: s,
                    onToggle: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                  ),
                ),

                place(
                  508,
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
                      onPressed: resetPassword,
                      child: Text(
                        'UBAH KATA SANDI',
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
// 7. PROFILE PAGE
// ======================================================
