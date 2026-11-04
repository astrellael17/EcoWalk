import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String profileImage = 'lib/images/profile.webp';

  bool _dataAwalSudahDimuat = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dataAwalSudahDimuat) return;
    _dataAwalSudahDimuat = true;

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map) {
      final namaAwal = arguments['name'];
      final fotoAwal = arguments['imagePath'];

      if (namaAwal is String) {
        nameController.text = namaAwal;
      }

      if (fotoAwal is String && fotoAwal.isNotEmpty) {
        profileImage = fotoAwal;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // =====================================
  // FUNGSI PILIH SUMBER FOTO (KAMERA / GALERI)
  // =====================================
  Future<void> pilihSumberFoto() async {
    FocusScope.of(context).unfocus();

    // Menampilkan panel Kamera dan Galeri
    final PhotoSource? sumber = await showPhotoSourceSheet(context);

    if (!mounted || sumber == null) return;

    // KAMERA
    if (sumber == PhotoSource.camera) {
      final hasilFoto = await Navigator.pushNamed(context, '/camera-profile');

      if (!mounted) return;

      if (hasilFoto is String) {
        setState(() {
          profileImage = hasilFoto;
        });
      }

      // GALERI
    } else if (sumber == PhotoSource.gallery) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fitur Galeri belum diaktifkan'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // =====================================
  // FUNGSI SIMPAN PROFIL
  // =====================================
  void saveProfile() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pengguna wajib diisi!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final String newName = nameController.text.trim();

    // =====================================
    // KIRIM NAMA DAN FOTO TERBARU
    // KE HALAMAN PROFIL
    // =====================================
    Navigator.pop(context, {'name': newName, 'imagePath': profileImage});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenWidth = constraints.maxWidth;

              final double scale = (screenWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              final double avatarSize = 123 * scale;
              final double sidePadding = 20 * scale;

              return Column(
                children: [
                  // =====================================
                  // HEADER EDIT PROFIL
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
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Edit Profil',
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
                            children: [
                              // JARAK HEADER KE FOTO
                              SizedBox(height: 47 * scale),

                              // =====================================
                              // FOTO PROFIL DAN IKON PENSIL
                              // MEMBUKA PILIHAN KAMERA / GALERI
                              // =====================================
                              Center(
                                child: GestureDetector(
                                  onTap: pilihSumberFoto,
                                  child: SizedBox(
                                    width: avatarSize,
                                    height: avatarSize,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        // FOTO PROFIL
                                        ClipOval(
                                          child: SizedBox(
                                            width: avatarSize,
                                            height: avatarSize,
                                            child: Transform.scale(
                                              scale:
                                                  profileImage ==
                                                      'lib/images/foto.png'
                                                  ? 1.14
                                                  : 1.0,
                                              child: Image.asset(
                                                profileImage,
                                                width: avatarSize,
                                                height: avatarSize,
                                                fit: BoxFit.cover,
                                                alignment:
                                                    profileImage ==
                                                        'lib/images/foto.png'
                                                    ? const Alignment(0, -0.72)
                                                    : Alignment.center,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // IKON PENSIL
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 36 * scale,
                                            height: 36 * scale,
                                            decoration: const BoxDecoration(
                                              color: ecoGreen,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 27 * scale,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // JARAK FOTO KE INPUT
                              SizedBox(height: 33 * scale),

                              // =====================================
                              // INPUT NAMA PENGGUNA
                              // =====================================
                              TextFormField(
                                controller: nameController,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.done,

                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14 * scale,
                                  fontWeight: FontWeight.w500,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nama pengguna wajib diisi';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                  hintText: 'Nama Pengguna',

                                  hintStyle: TextStyle(
                                    color: const Color(0xFF858585),
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 20 * scale,
                                    color: const Color(0xFF858585),
                                  ),

                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 28 * scale,
                                    minHeight: 0,
                                  ),

                                  // JARAK TULISAN KE GARIS
                                  contentPadding: EdgeInsets.only(
                                    top: 8 * scale,
                                    bottom: 10 * scale,
                                  ),

                                  isDense: true,

                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1.1,
                                    ),
                                  ),

                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ecoGreen,
                                      width: 1.6,
                                    ),
                                  ),

                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.2,
                                    ),
                                  ),

                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.6,
                                        ),
                                      ),

                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 11 * scale,
                                  ),
                                ),
                              ),

                              // =====================================
                              // JARAK INPUT KE TOMBOL SIMPAN
                              // =====================================
                              SizedBox(height: 80 * scale),

                              // =====================================
                              // TOMBOL SIMPAN
                              // =====================================
                              SizedBox(
                                width: double.infinity,
                                height: 47 * scale,
                                child: ElevatedButton(
                                  onPressed: saveProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ecoGreen,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    'SIMPAN',
                                    style: TextStyle(
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

                  // RUANG PUTIH DI BAWAH GARIS
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
// PILIHAN SUMBER FOTO
// =========================================================
enum PhotoSource { camera, gallery }

// =========================================================
// FUNGSI MEMBUKA PANEL KAMERA / GALERI
// =========================================================
Future<PhotoSource?> showPhotoSourceSheet(BuildContext context) {
  final double scale = (MediaQuery.of(context).size.width / 390)
      .clamp(0.8, 1.2)
      .toDouble();

  return showModalBottomSheet<PhotoSource>(
    context: context,
    backgroundColor: Colors.white,
    barrierColor: Colors.black54,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
    ),
    builder: (sheetContext) => const PhotoSourceSheet(),
  );
}

// =========================================================
// TAMPILAN PANEL KAMERA / GALERI
// =========================================================
class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.of(context).size.width / 390)
        .clamp(0.8, 1.2)
        .toDouble();

    return SizedBox(
      width: double.infinity,
      height: 230 * scale,
      child: Column(
        children: [
          // JARAK ATAS KE GARIS PEGANGAN
          SizedBox(height: 11 * scale),

          // =====================================
          // GARIS PEGANGAN
          // =====================================
          Container(
            width: 110 * scale,
            height: 7 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFC8C8C8),
              borderRadius: BorderRadius.circular(20 * scale),
            ),
          ),

          // JARAK GARIS PEGANGAN KE PILIHAN
          SizedBox(height: 26 * scale),

          // =====================================
          // PILIHAN KAMERA DAN GALERI
          // =====================================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PhotoSourceOption(
                icon: Icons.camera_outlined,
                label: 'Kamera',
                scale: scale,
                highlighted: true,
                onTap: () {
                  Navigator.pop(context, PhotoSource.camera);
                },
              ),

              // JARAK ANTAR PILIHAN
              SizedBox(width: 62 * scale),

              _PhotoSourceOption(
                icon: Icons.image_rounded,
                label: 'Galeri',
                scale: scale,
                highlighted: false,
                onTap: () {
                  Navigator.pop(context, PhotoSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================
// SATU PILIHAN (IKON + LABEL)
// =========================================================
class _PhotoSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final double scale;
  final bool highlighted;
  final VoidCallback onTap;

  const _PhotoSourceOption({
    required this.icon,
    required this.label,
    required this.scale,
    required this.highlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: highlighted ? const Color(0xFFEDEDED) : Colors.transparent,
          borderRadius: BorderRadius.circular(22 * scale),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 64 * scale,
              height: 84 * scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 36 * scale, color: Colors.black87),

                  SizedBox(height: 5 * scale),

                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 11 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
