import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // PENTING: false agar jarak atas dihitung dari tepi atas layar
      useSafeArea: false,
      barrierColor: const Color(0x66000000),
      builder: (context) => const LogoutDialog(),
    );
  }

  static const Color darkText = Color(0xFF2B2B2B);

  // =====================================
  // POSISI DAN UKURAN KOTAK DIALOG
  // =====================================

  // REVISI: kotak sedikit lebih lebar
  // Sebelumnya: 55
  static const double _marginH = 45;

  // REVISI: kotak diturunkan
  // Sebelumnya: 324
  static const double _topOffset = 340;

  static const double _radius = 14;

  // JARAK DAN PADDING DIALOG
  // REVISI: padding atas dan bawah sedikit diperbesar
  static const double _padH = 45;
  static const double _padTop = 31;
  static const double _padBottom = 36;

  // TEKS
  static const double _titleSize = 16;
  static const double _titleToSub = 7;
  static const double _subSize = 12;
  static const double _subToBtn = 16;

  // TOMBOL
  static const double _btnH = 29;
  static const double _btnGap = 16;
  static const double _btnFont = 15;
  static const double _btnRadius = 4;
  static const double _outlineWidth = 1.5;

  // =====================================
  // AKSI TOMBOL
  // =====================================
  void _batal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _keluar(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Skala responsif sesuai lebar layar
    final double scale = (MediaQuery.of(context).size.width / 390)
        .clamp(0.8, 1.2)
        .toDouble();

    // Ukuran font tidak mengikuti pengaturan huruf sistem
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Dialog(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: const Color(0x33000000),
        insetPadding: EdgeInsets.fromLTRB(
          _marginH * scale,
          _topOffset * scale,
          _marginH * scale,
          16 * scale,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius * scale),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _padH * scale,
            _padTop * scale,
            _padH * scale,
            _padBottom * scale,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================
              // JUDUL (TEBAL, RATA KIRI)
              // =====================================
              Text(
                'Keluar?',
                style: TextStyle(
                  fontSize: _titleSize * scale,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              SizedBox(height: _titleToSub * scale),

              // =====================================
              // SUBJUDUL
              // =====================================
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Apakah Kamu Yakin Ingin Keluar?',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: _subSize * scale,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: darkText,
                    ),
                  ),
                ),
              ),

              SizedBox(height: _subToBtn * scale),

              // =====================================
              // TOMBOL BATAL DAN KELUAR
              // =====================================
              Row(
                children: [
                  // TOMBOL BATAL
                  Expanded(
                    child: SizedBox(
                      height: _btnH * scale,
                      child: ElevatedButton(
                        onPressed: () => _batal(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ecoGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              _btnRadius * scale,
                            ),
                          ),
                        ),
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            fontSize: _btnFont * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: _btnGap * scale),

                  // TOMBOL KELUAR
                  Expanded(
                    child: SizedBox(
                      height: _btnH * scale,
                      child: OutlinedButton(
                        onPressed: () => _keluar(context),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: darkText,
                          padding: EdgeInsets.zero,
                          side: BorderSide(
                            color: ecoGreen,
                            width: _outlineWidth * scale,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              _btnRadius * scale,
                            ),
                          ),
                        ),
                        child: Text(
                          'Keluar',
                          style: TextStyle(
                            fontSize: _btnFont * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
