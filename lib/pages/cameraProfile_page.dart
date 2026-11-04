import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CameraProfilePage extends StatelessWidget {
  const CameraProfilePage({super.key});

  static const String fotoPath = 'lib/images/foto.png';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,

        extendBodyBehindAppBar: true,

        body: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            final double scale = (screenWidth / 390).clamp(0.8, 1.2).toDouble();

            final double topPadding = MediaQuery.paddingOf(context).top;

            return SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // =====================================
                  // FOTO PEREMPUAN
                  // =====================================
                  Image.asset(
                    fotoPath,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0.12, -1.0),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: topPadding + 20 * scale,
                    child: Container(color: const Color(0x40FFFFFF)),
                  ),

                  // =====================================
                  // IKON REPLACE
                  // =====================================
                  Positioned(
                    top: topPadding + 40 * scale,
                    right: 25 * scale,
                    child: Icon(
                      Icons.flip_camera_android,
                      color: Colors.white,
                      size: 29 * scale,
                    ),
                  ),

                  // =====================================
                  // TOMBOL KAMERA HIJAU
                  // =====================================
                  Positioned(
                    left: 0,
                    right: 0,
                    top:
                        screenHeight -
                        (78 * scale +
                            MediaQuery.paddingOf(context).bottom +
                            24 * scale +
                            84 * scale) +
                        15 * scale,
                    child: Center(
                      child: Material(
                        color: ecoGreen,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            Navigator.pop(context, 'lib/images/foto.png');
                          },
                          child: SizedBox(
                            width: 84 * scale,
                            height: 84 * scale,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 34 * scale,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
