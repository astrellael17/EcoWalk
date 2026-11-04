import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ChangePhonePage extends StatefulWidget {
  const ChangePhonePage({super.key});

  @override
  State<ChangePhonePage> createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  // =====================================
  // VALIDASI DAN TOMBOL KIRIM
  // =====================================
  void kirimNomor() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali nomor Hp yang dimasukkan!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // MENUJU HALAMAN VERIFIKASI NOMOR HP
    Navigator.pushNamed(
      context,
      '/verification-hp',
      arguments: {
        'source': 'change-phone',
        'phone': phoneController.text.trim(),
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
                  // HEADER UBAH NOMOR HP
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
                          'Ubah Nomor Hp',
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
                              // LABEL NOMOR HP
                              // =====================================
                              Text(
                                'Masukan Nomor Baru',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12 * scale,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              // JARAK LABEL KE INPUT
                              SizedBox(height: 10 * scale),

                              // =====================================
                              // INPUT NOMOR HP
                              // =====================================
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,

                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(15),
                                ],

                                style: TextStyle(
                                  fontSize: 14 * scale,
                                  color: Colors.black87,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nomor Hp wajib diisi';
                                  }

                                  final String nomor = value.trim();

                                  if (nomor.length < 10) {
                                    return 'Nomor Hp minimal 10 digit';
                                  }

                                  if (!nomor.startsWith('08')) {
                                    return 'Nomor Hp harus diawali 08';
                                  }

                                  if (nomor.length > 15) {
                                    return 'Nomor Hp maksimal 15 digit';
                                  }

                                  return null;
                                },

                                decoration: InputDecoration(
                                  hintText: 'Nomor Hp',

                                  hintStyle: TextStyle(
                                    color: const Color(0xFF999999),
                                    fontSize: 14 * scale,
                                    fontStyle: FontStyle.italic,
                                  ),

                                  prefixIcon: Icon(
                                    Icons.phone,
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
                                  onPressed: kirimNomor,
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
