import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'filter_page.dart';
import 'sort_page.dart';
import '../constants/app_colors.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Semua',
    'Kuliner',
    'Sejarah',
    'Alam',
    'Religi',
    'Seni',
  ];

  String _selectedCategory = 'Semua';
  String _selectedSort = 'Default';
  bool _showOpenOnly = false;

  bool _isFilterOpen = false;
  static const Color _filterBackground = Color(0xFFE5E5E5);

  final List<Map<String, dynamic>> _destinations = List.generate(
    10,
    (index) => {
      'name': 'Dunia Fantasi (DUFAN)',
      'category': 'Semua',
      'rating': 4.75,
      'hours': 'Open 10:00 - 22:00',
      'location': 'Ancol, Jakarta Utara',
      'price': 200000,
      'isOpen': true,
    },
  );

  @override
  void dispose() {
    _searchController.dispose();
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

  // =====================================
  // FILTER DATA DESTINASI
  // =====================================
  List<Map<String, dynamic>> get _filteredDestinations {
    final String keyword = _searchController.text.trim().toLowerCase();

    final results = _destinations.where((destination) {
      final String name = destination['name'].toString().toLowerCase();

      final String location = destination['location'].toString().toLowerCase();

      final bool matchesSearch =
          name.contains(keyword) || location.contains(keyword);

      final bool matchesCategory =
          _selectedCategory == 'Semua' ||
          destination['category'] == _selectedCategory;

      final bool matchesOpen = !_showOpenOnly || destination['isOpen'] == true;

      return matchesSearch && matchesCategory && matchesOpen;
    }).toList();

    if (_selectedSort == 'Rating Tertinggi') {
      results.sort(
        (a, b) => (b['rating'] as num).compareTo(a['rating'] as num),
      );
    } else if (_selectedSort == 'Harga Terendah') {
      results.sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
    } else if (_selectedSort == 'Harga Tertinggi') {
      results.sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
    }

    return results;
  }

  String _formatPrice(int value) {
    final String number = value.toString();
    final StringBuffer result = StringBuffer();

    for (int i = 0; i < number.length; i++) {
      if (i > 0 && (number.length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(number[i]);
    }

    return result.toString();
  }

  // =====================================
  // MEMBUKA FILTER
  // =====================================
  Future<void> _showFilterOptions() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isFilterOpen = true;
    });

    try {
      await showModalBottomSheet<FilterResult>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.87,
            child: Container(
              color: _filterBackground,
              padding: const EdgeInsets.only(top: 15),
              child: const FilterPage(),
            ),
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isFilterOpen = false;
        });
      }
    }
  }

  // =====================================
  // MEMBUKA URUTKAN
  // =====================================
  void _showSortOptions() async {
    final String currentSort = _selectedSort == 'Default'
        ? 'Direkomendasikan'
        : _selectedSort == 'Rating Tertinggi'
        ? 'Ulasan Terbaik'
        : _selectedSort;

    final String? selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.22),
      elevation: 0,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.47,
          alignment: Alignment.bottomCenter,
          child: SortPage(selectedSort: currentSort),
        );
      },
    );

    if (!mounted || selected == null) return;

    setState(() {
      if (selected == 'Direkomendasikan') {
        _selectedSort = 'Default';
      } else if (selected == 'Ulasan Terbaik') {
        _selectedSort = 'Rating Tertinggi';
      } else {
        _selectedSort = selected;
      }
    });
  }

  // =====================================
  // HALAMAN UTAMA
  // =====================================
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
                  _buildHeader(s),

                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            _buildSearchAndActions(s),
                            _buildCategoryTabs(s),
                            Expanded(child: _buildDestinationList(s)),
                          ],
                        ),

                        if (_isFilterOpen)
                          const Positioned.fill(
                            child: ColoredBox(color: _filterBackground),
                          ),
                      ],
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
  // HEADER HIJAU
  // =====================================
  Widget _buildHeader(double s) {
    return Container(
      width: double.infinity,
      height: 56 * s,
      color: ecoGreen,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23 * s),
          ),
          SizedBox(width: 4 * s),
          Text(
            'Kategori',
            style: interStyle(
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
  // SEARCH, FILTER, URUTKAN
  // =====================================
  Widget _buildSearchAndActions(double s) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16 * s,
        right: 12 * s,
        top: 17 * s,
        bottom: 16 * s,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 34 * s,
              child: TextField(
                controller: _searchController,
                onChanged: (_) {
                  setState(() {});
                },
                textAlignVertical: TextAlignVertical.center,
                style: interStyle(size: 11 * s, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Cari destinasi wisata',
                  hintStyle: interStyle(
                    size: 10 * s,
                    style: FontStyle.italic,
                    color: const Color(0xFF333333),
                  ),
                  prefixIcon: Icon(Icons.search, size: 19 * s, color: ecoGreen),
                  prefixIconConstraints: BoxConstraints(minWidth: 34 * s),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 7 * s,
                    horizontal: 10 * s,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22 * s),
                    borderSide: const BorderSide(
                      color: Color(0xFFD9D9D9),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22 * s),
                    borderSide: BorderSide(color: ecoGreen, width: 1),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 19 * s),

          _buildActionIcon(
            s,
            icon: Icons.tune,
            label: 'Filter',
            onTap: _showFilterOptions,
          ),

          SizedBox(width: 15 * s),

          _buildActionIcon(
            s,
            icon: Icons.sort,
            label: 'Urutkan',
            onTap: _showSortOptions,
          ),
        ],
      ),
    );
  }

  // =====================================
  // IKON FILTER DAN URUTKAN
  // =====================================
  Widget _buildActionIcon(
    double s, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 38 * s,
        height: 42 * s,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ecoGreen, size: 25 * s),
            SizedBox(height: 2 * s),
            Text(
              label,
              style: interStyle(size: 8 * s, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // TAB KATEGORI
  // =====================================
  Widget _buildCategoryTabs(double s) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Row(
        children: _categories.map((category) {
          final bool selected = _selectedCategory == category;

          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: SizedBox(
                height: 43 * s,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      category,
                      style: interStyle(
                        size: 12.5 * s,
                        weight: selected ? FontWeight.w600 : FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 9 * s),
                    Container(
                      height: 2 * s,
                      margin: EdgeInsets.symmetric(horizontal: 8 * s),
                      color: selected ? ecoGreen : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // =====================================
  // DAFTAR DESTINASI
  // =====================================
  Widget _buildDestinationList(double s) {
    final destinations = _filteredDestinations;

    if (destinations.isEmpty) {
      return Center(
        child: Text(
          'Destinasi tidak ditemukan.',
          style: interStyle(size: 13 * s, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        return _buildDestinationItem(s, destinations[index]);
      },
    );
  }

  // =====================================
  // ITEM DESTINASI
  // =====================================
  Widget _buildDestinationItem(double s, Map<String, dynamic> destination) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/dufan-detail');
      },
      child: Container(
        width: double.infinity,
        height: 76 * s,
        padding: EdgeInsets.symmetric(horizontal: 15 * s),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48 * s,
              height: 48 * s,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: 11 * s),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interStyle(
                      size: 13.5 * s,
                      weight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 2 * s),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 12 * s,
                        color: const Color(0xFFFFCB05),
                      ),
                      SizedBox(width: 2 * s),
                      Flexible(
                        child: Text(
                          '${destination['rating']} | '
                          '${destination['hours']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interStyle(
                            size: 9.5 * s,
                            color: Colors.black87,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2 * s),
                  Text(
                    destination['location'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interStyle(
                      size: 9.5 * s,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 2 * s),
                  Text(
                    'Mulai dari Rp. ${_formatPrice(destination['price'] as int)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interStyle(
                      size: 9.5 * s,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8 * s),

            Icon(Icons.chevron_right, color: Colors.black, size: 23 * s),
          ],
        ),
      ),
    );
  }
}
