import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  String _selectedFilter = 'Semua';
  int _minimumRating = 0;

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Kaisyarani Zahra',
      'rating': 5,
      'text':
          'Pokoknya seru banget, makin pokoknya seru banget, makin pokoknya '
          'seru banget. Pokoknya tempat wisata ini bagus banget dan '
          'cocok untuk dikunjungi bersama keluarga.',
      'date': '4 Maret 2025',
      'hasPhotos': false,
      'highlight': true,
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': 5,
      'text':
          'Pokoknya seru banget, makin pokoknya seru banget, makin pokoknya '
          'seru banget. Tempatnya menyenangkan, banyak permainan yang '
          'bisa dicoba bersama teman dan keluarga.',
      'date': '19 Februari 2025',
      'hasPhotos': true,
      'highlight': false,
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': 5,
      'text':
          'Pokoknya seru banget, makin pokoknya seru banget. '
          'Banyak wahana menarik dan suasananya menyenangkan. '
          'Ingin berkunjung kembali.',
      'date': '16 Februari 2025',
      'hasPhotos': false,
      'highlight': false,
    },
    {
      'name': 'Kaisyarani Zahra',
      'rating': 5,
      'text':
          'Pengalaman berlibur yang menyenangkan. '
          'Wahana dan tempat wisatanya sangat menarik.',
      'date': '12 Februari 2025',
      'hasPhotos': false,
      'highlight': false,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Menerima ulasan dari halaman Write Review.
    // Data diterima satu kali untuk setiap halaman dibuka.
    if (!_argumentsLoaded) {
      _argumentsLoaded = true;

      final Object? arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is Map) {
        final dynamic ratingValue = arguments['rating'];

        final int rating = ratingValue is int
            ? ratingValue.clamp(1, 5).toInt()
            : 5;

        final String reviewText = (arguments['review'] ?? '').toString();

        final bool hideUsername = arguments['hideUsername'] == true;

        if (reviewText.trim().isNotEmpty) {
          _reviews.insert(0, {
            'name': hideUsername ? 'Pengguna Anonim' : 'Kaisyarani Zahra',
            'rating': rating,
            'text': reviewText.trim(),
            'date': _todayDate(),
            'hasPhotos': false,
            'highlight': true,
            'isNew': true,
          });

          // Hapus penanda biru kartu contoh
          // ketika ada ulasan baru.
          if (_reviews.length > 1) {
            _reviews[1]['highlight'] = false;
          }
        }
      }
    }
  }

  bool _argumentsLoaded = false;

  String _todayDate() {
    final DateTime now = DateTime.now();

    const List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  TextStyle _textStyle({
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

  List<Map<String, dynamic>> get _filteredReviews {
    return _reviews.where((review) {
      if (_selectedFilter == 'Dengan Foto' && review['hasPhotos'] != true) {
        return false;
      }

      if (_minimumRating > 0 && (review['rating'] as int) != _minimumRating) {
        return false;
      }

      return true;
    }).toList();
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
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double s = (constraints.maxWidth / 390)
                  .clamp(0.8, 1.2)
                  .toDouble();

              return Column(
                children: [
                  _buildHeader(s),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18 * s),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20 * s),

                            _buildRatingSummary(s),

                            SizedBox(height: 22 * s),

                            _buildFilterButtons(s),

                            SizedBox(height: 28 * s),

                            if (_filteredReviews.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 30 * s),
                                child: const Center(
                                  child: Text(
                                    'Belum ada ulasan untuk filter ini.',
                                  ),
                                ),
                              )
                            else
                              ..._filteredReviews.map(
                                (review) => Padding(
                                  padding: EdgeInsets.only(bottom: 16 * s),
                                  child: _buildReviewCard(s, review),
                                ),
                              ),

                            SizedBox(height: 16 * s),
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

  // =====================================
  // HEADER NILAI & ULASAN
  // =====================================
  Widget _buildHeader(double s) {
    return Container(
      width: double.infinity,
      height: 55 * s,
      color: ecoGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25 * s),
          ),

          SizedBox(width: 5 * s),

          Text(
            'Nilai & Ulasan',
            style: _textStyle(
              size: 16 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // RINGKASAN RATING
  // =====================================
  Widget _buildRatingSummary(double s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '4.75',
                  style: _textStyle(size: 18 * s, weight: FontWeight.bold),
                ),

                SizedBox(width: 9 * s),

                ...List.generate(
                  5,
                  (index) => Icon(
                    index == 4 ? Icons.star_half : Icons.star,
                    size: 21 * s,
                    color: const Color(0xFFFFCC00),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5 * s),

            Text(
              '24.543 Ulasan',
              style: _textStyle(size: 10 * s, color: Colors.black87),
            ),
          ],
        ),

        const Spacer(),

        // LOGO ECOWALK
        Image.asset(
          'lib/images/logo_ecowalk_white.png',
          width: 67 * s,
          color: ecoGreen,
          colorBlendMode: BlendMode.srcIn,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Text(
              'ECOWALK',
              style: _textStyle(
                size: 13 * s,
                weight: FontWeight.bold,
                color: ecoGreen,
              ),
            );
          },
        ),
      ],
    );
  }

  // =====================================
  // FILTER SEMUA, FOTO, BINTANG
  // =====================================
  Widget _buildFilterButtons(double s) {
    return Row(
      children: [
        _buildFilterButton(
          s,
          label: 'Semua',
          onTap: () {
            setState(() {
              _selectedFilter = 'Semua';
              _minimumRating = 0;
            });
          },
        ),

        SizedBox(width: 12 * s),

        _buildFilterButton(
          s,
          label: 'Dengan Foto',
          onTap: () {
            setState(() {
              _selectedFilter = _selectedFilter == 'Dengan Foto'
                  ? 'Semua'
                  : 'Dengan Foto';
              _minimumRating = 0;
            });
          },
        ),

        SizedBox(width: 12 * s),

        PopupMenuButton<int>(
          onSelected: (value) {
            setState(() {
              _minimumRating = value;
              _selectedFilter = 'Semua';
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0, child: Text('Semua Bintang')),
            ...List.generate(
              5,
              (index) => PopupMenuItem(
                value: 5 - index,
                child: Text('${5 - index} Bintang'),
              ),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 7 * s),
            decoration: BoxDecoration(
              color: ecoGreen,
              borderRadius: BorderRadius.circular(5 * s),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _minimumRating == 0 ? 'Bintang' : '$_minimumRating Bintang',
                  style: _textStyle(
                    size: 10 * s,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 3 * s),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 13 * s,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(
    double s, {
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5 * s),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13 * s, vertical: 8 * s),
        decoration: BoxDecoration(
          color: ecoGreen,
          borderRadius: BorderRadius.circular(5 * s),
        ),
        child: Text(
          label,
          style: _textStyle(
            size: 10 * s,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // =====================================
  // KARTU ULASAN
  // =====================================
  Widget _buildReviewCard(double s, Map<String, dynamic> review) {
    final bool highlighted = review['highlight'] == true;

    final bool hasPhotos = review['hasPhotos'] == true;

    final int rating = (review['rating'] as int);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6 * s),
        border: highlighted
            ? Border.all(color: const Color(0xFF2196F3), width: 2 * s)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 4 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NAMA DAN RATING
          Row(
            children: [
              CircleAvatar(
                radius: 11 * s,
                backgroundColor: const Color(0xFFD9D9D9),
              ),

              SizedBox(width: 8 * s),

              Expanded(
                child: Text(
                  review['name'].toString(),
                  style: _textStyle(size: 10 * s, weight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5 * s,
                  vertical: 3 * s,
                ),
                decoration: BoxDecoration(
                  color: ecoGreen,
                  borderRadius: BorderRadius.circular(2 * s),
                ),
                child: Text(
                  '$rating.0 / 5.0',
                  style: _textStyle(
                    size: 7 * s,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 17 * s),

          // ISI ULASAN
          Text(
            review['text'].toString(),
            style: _textStyle(
              size: 8.5 * s,
              color: const Color(0xFF333333),
              height: 1.5,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 6 * s),

          Text(
            'Selengkapnya',
            style: _textStyle(size: 8 * s, color: const Color(0xFF29A4D9)),
          ),

          // FOTO ULASAN
          if (hasPhotos) ...[
            SizedBox(height: 8 * s),

            Row(
              children: [
                _buildReviewPhoto(s),
                SizedBox(width: 11 * s),
                _buildReviewPhoto(s),
              ],
            ),
          ],

          SizedBox(height: 14 * s),

          // TANGGAL DI KANAN BAWAH
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Diulas pada ${review['date']}',
              style: _textStyle(size: 7 * s, color: const Color(0xFF666666)),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // FOTO CONTOH PADA ULASAN
  // =====================================
  Widget _buildReviewPhoto(double s) {
    return Container(
      width: 60 * s,
      height: 58 * s,
      color: const Color(0xFFD9D9D9),
    );
  }
}
