import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class EcoWalkLogo extends StatelessWidget {
  final bool white;
  final double width;

  const EcoWalkLogo({super.key, this.white = false, this.width = 180});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/images/logo_ecowalk_white.png',
      width: width,
      fit: BoxFit.contain,
      color: white ? null : ecoGreen,
      colorBlendMode: white ? null : BlendMode.srcIn,
    );
  }
}
