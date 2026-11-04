import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // =====================================
  // VALIDASI DAN TOMBOL KIRIM
  // =====================================
  void kirimEmail() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali email yang dimasukkan!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // MENUJU HALAMAN VERIFIKASI EMAIL
    Navigator.pushNamed(
      context,
      '/verification-email',
      arguments: {
        'source': 'change-email',
        'email': emailController.text.trim(),
      },
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
              // =====================================
              // UKURAN RESPONSIF
              // =====================================
              final double screenWidth = constraints.maxWidth;

              final double scale = (screenWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final double sidePadding = 20 * scale;

              return Column(
                children: [
                  // =====================================
                  // HEADER UBAH EMAIL
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
                          'Ubah Email',
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
                  // KONTEN HALAMAN
                  // =====================================
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // JARAK HEADER KE LABEL
                              SizedBox(height: 40 * scale),

                              // =====================================
                              // LABEL EMAIL
                              // =====================================
                              Text(
                                'Masukan Email Baru',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12 * scale,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              // JARAK LABEL KE INPUT
                              SizedBox(height: 10 * scale),

                              // =====================================
                              // INPUT EMAIL
                              // =====================================
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                autocorrect: false,
                                enableSuggestions: false,
                                textCapitalization: TextCapitalization.none,

                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],

                                style: TextStyle(
                                  fontSize: 14 * scale,
                                  color: Colors.black87,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Email wajib diisi';
                                  }

                                  final String email = value.trim();

                                  final RegExp emailRegex = RegExp(
                                    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
                                  );

                                  if (!emailRegex.hasMatch(email)) {
                                    return 'Format email tidak valid';
                                  }

                                  return null;
                                },

                                decoration: InputDecoration(
                                  hintText: 'Email',

                                  hintStyle: TextStyle(
                                    color: const Color(0xFF999999),
                                    fontSize: 14 * scale,
                                    fontStyle: FontStyle.italic,
                                  ),

                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: const Color(0xFF858585),
                                    size: 20 * scale,
                                  ),

                                  filled: true,
                                  fillColor: const Color(0xFFF7F7F7),

                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14 * scale,
                                    horizontal: 14 * scale,
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10 * scale,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD2D2D2),
                                      width: 1,
                                    ),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10 * scale,
                                    ),
                                    borderSide: const BorderSide(
                                      color: ecoGreen,
                                      width: 1.5,
                                    ),
                                  ),

                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10 * scale,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),

                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10 * scale,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),

                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 11 * scale,
                                  ),
                                ),
                              ),

                              // =====================================
                              // JARAK INPUT KE TOMBOL KIRIM
                              // =====================================
                              SizedBox(height: 70 * scale),

                              // =====================================
                              // TOMBOL KIRIM
                              // =====================================
                              SizedBox(
                                width: double.infinity,
                                height: 47 * scale,
                                child: ElevatedButton(
                                  onPressed: kirimEmail,
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
                                  child: Text(
                                    'KIRIM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13 * scale,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // =====================================
                  // GARIS ABU-ABU BAGIAN BAWAH
                  // =====================================
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xFFECECEC),
                  ),

                  // =====================================
                  // RUANG PUTIH BAWAH
                  // =====================================
                  SizedBox(height: 48 * scale),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
