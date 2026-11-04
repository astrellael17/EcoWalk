import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SortPage extends StatefulWidget {
  final String selectedSort;

  const SortPage({super.key, this.selectedSort = 'Direkomendasikan'});

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  late String _selectedSort;

  final List<String> _sortOptions = [
    'Direkomendasikan',
    'Harga Tertinggi',
    'Harga Terendah',
    'Ulasan Terbaik',
    'Jarak Terdekat',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.selectedSort;
  }

  // =====================================
  // FONT INTER
  // =====================================
  TextStyle interStyle({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    double height = 1.2,
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
  // PILIH PENGURUTAN
  // =====================================
  void _selectSort(String option) {
    setState(() {
      _selectedSort = option;
    });

    Navigator.pop(context, option);
  }

  // =====================================
  // BUILD BOTTOM SHEET
  // =====================================
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double s = (constraints.maxWidth / 390)
            .clamp(0.8, 1.2)
            .toDouble();

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20 * s)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =====================================
              // GARIS PEGANGAN
              // =====================================
              SizedBox(height: 15 * s),

              Container(
                width: 90 * s,
                height: 9 * s,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: 14 * s),

              // =====================================
              // HEADER URUTKAN
              // =====================================
              _buildHeader(s),

              SizedBox(height: 11 * s),

              // GARIS PEMISAH
              const Divider(height: 1, thickness: 1, color: Color(0xFFD8D8D8)),

              // =====================================
              // DAFTAR PILIHAN
              // =====================================
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: _sortOptions.map((option) {
                      return _buildSortOption(s, option);
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 8 * s),
            ],
          ),
        );
      },
    );
  }

  // =====================================
  // HEADER URUTKAN
  // =====================================
  Widget _buildHeader(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Urutkan',
            style: interStyle(
              size: 16 * s,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 30 * s,
              height: 30 * s,
              child: Center(
                child: Icon(Icons.close, size: 21 * s, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // BARIS PILIHAN URUTKAN
  // =====================================
  Widget _buildSortOption(double s, String option) {
    final bool isSelected = _selectedSort == option;

    return InkWell(
      onTap: () {
        _selectSort(option);
      },
      child: Container(
        width: double.infinity,
        height: 43 * s,
        padding: EdgeInsets.symmetric(horizontal: 16 * s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option,
              style: interStyle(
                size: 13 * s,
                weight: FontWeight.w400,
                color: Colors.black,
              ),
            ),

            // RADIO BUTTON SESUAI FIGMA
            Container(
              width: 18 * s,
              height: 18 * s,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ecoGreen, width: 1),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9 * s,
                        height: 9 * s,
                        decoration: const BoxDecoration(
                          color: ecoGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
