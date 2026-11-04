import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logout_dialog.dart';
import '../constants/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // =====================================
  // DATA PROFIL SEMENTARA
  // =====================================
  String profileName = 'Astrella Elga Ananta';
  String profileImage = 'lib/images/profile.webp';

  // =====================================
  // FUNGSI EDIT PROFIL
  // =====================================
  Future<void> editProfile() async {
    final hasil = await Navigator.pushNamed(
      context,
      '/edit_profile',
      arguments: {'name': profileName, 'imagePath': profileImage},
    );

    if (!mounted || hasil == null) return;

    if (hasil is Map) {
      final newName = hasil['name'];
      final newImage = hasil['imagePath'];

      setState(() {
        if (newName is String && newName.trim().isNotEmpty) {
          profileName = newName.trim();
        }

        if (newImage is String && newImage.isNotEmpty) {
          profileImage = newImage;
        }
      });
    }
  }

  // =====================================
  // MENU PROFIL
  // UKURAN TEKS DAN JARAK MENGIKUTI
  // REFERENSI KODE TEMAN
  // =====================================
  static Widget profileMenu({
    required IconData icon,
    required String title,
    required double s,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        // REVISI:
        // BARIS MENU LEBIH TINGGI
        height: 69 * s,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * s),
          child: Row(
            children: [
              // =====================================
              // IKON MENU
              // REVISI: 24 MENJADI 28
              // =====================================
              Icon(icon, size: 28 * s, color: Colors.black),

              // =====================================
              // JARAK IKON KE TULISAN
              // REVISI: 16 MENJADI 22
              // =====================================
              SizedBox(width: 22 * s),

              // =====================================
              // TULISAN MENU
              // REVISI: 14 MENJADI 18
              // =====================================
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18 * s,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              // =====================================
              // PANAH KANAN
              // REVISI: 24 MENJADI 30
              // =====================================
              Icon(Icons.chevron_right, size: 30 * s, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================
  // GARIS PEMISAH MENU
  // =====================================
  Widget menuDivider(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8 * s),
      child: const Divider(height: 1, thickness: 1.3, color: Color(0xFFCFCFCF)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    // =====================================
    // SKALA RESPONSIF
    // =====================================
    final double v = screen.height / 844;
    final double s = (screen.width / 390).clamp(0.8, 1.2).toDouble();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: screen.width,
          height: screen.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // =====================================
              // BACKGROUND ATAS
              // TIDAK DIUBAH
              // =====================================
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 70 * v,
                child: Container(color: const Color(0xFF3B8476)),
              ),

              Positioned(
                top: 70 * v,
                left: 0,
                right: 0,
                height: 87 * v,
                child: Container(color: ecoGreen),
              ),

              // =====================================
              // FOTO PROFIL
              // TETAP MENDUKUNG HASIL EDIT FOTO
              // =====================================
              Positioned(
                top: 101 * v,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    // UKURAN FOTO MENGIKUTI TEMAN
                    width: 124 * s,
                    height: 124 * s,

                    padding: EdgeInsets.all(4 * s),

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: ClipOval(
                      child: Transform.scale(
                        scale: profileImage == 'lib/images/foto.png'
                            ? 1.14
                            : 1.0,

                        child: Image.asset(
                          profileImage,
                          width: 124 * s,
                          height: 124 * s,
                          fit: BoxFit.cover,

                          alignment: profileImage == 'lib/images/foto.png'
                              ? const Alignment(0, -0.72)
                              : Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // =====================================
              // NAMA PENGGUNA
              // REVISI: FONT 20 MENJADI 24
              // =====================================
              Positioned(
                top: 232 * v,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12 * s),
                  child: Text(
                    profileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24 * s,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // =====================================
              // EMAIL PENGGUNA
              // REVISI: FONT 11 MENJADI 12
              // =====================================
              Positioned(
                top: 268 * v,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 190 * s,

                    padding: EdgeInsets.symmetric(
                      horizontal: 14 * s,
                      vertical: 4 * v,
                    ),

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: ecoGreen,
                      borderRadius: BorderRadius.circular(4 * s),
                    ),

                    child: Text(
                      'astrella.el17@gmail.com',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // =====================================
              // DAFTAR MENU PROFIL
              //
              // UKURAN DAN JARAK SESUAI REFERENSI
              // TETAP FIT LAYAR DENGAN SCROLL
              // JIKA LAYAR TERLALU PENDEK
              // =====================================
              Positioned(
                top: 320 * v,
                bottom: 59 * v,
                left: 0,
                right: 0,

                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),

                  children: [
                    // =====================================
                    // PENGATURAN
                    // =====================================
                    profileMenu(
                      icon: Icons.settings_outlined,
                      title: 'Pengaturan',
                      s: s,
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),

                    menuDivider(s),

                    // =====================================
                    // EDIT PROFIL
                    // =====================================
                    profileMenu(
                      icon: Icons.edit_outlined,
                      title: 'Edit Profil',
                      s: s,
                      onTap: editProfile,
                    ),

                    menuDivider(s),

                    // =====================================
                    // KEBIJAKAN PRIVASI
                    // =====================================
                    profileMenu(
                      icon: Icons.lock_outline,
                      title: 'Kebijakan Privasi',
                      s: s,
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy-policy');
                      },
                    ),

                    menuDivider(s),

                    // =====================================
                    // TENTANG KAMI
                    // =====================================
                    profileMenu(
                      icon: Icons.info_outline,
                      title: 'Tentang Kami',
                      s: s,
                      onTap: () {
                        Navigator.pushNamed(context, '/about-us');
                      },
                    ),

                    menuDivider(s),

                    // =====================================
                    // KETENTUAN LAYANAN
                    // =====================================
                    profileMenu(
                      icon: Icons.description_outlined,
                      title: 'Ketentuan Layanan',
                      s: s,
                      onTap: () {
                        Navigator.pushNamed(context, '/terms-service');
                      },
                    ),

                    menuDivider(s),

                    // =====================================
                    // KELUAR
                    // =====================================
                    profileMenu(
                      icon: Icons.logout,
                      title: 'Keluar',
                      s: s,
                      onTap: () {
                        LogoutDialog.show(context);
                      },
                    ),
                  ],
                ),
              ),

              // =====================================
              // BACKGROUND NAVBAR
              // TIDAK DIUBAH
              // =====================================
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 59 * v,
                child: Container(color: ecoGreen),
              ),

              // =====================================
              // IKON NAVBAR BAWAH
              // TIDAK DIUBAH
              // =====================================
              Positioned(
                bottom: 0,
                left: 0,
                right: 85 * s,
                height: 59 * v,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // =====================================
                    // BERANDA
                    // =====================================
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: SizedBox(
                        width: 46 * s,
                        height: 59 * v,
                        child: Center(
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 30 * s,
                          ),
                        ),
                      ),
                    ),

                    // =====================================
                    // REKOMENDASI
                    // =====================================
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/recommendation',
                        );
                      },
                      child: SizedBox(
                        width: 46 * s,
                        height: 59 * v,
                        child: Center(
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.white,
                            size: 27 * s,
                          ),
                        ),
                      ),
                    ),

                    // =====================================
                    // CHAT
                    // TAMPILAN ASLI DIPERTAHANKAN
                    // =====================================
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble,
                          color: Colors.white,
                          size: 31 * s,
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 3 * s),
                          child: Icon(
                            Icons.favorite,
                            color: ecoGreen,
                            size: 13 * s,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // =====================================
              // IKON PROFIL AKTIF
              // TIDAK DIUBAH
              // =====================================
              Positioned(
                bottom: 31 * v,
                right: 18 * s,
                child: Container(
                  width: 62 * s,
                  height: 62 * s,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: ecoGreen, width: 6),
                  ),

                  child: Icon(Icons.person, color: ecoGreen, size: 30 * s),
                ),
              ),

              // =====================================
              // LABEL AKUN
              // TIDAK DIUBAH
              // =====================================
              Positioned(
                bottom: 15 * v,
                right: 18 * s,
                width: 62 * s,
                child: Text(
                  'AKUN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8 * s,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
