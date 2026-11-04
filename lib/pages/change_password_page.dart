import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, this.onChangePassword});

  final Future<void> Function(String oldPassword, String newPassword)?
  onChangePassword;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  // Mencegah tombol ditekan berulang
  bool isSaving = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // =====================================
  // VALIDASI DAN TOMBOL UBAH
  // =====================================
  Future<void> ubahPassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali data kata sandi yang dimasukkan!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (isSaving) return;

    if (widget.onChangePassword == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Perubahan kata sandi belum dapat disimpan. '
            'Layanan autentikasi belum terhubung.',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await widget.onChangePassword!(
        oldPasswordController.text,
        newPasswordController.text,
      );

      if (!mounted) return;

      // Kosongkan input setelah berhasil.
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      final bool? kembali = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Kata sandi berhasil diubah.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext, true);
                },
                child: const Text('Kembali ke Pengaturan'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      if (kembali == true) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal mengubah kata sandi. '
            'Periksa kata sandi lama atau coba kembali.',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // =====================================
  // INPUT KATA SANDI
  // =====================================
  Widget passwordInput({
    required TextEditingController controller,
    required String hint,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required double scale,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '•',
      textInputAction: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: false,
      validator: validator,
      style: TextStyle(fontSize: 14 * scale, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: const Color(0xFF999999),
          fontSize: 14 * scale,
          fontStyle: FontStyle.italic,
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: const Color(0xFF858585),
          size: 19 * scale,
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          splashRadius: 20 * scale,
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF858585),
            size: 19 * scale,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14 * scale,
          horizontal: 14 * scale,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: Color(0xFFD2D2D2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: ecoGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        errorStyle: TextStyle(color: Colors.red, fontSize: 11 * scale),
      ),
    );
  }

  // =====================================
  // LABEL INPUT
  // =====================================
  Widget passwordLabel(String text, double scale) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 12 * scale,
        fontWeight: FontWeight.w700,
      ),
    );
  }

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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double scale = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final double sidePadding = 20 * scale;

              return Column(
                children: [
                  // =====================================
                  // HEADER
                  // =====================================
                  Container(
                    width: double.infinity,
                    height: 50 * scale,
                    color: ecoGreen,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24 * scale,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Ubah Kata Sandi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =====================================
                  // FORM KATA SANDI
                  // =====================================
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: sidePadding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // =====================================
                            // KATA SANDI LAMA
                            // =====================================
                            SizedBox(height: 40 * scale),

                            passwordLabel('Kata Sandi Lama', scale),

                            SizedBox(height: 8 * scale),

                            passwordInput(
                              controller: oldPasswordController,
                              hint: 'Kata Sandi Lama',
                              obscureText: hideOldPassword,
                              scale: scale,
                              onToggleVisibility: () {
                                setState(() {
                                  hideOldPassword = !hideOldPassword;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kata sandi lama wajib diisi';
                                }
                                return null;
                              },
                            ),

                            // =====================================
                            // LUPA KATA SANDI
                            // =====================================
                            SizedBox(height: 12 * scale),

                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/forgot-password-hp',
                                  );
                                },
                                child: Text(
                                  'Lupa Kata Sandi?',
                                  style: TextStyle(
                                    color: linkBlue,
                                    fontSize: 11 * scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // =====================================
                            // KATA SANDI BARU
                            // =====================================
                            SizedBox(height: 22 * scale),

                            passwordLabel('Kata Sandi Baru', scale),

                            SizedBox(height: 8 * scale),

                            passwordInput(
                              controller: newPasswordController,
                              hint: 'Kata Sandi Baru',
                              obscureText: hideNewPassword,
                              scale: scale,
                              onToggleVisibility: () {
                                setState(() {
                                  hideNewPassword = !hideNewPassword;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kata sandi baru wajib diisi';
                                }

                                if (value.length < 8) {
                                  return 'Kata sandi minimal 8 karakter';
                                }

                                if (value == oldPasswordController.text) {
                                  return 'Kata sandi baru harus berbeda';
                                }

                                return null;
                              },
                            ),

                            // =====================================
                            // KONFIRMASI KATA SANDI
                            // =====================================
                            SizedBox(height: 12 * scale),

                            passwordLabel('Konfirmasi Kata Sandi', scale),

                            SizedBox(height: 8 * scale),

                            passwordInput(
                              controller: confirmPasswordController,
                              hint: 'Konfirmasi Kata Sandi',
                              obscureText: hideConfirmPassword,
                              scale: scale,
                              onToggleVisibility: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi kata sandi wajib diisi';
                                }

                                if (value != newPasswordController.text) {
                                  return 'Konfirmasi kata sandi tidak cocok';
                                }

                                return null;
                              },
                            ),

                            // =====================================
                            // JARAK KE TOMBOL UBAH
                            // =====================================
                            SizedBox(height: 42 * scale),

                            // =====================================
                            // TOMBOL UBAH
                            // =====================================
                            SizedBox(
                              width: double.infinity,
                              height: 47 * scale,
                              child: ElevatedButton(
                                onPressed: isSaving ? null : ubahPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ecoGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5 * scale,
                                    ),
                                  ),
                                ),
                                child: isSaving
                                    ? SizedBox(
                                        width: 20 * scale,
                                        height: 20 * scale,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'UBAH',
                                        style: TextStyle(
                                          fontSize: 13 * scale,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),

                            SizedBox(height: 30 * scale),
                          ],
                        ),
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
}
