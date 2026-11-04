import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final TextEditingController _originController = TextEditingController();

  final TextEditingController _destinationController = TextEditingController();

  final ScrollController _recommendationController = ScrollController();

  final Color primaryGreen = ecoGreen;

  static const double horizontalPadding = 16;
  static const double cardSpacing = 16;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _recommendationController.dispose();
    super.dispose();
  }

  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    double height = 1.2,
    FontStyle style = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontStyle: style,
    );
  }

  void _searchRoute() {
    FocusScope.of(context).unfocus();

    final String origin = _originController.text.trim();
    final String destination = _destinationController.text.trim();

    if (origin.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan lokasi asal dan lokasi tujuan terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/route-recommendation',
      arguments: {'origin': origin, 'destination': destination},
    );
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
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            final double s = (screenWidth / 390).clamp(0.8, 1.2).toDouble();

            final double topInset = MediaQuery.viewPaddingOf(context).top;

            final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

            final double keyboardInset = MediaQuery.viewInsetsOf(context)
                .bottom;

            final double carouselHeight = _calculateCarouselHeight(
              screenWidth,
              s,
            );

            final double usableHeight =
                screenHeight - topInset - bottomInset - 59 - 35 * s;

            final double estimatedTopHeight = 330 * s;
            final double recommendationHeaderHeight = 35 * s;

            final double remainingGap =
                usableHeight -
                estimatedTopHeight -
                recommendationHeaderHeight -
                carouselHeight;

            final double recommendationGap = remainingGap
                .clamp(34 * s, 76 * s)
                .toDouble();

            return Stack(
              children: [
                Positioned.fill(
                  child: SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.only(bottom: 105 * s + bottomInset),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLogo(s),
                          SizedBox(height: 29 * s),
                          _buildSearchSection(s),
                          SizedBox(height: 22 * s),
                          _buildSearchButton(s),
                          SizedBox(height: recommendationGap),
                          _buildRecommendationSection(s),
                        ],
                      ),
                    ),
                  ),
                ),
                if (keyboardInset == 0)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottomNavigation(s, bottomInset),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _calculateCarouselHeight(double screenWidth, double s) {
    final double padding = horizontalPadding * s;
    final double spacing = cardSpacing * s;

    final double thirdPeek = (screenWidth * 0.038).clamp(10.0, 18.0).toDouble();

    final double cardWidth =
        ((screenWidth - padding * 2 - spacing * 2 - thirdPeek) / 2)
            .clamp(90.0, 210.0)
            .toDouble();

    return cardWidth * 1.64;
  }

  Widget _buildLogo(double s) {
    return Padding(
      padding: EdgeInsets.only(left: 18 * s, top: 37 * s),
      child: Image.asset(
        'lib/images/logo_ecowalk_white.png',
        width: 116 * s,
        height: 37 * s,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        color: primaryGreen,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }

  Widget _buildSearchSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MAU KEMANA HARI INI?',
            style: interStyle(size: 16 * s, weight: FontWeight.w800),
          ),
          SizedBox(height: 9 * s),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 20 * s),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(10 * s),
            ),
            child: Column(
              children: [
                _buildLocationInput(
                  s,
                  controller: _originController,
                  hint: 'Masukkan Lokasi Asal',
                  icon: Icons.search,
                ),
                SizedBox(height: 11 * s),
                _buildLocationInput(
                  s,
                  controller: _destinationController,
                  hint: 'Masukkan Lokasi Tujuan',
                  icon: Icons.location_on_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput(
    double s, {
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      height: 43 * s,
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25 * s),
      ),
      child: Row(
        children: [
          Icon(icon, size: 23 * s, color: const Color(0xFF575757)),
          SizedBox(width: 16 * s),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.next,
              style: interStyle(size: 12 * s),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: interStyle(
                  size: 12 * s,
                  style: FontStyle.italic,
                  color: const Color(0xFF777777),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(double s) {
    return Padding(
      padding: EdgeInsets.only(left: 18 * s),
      child: SizedBox(
        width: 140 * s,
        height: 29 * s,
        child: ElevatedButton(
          onPressed: _searchRoute,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22 * s),
            ),
          ),
          child: Text(
            'Cari Rute',
            style: interStyle(
              size: 13 * s,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationSection(double s) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double viewportWidth = constraints.maxWidth;
        final double padding = horizontalPadding * s;
        final double spacing = cardSpacing * s;

        final double thirdPeek = (viewportWidth * 0.038)
            .clamp(10.0, 18.0)
            .toDouble();

        final double cardWidth =
            ((viewportWidth - padding * 2 - spacing * 2 - thirdPeek) / 2)
                .clamp(90.0, 210.0)
                .toDouble();

        final double cardHeight = cardWidth * 1.64;
        final double imageScale = cardHeight / 220;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Text(
                'Rekomendasi Tujuan',
                style: interStyle(size: 13 * s, weight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 19 * s),
            SizedBox(
              height: cardHeight,
              width: double.infinity,
              child: ListView(
                controller: _recommendationController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: padding),
                children: [
                  _buildFrameWisataCard(
                    imageScale: imageScale,
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    sourceOffset: 0,
                  ),
                  SizedBox(width: spacing),
                  _buildFrameWisataCard(
                    imageScale: imageScale,
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    sourceOffset: 173,
                  ),
                  SizedBox(width: spacing),
                  _buildThirdCardPeek(
                    imageScale: imageScale,
                    cardHeight: cardHeight,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFrameWisataCard({
    required double imageScale,
    required double cardWidth,
    required double cardHeight,
    required double sourceOffset,
  }) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: -sourceOffset * imageScale,
              top: 0,
              width: 362 * imageScale,
              height: cardHeight,
              child: Image.asset(
                'lib/images/Framewisata.png',
                width: 362 * imageScale,
                height: cardHeight,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.medium,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E5E5),
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdCardPeek({
    required double imageScale,
    required double cardHeight,
  }) {
    final double peekWidth = 15 * imageScale;

    return SizedBox(
      width: peekWidth,
      height: cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: -347 * imageScale,
              top: 0,
              width: 362 * imageScale,
              height: cardHeight,
              child: Image.asset(
                'lib/images/Framewisata.png',
                width: 362 * imageScale,
                height: cardHeight,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(double s, double bottomInset) {
    return SizedBox(
      height: 93 + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 59 + bottomInset,
            child: Container(color: primaryGreen),
          ),
          Positioned(
            bottom: bottomInset,
            left: 0,
            width: 85 * s,
            height: 59,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Center(
                child: Icon(Icons.home, color: Colors.white, size: 30 * s),
              ),
            ),
          ),
          Positioned(
            bottom: bottomInset,
            left: 190 * s,
            right: 0,
            height: 59,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.chat_bubble, color: Colors.white, size: 31 * s),
                    Icon(Icons.favorite, color: primaryGreen, size: 13 * s),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
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
            bottom: 31 + bottomInset,
            left: 108 * s,
            child: Container(
              width: 62 * s,
              height: 62 * s,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: primaryGreen, width: 6),
              ),
              child: Icon(
                Icons.verified_user_outlined,
                color: primaryGreen,
                size: 30 * s,
              ),
            ),
          ),
          Positioned(
            bottom: 15 + bottomInset,
            left: 89 * s,
            width: 100 * s,
            child: Text(
              'REKOMENDASI',
              textAlign: TextAlign.center,
              style: interStyle(
                size: 8 * s,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final x = size.width / 2;

    const dashHeight = 3.0;
    const dashSpace = 3.0;

    double y = 0;

    while (y < size.height) {
      canvas.drawLine(
        Offset(x, y),
        Offset(x, (y + dashHeight).clamp(0.0, size.height)),
        paint,
      );

      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
