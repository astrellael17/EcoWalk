import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color primaryGreen = const Color(0xFF236553);

  static const double contentPadding = 16;
  static const double cardSpacing = 12;

  final ScrollController _recommendationController = ScrollController(
    keepScrollOffset: false,
  );

  @override
  void dispose() {
    _recommendationController.dispose();
    super.dispose();
  }

  double _recommendationWidth(double screenWidth) {
    final double thirdPeek = (screenWidth * 0.038).clamp(10.0, 15.0).toDouble();

    final double cardWidth =
        (screenWidth - contentPadding - (cardSpacing * 2) - thirdPeek) / 2;

    return cardWidth.clamp(100.0, 190.0).toDouble();
  }

  double _smallCardWidth(double screenWidth) {
    final available = screenWidth - (contentPadding * 2);
    final peek = (screenWidth * 0.10).clamp(28.0, 44.0);

    return ((available - (cardSpacing * 2) - peek) / 2)
        .clamp(100.0, 190.0)
        .toDouble();
  }

  double _lastViewedWidth(double screenWidth) {
    final available = screenWidth - (contentPadding * 2);

    return (available * 0.42).clamp(100.0, 185.0).toDouble();
  }

  Future<void> _openDufanDetail(BuildContext context) async {
    await Navigator.pushNamed(context, '/dufan-detail');

    if (!mounted) return;

    if (_recommendationController.hasClients) {
      _recommendationController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: ecoGreen,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildWeatherCard(),
                    const SizedBox(height: 4),
                    _buildSectionTitle('Rekomendasi', showAction: false),
                    const SizedBox(height: 4),
                    _buildRecommendationList(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, '/write-review');
                      },
                      child: _buildReviewPrompt(),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: _buildSectionTitle('Kategori', showAction: false),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: _buildCategoryList(),
                    ),
                    const SizedBox(height: 12),
                    _buildSectionTitle('Pilihan Teratas', showAction: true),
                    const SizedBox(height: 4),
                    _buildSmallCardList(),
                    const SizedBox(height: 4),
                    _buildBanner(),
                    _buildSectionTitle('Kunjungi Lagi', showAction: true),
                    const SizedBox(height: 4),
                    _buildSmallCardList(),
                    const SizedBox(height: 16),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, '/recently-viewed');
                      },
                      child: _buildSectionTitle(
                        'Terakhir Dilihat',
                        showAction: true,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildLastViewed(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildCustomBottomNav(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'lib/images/logo_ecowalk_white.png',
            height: 27,
            color: const Color(0xFF236553),
            colorBlendMode: BlendMode.srcIn,
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('lib/images/ellipse.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      height: 210,
      margin: const EdgeInsets.fromLTRB(7, 12, 16, 10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.52, 1.0],
                  colors: [
                    Color(0xFF195E4C),
                    Color(0xFF236D5A),
                    Color(0xFFD9DEDA),
                  ],
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 1.35),
                  radius: 1.05,
                  stops: [0.0, 0.58, 1.0],
                  colors: [
                    Color(0xBFFFFFFF),
                    Color(0x40FFFFFF),
                    Color(0x00FFFFFF),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 210,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Minggu, 16 Februari 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Klapanunggal, Bogor',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '30°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cerah Berawan',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: -12,
            width: 210,
            height: 190,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: Image.asset('lib/images/cuaca.png', fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {required bool showAction}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: contentPadding,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          if (showAction)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (title == 'Pilihan Teratas') {
                  Navigator.pushNamed(context, '/category');
                } else if (title == 'Kunjungi Lagi') {
                  Navigator.pushNamed(context, '/trip-summary');
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title == 'Pilihan Teratas' ? 'Jelajahi' : 'Selengkapnya',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const Icon(Icons.chevron_right, size: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendationList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = _recommendationWidth(constraints.maxWidth);

        final double cardHeight = cardWidth * 1.28;

        return SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: ListView(
            controller: _recommendationController,
            scrollDirection: Axis.horizontal,
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: contentPadding),
            children: [
              _buildRecCard(
                'Dunia Fantasi (DUFAN)',
                'Ancol, Jakarta Utara',
                'Rp. 350.000',
                '1.58 KM',
                'lib/images/dufan.png',
                width: cardWidth,
                height: cardHeight,
                openDufan: true,
              ),
              const SizedBox(width: cardSpacing),
              _buildRecCard(
                'Taman Mini Indonesia Indah (TMII)',
                'Jakarta Timur',
                'Mulai dari Rp. 35.000',
                '5.88 KM',
                'lib/images/tmii.png',
                width: cardWidth,
                height: cardHeight,
              ),
              const SizedBox(width: cardSpacing),
              _buildRecCard(
                'Taman Mini Indonesia Indah (TMII)',
                'Jakarta Timur',
                'Mulai dari Rp. 35.000',
                '5.88 KM',
                'lib/images/tmii.png',
                width: cardWidth,
                height: cardHeight,
              ),
              const SizedBox(width: cardSpacing),
              _buildRecCard(
                'Taman Mini Indonesia Indah (TMII)',
                'Jakarta Timur',
                'Mulai dari Rp. 35.000',
                '5.88 KM',
                'lib/images/tmii.png',
                width: cardWidth,
                height: cardHeight,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecCard(
    String title,
    String location,
    String price,
    String distance,
    String imagePath, {
    bool openDufan = false,
    double width = 155,
    double height = 210,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: openDufan ? () => _openDufanDetail(context) : null,
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.38, 1.0],
                    colors: [
                      Colors.transparent,
                      Color(0xB8000000),
                      Color(0xF5000000),
                    ],
                  ),
                ),
              ),
            ),
            if (distance.isNotEmpty)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    distance,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 10,
                      ),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Color(0xFFFFD331), size: 10),
                      Icon(Icons.star, color: Color(0xFFFFD331), size: 10),
                      Icon(Icons.star, color: Color(0xFFFFD331), size: 10),
                      Icon(Icons.star, color: Color(0xFFFFD331), size: 10),
                      Icon(
                        Icons.star_border,
                        color: Color(0xFFFFD331),
                        size: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewPrompt() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Bagaimana Perjalananmu?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Icon(Icons.close, size: 18, color: Colors.grey),
            ],
          ),
          const Text(
            'Yuk beri ulasan untuk tempat yang baru kamu kunjungi !',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.star_border, size: 28, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      'Semua',
      'Kuliner',
      'Sejarah',
      'Alam',
      'Religi',
      'Seni',
    ];

    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: contentPadding),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == 0;

          return Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? primaryGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSmallCardList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = _smallCardWidth(constraints.maxWidth);

        final double cardHeight = cardWidth * 0.72;

        return SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: contentPadding),
            children: [
              _buildSmallCard(
                'Dunia Fantasi (DUFAN)',
                'lib/images/dufan.png',
                width: cardWidth,
                height: cardHeight,
              ),
              const SizedBox(width: cardSpacing),
              _buildSmallCard(
                'Dunia Fantasi (DUFAN)',
                'lib/images/dufan.png',
                width: cardWidth,
                height: cardHeight,
              ),
              const SizedBox(width: cardSpacing),
              _buildSmallCard(
                'Dunia Fantasi (DUFAN)',
                'lib/images/dufan.png',
                width: cardWidth,
                height: cardHeight,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSmallCard(
    String title,
    String imagePath, {
    double width = 140,
    double height = 100,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openDufanDetail(context),
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: height * 0.52,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.35, 1.0],
                    colors: [
                      Colors.transparent,
                      Color(0xB8000000),
                      Color(0xF0000000),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 8),
                        Flexible(
                          child: Text(
                            ' Ancol, Jakarta Utara',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('lib/images/banner.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildLastViewed() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = _lastViewedWidth(constraints.maxWidth);

        final double cardHeight = cardWidth * 1.43;

        final double availableWidth =
            constraints.maxWidth - (contentPadding * 2);

        final double remainingWidth = availableWidth - cardWidth - 20;

        final double robotWidth = remainingWidth.clamp(0.0, 72.0).toDouble();

        return Padding(
          padding: const EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            bottom: 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildRecCard(
                'Dunia Fantasi (DUFAN)',
                'Ancol, Jakarta Utara',
                'Rp. 350.000',
                '1.58 KM',
                'lib/images/dufan.png',
                width: cardWidth,
                height: cardHeight,
                openDufan: true,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: Image.asset(
                  'lib/images/robot.png',
                  width: robotWidth,
                  height: 85,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(width: robotWidth, height: 85);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomBottomNav(BuildContext context) {
    final double s = MediaQuery.sizeOf(context).width / 390;
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    const double navHeight = 72;
    final double totalHeight = 106 + bottomInset;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: navHeight + bottomInset,
            child: Container(color: ecoGreen),
          ),
          Positioned(
            bottom: bottomInset,
            left: 85 * s,
            right: 0,
            height: 59,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    '/recommendation',
                  ),
                  child: SizedBox(
                    width: 46 * s,
                    height: 59,
                    child: Center(
                      child: Icon(
                        Icons.verified_user,
                        color: Colors.white,
                        size: 27 * s,
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.chat_bubble, color: Colors.white, size: 31 * s),
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/profile'),
                  child: SizedBox(
                    width: 46 * s,
                    height: 59,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30 * s,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: bottomInset + 31,
            left: 18 * s,
            child: Container(
              width: 62 * s,
              height: 62 * s,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ecoGreen, width: 6),
              ),
              child: Icon(Icons.home, color: ecoGreen, size: 30 * s),
            ),
          ),
          Positioned(
            bottom: bottomInset + 15,
            left: 18 * s,
            width: 62 * s,
            child: Text(
              'BERANDA',
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
    );
  }
}
