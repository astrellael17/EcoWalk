import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'delete_account_dialog.dart';
import '../constants/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              // =====================================
              // UKURAN RESPONSIF
              // =====================================
              final double screenWidth = constraints.maxWidth;

              final double scale = (screenWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final double horizontalPadding = 20 * scale;

              return Column(
                children: [
                  // =====================================
                  // HEADER PENGATURAN
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
                          'Pengaturan',
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
                  // KONTEN MENU PENGATURAN
                  // =====================================
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: Column(
                          children: [
                            // JARAK HEADER KE MENU PERTAMA
                            SizedBox(height: 16 * scale),

                            // =====================================
                            // UBAH NOMOR HP
                            // =====================================
                            _SettingsMenuItem(
                              icon: Icons.phone_outlined,
                              title: 'Ubah Nomor Hp',
                              scale: scale,
                              onTap: () {
                                Navigator.pushNamed(context, '/change-phone');
                              },
                            ),

                            _SettingsDivider(scale: scale),

                            // =====================================
                            // UBAH EMAIL
                            // =====================================
                            _SettingsMenuItem(
                              icon: Icons.mail_outline,
                              title: 'Ubah Email',
                              scale: scale,
                              onTap: () {
                                Navigator.pushNamed(context, '/change-email');
                              },
                            ),

                            _SettingsDivider(scale: scale),

                            // =====================================
                            // UBAH KATA SANDI
                            // =====================================
                            _SettingsMenuItem(
                              icon: Icons.vpn_key_outlined,
                              title: 'Ubah Kata Sandi',
                              scale: scale,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/change-password',
                                );
                              },
                            ),

                            _SettingsDivider(scale: scale),

                            // =====================================
                            // HAPUS AKUN
                            // =====================================
                            _SettingsMenuItem(
                              icon: Icons.delete_outline_rounded,
                              title: 'Hapus Akun',
                              scale: scale,
                              onTap: () {
                                DeleteAccountDialog.show(context);
                              },
                            ),
                          ],
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
                  // AREA PUTIH DI BAWAH GARIS
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

// =========================================================
// WIDGET MENU PENGATURAN
// =========================================================
class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double scale;
  final VoidCallback onTap;

  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 69 * scale,
          child: Row(
            children: [
              // =====================================
              // IKON KIRI
              // =====================================
              SizedBox(
                width: 40 * scale,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(icon, color: Colors.black87, size: 23 * scale),
                ),
              ),

              // =====================================
              // TEKS MENU
              // =====================================
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // =====================================
              // PANAH KANAN
              // =====================================
              Icon(
                Icons.chevron_right,
                color: Colors.black87,
                size: 27 * scale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// GARIS PEMISAH ANTAR MENU
// =========================================================
class _SettingsDivider extends StatelessWidget {
  final double scale;

  const _SettingsDivider({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.5 * scale,
      color: const Color(0xFFD2D2D2),
    );
  }
}
