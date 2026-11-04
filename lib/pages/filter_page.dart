import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

// =====================================
// DATA HASIL FILTER
// =====================================
class FilterResult {
  final double distance;
  final String distanceType;
  final int minimumPrice;
  final int maximumPrice;
  final String? popularLocation;
  final String? zone;

  const FilterResult({
    required this.distance,
    required this.distanceType,
    required this.minimumPrice,
    required this.maximumPrice,
    required this.popularLocation,
    required this.zone,
  });
}

// =====================================
// HALAMAN FILTER
// =====================================
class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _distance = 6;
  String _distanceType = '500 M';

  int _minimumPrice = 100000;
  int _maximumPrice = 99999999;

  String? _selectedPrice;
  String? _selectedLocation;
  String? _selectedZone;

  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;

  final List<String> _popularLocations = [
    'Blok M',
    'Gelora Bung Karno',
    'Senayan',
    'Citra Delapan',
  ];

  @override
  void initState() {
    super.initState();

    _minPriceController = TextEditingController(
      text: _formatPrice(_minimumPrice),
    );

    _maxPriceController = TextEditingController(
      text: _formatPrice(_maximumPrice),
    );
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
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
  // FORMAT HARGA
  // =====================================
  String _formatPrice(int value) {
    final angka = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(angka[i]);
    }

    return 'Rp ${buffer.toString()},00';
  }

  void _setPriceText(TextEditingController controller, int price) {
    final text = _formatPrice(price);

    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  // =====================================
  // RESET FILTER
  // =====================================
  void _resetFilter() {
    setState(() {
      _distance = 6;
      _distanceType = '500 M';

      _minimumPrice = 100000;
      _maximumPrice = 99999999;

      _selectedPrice = null;
      _selectedLocation = null;
      _selectedZone = null;

      _setPriceText(_minPriceController, _minimumPrice);
      _setPriceText(_maxPriceController, _maximumPrice);
    });
  }

  // =====================================
  // TUTUP FILTER
  // =====================================
  void _closeFilter() {
    FocusScope.of(context).unfocus();

    Navigator.pop(
      context,
      FilterResult(
        distance: _distance,
        distanceType: _distanceType,
        minimumPrice: _minimumPrice,
        maximumPrice: _maximumPrice,
        popularLocation: _selectedLocation,
        zone: _selectedZone,
      ),
    );
  }

  // =====================================
  // PILIH RENTANG HARGA
  // =====================================
  void _selectPrice(String option) {
    setState(() {
      _selectedPrice = option;

      switch (option) {
        case '< Rp 50.000,00':
          _minimumPrice = 0;
          _maximumPrice = 50000;
          break;

        case '< Rp 100.000,00':
          _minimumPrice = 0;
          _maximumPrice = 100000;
          break;

        case '< Rp 300.000,00':
          _minimumPrice = 0;
          _maximumPrice = 300000;
          break;

        case 'Gratis':
          _minimumPrice = 0;
          _maximumPrice = 0;
          break;
      }

      _setPriceText(_minPriceController, _minimumPrice);
      _setPriceText(_maxPriceController, _maximumPrice);
    });
  }

  // =====================================
  // EDIT HARGA
  // =====================================
  Future<void> _editPrice({required bool isMinimum}) async {
    final currentValue = isMinimum ? _minimumPrice : _maximumPrice;

    final controller = TextEditingController(text: currentValue.toString());

    final int? result = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isMinimum ? 'Harga Minimal' : 'Harga Maksimal',
            style: interStyle(size: 16, weight: FontWeight.bold),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              prefixText: 'Rp ',
              hintText: 'Masukkan nominal',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  int.tryParse(controller.text) ?? 0,
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!mounted || result == null) return;

    setState(() {
      _selectedPrice = null;

      if (isMinimum) {
        _minimumPrice = result;
        _setPriceText(_minPriceController, result);
      } else {
        _maximumPrice = result;
        _setPriceText(_maxPriceController, result);
      }
    });
  }

  // =====================================
  // BUILD HALAMAN
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(18 * s)),
          ),
          child: Column(
            children: [
              SizedBox(height: 16 * s),

              // GARIS PEGANGAN
              Container(
                width: 98 * s,
                height: 8 * s,
                decoration: BoxDecoration(
                  color: const Color(0xFFDADADA),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: 12 * s),

              _buildFilterHeader(s),

              SizedBox(height: 12 * s),

              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.viewInsetsOf(context).bottom + 16 * s,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDistanceSection(s),
                      _buildDivider(s),
                      _buildPriceSection(s),
                      _buildDivider(s),
                      _buildPopularLocations(s),
                      _buildZoneSection(s),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================
  // HEADER FILTER
  // =====================================
  Widget _buildFilterHeader(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Row(
        children: [
          Text(
            'Filter',
            style: interStyle(size: 17 * s, weight: FontWeight.bold),
          ),

          const Spacer(),

          InkWell(
            onTap: _resetFilter,
            child: Text(
              'Reset',
              style: interStyle(size: 12 * s, color: const Color(0xFF2196F3)),
            ),
          ),

          SizedBox(width: 14 * s),

          // REVISI: X BERWARNA BIRU
          InkWell(
            onTap: _closeFilter,
            child: Icon(
              Icons.close,
              size: 18 * s,
              color: const Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // RENTANG JARAK
  // =====================================
  Widget _buildDistanceSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15 * s),

          Text(
            'Rentang Jarak',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 11 * s),

          Row(
            children: [
              _buildDistanceButton(s, '500 M'),
              SizedBox(width: 7 * s),
              _buildDistanceButton(s, 'Terdekat'),
              SizedBox(width: 7 * s),
              _buildDistanceButton(s, 'Terjauh'),
            ],
          ),

          SizedBox(height: 10 * s),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ecoGreen,
              inactiveTrackColor: const Color(0xFFBDBDBD),
              thumbColor: ecoGreen,
              overlayColor: ecoGreen.withOpacity(0.12),
              trackHeight: 2 * s,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5 * s),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 10 * s),
            ),
            child: Slider(
              value: _distance,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _distance = value;
                });
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Terdekat', style: interStyle(size: 8 * s)),
              Text('Terjauh', style: interStyle(size: 8 * s)),
            ],
          ),

          SizedBox(height: 19 * s),
        ],
      ),
    );
  }

  // =====================================
  // TOMBOL JARAK
  // =====================================
  Widget _buildDistanceButton(double s, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _distanceType = label;

          if (label == '500 M') {
            _distance = 6;
          } else if (label == 'Terdekat') {
            _distance = 0;
          } else {
            _distance = 100;
          }
        });
      },
      child: Container(
        width: 79 * s,
        height: 23 * s,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ecoGreen,
          borderRadius: BorderRadius.circular(4 * s),
        ),
        child: Text(
          label,
          style: interStyle(
            size: 10 * s,
            weight: _distanceType == label ? FontWeight.w700 : FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // =====================================
  // GARIS PEMISAH
  // =====================================
  Widget _buildDivider(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5 * s),
      child: const Divider(height: 1, thickness: 1, color: Color(0xFFE9E9E9)),
    );
  }

  // =====================================
  // RENTANG HARGA
  // =====================================
  Widget _buildPriceSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16 * s),

          Text(
            'Rentang Harga',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 14 * s),

          Row(
            children: [
              Expanded(
                child: _buildPriceInput(
                  s,
                  label: 'Minimal',
                  controller: _minPriceController,
                  onTap: () {
                    _editPrice(isMinimum: true);
                  },
                ),
              ),

              SizedBox(width: 16 * s),

              Expanded(
                child: _buildPriceInput(
                  s,
                  label: 'Maksimal',
                  controller: _maxPriceController,
                  onTap: () {
                    _editPrice(isMinimum: false);
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 18 * s),

          Row(
            children: [
              Expanded(child: _buildPriceOption(s, '< Rp 50.000,00')),

              SizedBox(width: 16 * s),

              Expanded(child: _buildPriceOption(s, '< Rp 100.000,00')),
            ],
          ),

          SizedBox(height: 13 * s),

          Row(
            children: [
              Expanded(child: _buildPriceOption(s, '< Rp 300.000,00')),

              SizedBox(width: 16 * s),

              Expanded(child: _buildPriceOption(s, 'Gratis')),
            ],
          ),

          SizedBox(height: 18 * s),
        ],
      ),
    );
  }

  // =====================================
  // KOTAK HARGA
  // =====================================
  Widget _buildPriceInput(
    double s, {
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46 * s,
        padding: EdgeInsets.symmetric(horizontal: 11 * s, vertical: 5 * s),
        decoration: BoxDecoration(
          color: ecoGreen,
          borderRadius: BorderRadius.circular(5 * s),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: interStyle(size: 9 * s, color: Colors.white),
            ),

            SizedBox(height: 3 * s),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                controller.text,
                maxLines: 1,
                style: interStyle(
                  size: 15 * s,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // PILIHAN HARGA
  // =====================================
  Widget _buildPriceOption(double s, String option) {
    final bool selected = _selectedPrice == option;

    return InkWell(
      onTap: () {
        _selectPrice(option);
      },
      borderRadius: BorderRadius.circular(20 * s),
      child: Container(
        height: 29 * s,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF3EF) : Colors.white,
          borderRadius: BorderRadius.circular(20 * s),
          border: Border.all(
            color: selected ? ecoGreen : Colors.black87,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          option,
          textAlign: TextAlign.center,
          style: interStyle(size: 10 * s, weight: FontWeight.w600),
        ),
      ),
    );
  }

  // =====================================
  // LOKASI POPULER
  // =====================================
  Widget _buildPopularLocations(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30 * s),

          Text(
            'Lokasi Populer',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 12 * s),

          ..._popularLocations.map(
            (location) => InkWell(
              onTap: () {
                setState(() {
                  _selectedLocation = _selectedLocation == location
                      ? null
                      : location;
                });
              },
              child: SizedBox(
                height: 30 * s,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(location, style: interStyle(size: 12 * s)),
                    ),

                    Container(
                      width: 14 * s,
                      height: 14 * s,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ecoGreen, width: 1),
                      ),
                      child: _selectedLocation == location
                          ? Center(
                              child: Container(
                                width: 7 * s,
                                height: 7 * s,
                                decoration: BoxDecoration(
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
            ),
          ),

          SizedBox(height: 24 * s),
        ],
      ),
    );
  }

  // =====================================
  // ZONA
  // =====================================
  Widget _buildZoneSection(double s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zona',
            style: interStyle(size: 13 * s, weight: FontWeight.bold),
          ),

          SizedBox(height: 11 * s),

          Row(
            children: [
              _buildZoneCard(
                s,
                label: 'Dalam Ruangan',
                selected: _selectedZone == 'Dalam Ruangan',
                isIndoor: true,
                onTap: () {
                  setState(() {
                    _selectedZone = _selectedZone == 'Dalam Ruangan'
                        ? null
                        : 'Dalam Ruangan';
                  });
                },
              ),

              SizedBox(width: 15 * s),

              _buildZoneCard(
                s,
                label: 'Luar Ruangan',
                selected: _selectedZone == 'Luar Ruangan',
                isIndoor: false,
                onTap: () {
                  setState(() {
                    _selectedZone = _selectedZone == 'Luar Ruangan'
                        ? null
                        : 'Luar Ruangan';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================
  // KARTU ZONA
  // =====================================
  Widget _buildZoneCard(
    double s, {
    required String label,
    required bool selected,
    required bool isIndoor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5 * s),
      child: Container(
        width: 65 * s,
        height: 65 * s,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5 * s),
          border: Border.all(
            color: selected ? ecoGreen : const Color(0xFFBDBDBD),
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIndoor)
              CustomPaint(
                size: Size(24 * s, 25 * s),
                painter: _IndoorZoneIconPainter(),
              )
            else
              Icon(Icons.sports_soccer, size: 24 * s, color: Colors.black),

            SizedBox(height: 4 * s),

            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: interStyle(size: 7 * s, weight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================
// IKON DALAM RUANGAN
// =====================================
class _IndoorZoneIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final Path building = Path();

    building.moveTo(size.width * 0.12, size.height * 0.95);
    building.lineTo(size.width * 0.12, size.height * 0.38);
    building.quadraticBezierTo(
      size.width * 0.12,
      size.height * 0.31,
      size.width * 0.21,
      size.height * 0.24,
    );

    building.lineTo(size.width * 0.43, size.height * 0.07);
    building.quadraticBezierTo(
      size.width * 0.50,
      size.height * 0.01,
      size.width * 0.57,
      size.height * 0.07,
    );

    building.lineTo(size.width * 0.79, size.height * 0.24);
    building.quadraticBezierTo(
      size.width * 0.88,
      size.height * 0.31,
      size.width * 0.88,
      size.height * 0.38,
    );

    building.lineTo(size.width * 0.88, size.height * 0.95);
    building.close();

    canvas.drawPath(building, paint);

    for (int i = 0; i < 3; i++) {
      final double y = size.height * (0.39 + i * 0.17);

      final Path wave = Path()
        ..moveTo(size.width * 0.29, y)
        ..quadraticBezierTo(
          size.width * 0.39,
          y - size.height * 0.12,
          size.width * 0.50,
          y,
        )
        ..quadraticBezierTo(
          size.width * 0.61,
          y + size.height * 0.11,
          size.width * 0.71,
          y,
        );

      canvas.drawPath(wave, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
