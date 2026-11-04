import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final TextEditingController _reviewController = TextEditingController();

  int _rating = 0;
  bool _hideUsername = false;
  bool _showExamplePhoto = true;

  final Color darkText = const Color(0xFF171717);

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  // =====================================
  // FONT INTER
  // =====================================
  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    double height = 1.3,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  // =====================================
  // KETERANGAN RATING
  // =====================================
  String get ratingDescription {
    switch (_rating) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Cukup';
      case 4:
        return 'Bagus';
      case 5:
        return 'Sangat Bagus';
      default:
        return 'Bagus';
    }
  }

  // =====================================
  // TOMBOL TAMBAH GAMBAR
  // TANPA IMAGE PICKER
  // =====================================
  void _addImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur tambah gambar belum tersedia.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // =====================================
  // KIRIM ULASAN
  // TERHUBUNG KE REVIEWS PAGE
  // =====================================
  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih rating terlebih dahulu.')),
      );
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan tulis ulasan terlebih dahulu.')),
      );
      return;
    }

    // KIRIM DATA ULASAN KE HALAMAN NILAI & ULASAN
    Navigator.pushReplacementNamed(
      context,
      '/reviews',
      arguments: {
        'rating': _rating,
        'review': _reviewController.text.trim(),
        'hideUsername': _hideUsername,
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
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double s = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  // =====================================
                  // HEADER
                  // =====================================
                  Container(
                    width: double.infinity,
                    height: 52 * s,
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
                            size: 24 * s,
                          ),
                        ),

                        SizedBox(width: 4 * s),

                        Text(
                          'Beri Ulasan',
                          style: interStyle(
                            size: 15 * s,
                            weight: FontWeight.bold,
                            color: Colors.white,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDufanImage(s),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12 * s),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 29 * s),

                                // =====================================
                                // SAPAAN
                                // =====================================
                                Text(
                                  'Hai, Kaisyarani!',
                                  style: interStyle(
                                    size: 19 * s,
                                    weight: FontWeight.bold,
                                    color: darkText,
                                  ),
                                ),

                                SizedBox(height: 3 * s),

                                Text(
                                  'bagaimana perjalananmu?',
                                  style: interStyle(
                                    size: 14 * s,
                                    weight: FontWeight.w500,
                                    color: darkText,
                                  ),
                                ),

                                SizedBox(height: 15 * s),

                                // =====================================
                                // RATING BINTANG
                                // =====================================
                                _buildRating(s),

                                SizedBox(height: 29 * s),

                                // =====================================
                                // KOLOM ULASAN
                                // =====================================
                                _buildReviewInput(s),

                                SizedBox(height: 23 * s),

                                // =====================================
                                // TAMBAHKAN GAMBAR
                                // =====================================
                                Text(
                                  'Tambahkan Gambar?',
                                  style: interStyle(
                                    size: 11 * s,
                                    weight: FontWeight.w500,
                                    color: darkText,
                                  ),
                                ),

                                SizedBox(height: 10 * s),

                                _buildImageSection(s),

                                SizedBox(height: 20 * s),

                                // =====================================
                                // SEMBUNYIKAN NAMA
                                // =====================================
                                _buildHideUsername(s),

                                SizedBox(height: 19 * s),

                                // =====================================
                                // TOMBOL KIRIM
                                // =====================================
                                _buildSubmitButton(s),

                                SizedBox(height: 24 * s),
                              ],
                            ),
                          ),
                        ],
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

  // =====================================
  // GAMBAR DUFAN
  // =====================================
  Widget _buildDufanImage(double s) {
    return SizedBox(
      width: double.infinity,
      height: 142 * s,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34 * s),
              ),
              child: Image.asset(
                'lib/images/dufan.png',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE9E9E9),
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),

          // =====================================
          // LABEL WISATA
          // =====================================
          Positioned(
            right: 13 * s,
            bottom: -13 * s,
            child: Container(
              width: 113 * s,
              height: 38 * s,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ecoGreen,
                borderRadius: BorderRadius.circular(5 * s),
                border: Border.all(color: Colors.white, width: 3 * s),
              ),
              child: Text(
                'Dunia Fantasi\n(DUFAN)',
                textAlign: TextAlign.center,
                style: interStyle(
                  size: 10 * s,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // RATING BINTANG
  // =====================================
  Widget _buildRating(double s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(5, (index) {
          final int value = index + 1;
          final bool selected = value <= _rating;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _rating = value;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8 * s),
              child: Icon(
                selected ? Icons.star : Icons.star_border,
                size: 29 * s,
                color: selected ? const Color(0xFFFFC107) : Colors.black,
              ),
            ),
          );
        }),

        SizedBox(width: 2 * s),

        Flexible(
          child: Text(
            ratingDescription,
            style: interStyle(
              size: 10 * s,
              weight: FontWeight.w500,
              color: const Color(0xFF49A83D),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================
  // KOLOM INPUT ULASAN
  // =====================================
  Widget _buildReviewInput(double s) {
    return Container(
      width: double.infinity,
      height: 94 * s,
      padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 7 * s),
      decoration: const BoxDecoration(color: Color(0xFFF7F7F7)),
      child: TextField(
        controller: _reviewController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.multiline,
        style: interStyle(size: 11 * s, color: darkText, height: 1.5),
        decoration: InputDecoration(
          hintText: 'Kata saya...',
          hintStyle: interStyle(size: 10 * s, color: const Color(0xFFB1B1B1)),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  // =====================================
  // TAMBAHKAN GAMBAR
  // TANPA IMAGE PICKER
  // =====================================
  Widget _buildImageSection(double s) {
    return SizedBox(
      height: 64 * s,
      child: Row(
        children: [
          // =====================================
          // TOMBOL TAMBAH GAMBAR
          // =====================================
          InkWell(
            onTap: _addImage,
            child: Container(
              width: 64 * s,
              height: 64 * s,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black87, width: 1),
              ),
              child: Icon(Icons.add, color: Colors.black, size: 30 * s),
            ),
          ),

          SizedBox(width: 12 * s),

          // =====================================
          // FOTO CONTOH DUFAN
          // =====================================
          if (_showExamplePhoto)
            _buildThumbnail(
              s: s,
              onRemove: () {
                setState(() {
                  _showExamplePhoto = false;
                });
              },
            ),
        ],
      ),
    );
  }

  // =====================================
  // THUMBNAIL GAMBAR
  // =====================================
  Widget _buildThumbnail({required double s, required VoidCallback onRemove}) {
    return SizedBox(
      width: 64 * s,
      height: 64 * s,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2 * s),
              child: Image.asset('lib/images/dufan.png', fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 17 * s,
                height: 17 * s,
                color: Colors.black54,
                child: Icon(Icons.close, size: 12 * s, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // SEMBUNYIKAN NAMA PENGGUNA
  // =====================================
  Widget _buildHideUsername(double s) {
    return InkWell(
      onTap: () {
        setState(() {
          _hideUsername = !_hideUsername;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20 * s,
            height: 20 * s,
            child: Checkbox(
              value: _hideUsername,
              onChanged: (value) {
                setState(() {
                  _hideUsername = value ?? false;
                });
              },
              activeColor: ecoGreen,
              side: const BorderSide(color: Colors.black87, width: 1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),

          SizedBox(width: 9 * s),

          Text(
            'Sembunyikan Nama Pengguna',
            style: interStyle(size: 11 * s, color: darkText),
          ),
        ],
      ),
    );
  }

  // =====================================
  // TOMBOL KIRIM
  // =====================================
  Widget _buildSubmitButton(double s) {
    return SizedBox(
      width: double.infinity,
      height: 46 * s,
      child: ElevatedButton(
        onPressed: _submitReview,
        style: ElevatedButton.styleFrom(
          backgroundColor: ecoGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4 * s),
          ),
        ),
        child: Text(
          'Kirim',
          style: interStyle(
            size: 14 * s,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
