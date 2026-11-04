import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../widgets/ecowalk_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    const String correctUsername = 'astrella';
    const String correctPassword = '123456';

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pengguna dan kata sandi harus diisi.'),
        ),
      );
      return;
    }

    if (username == correctUsername && password == correctPassword) {
      // =====================================
      // REVISI: LOGIN LANGSUNG KE BERANDA
      // =====================================
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama pengguna atau kata sandi salah.')),
      );
    }
  }

  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required double height,
    required double s,
    bool obscure = false,
    Widget? suffix,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 13 * s),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          prefixIcon: Icon(icon, size: 19 * s, color: Colors.black54),
          prefixIconConstraints: BoxConstraints(minWidth: 42 * s, minHeight: 0),
          suffixIcon: suffix,
          suffixIconConstraints: BoxConstraints(minWidth: 42 * s, minHeight: 0),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10 * s,
            vertical: (height - 18) / 2,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD8D8D8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ecoGreen),
          ),
        ),
      ),
    );
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
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double v = constraints.maxHeight / 844;
            final double s = constraints.maxWidth / 390;

            const double sidePad = 20;
            final double fieldHeight = 47 * v;

            Widget place(double top, Widget child) {
              return Positioned(
                top: top * v,
                left: sidePad * s,
                right: sidePad * s,
                child: child,
              );
            }

            return Stack(
              children: [
                place(
                  133,
                  Text(
                    'MASUK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ecoGreen,
                      fontSize: 16 * s,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                place(
                  168,
                  Center(heightFactor: 1, child: EcoWalkLogo(width: 230 * s)),
                ),

                place(
                  272,
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(fontSize: 12 * s, color: Colors.black),
                  ),
                ),

                place(
                  299,
                  _inputField(
                    controller: usernameController,
                    icon: Icons.person,
                    height: fieldHeight,
                    s: s,
                  ),
                ),

                place(
                  358,
                  Text(
                    'Kata Sandi',
                    style: TextStyle(fontSize: 12 * s, color: Colors.black),
                  ),
                ),

                place(
                  386,
                  _inputField(
                    controller: passwordController,
                    icon: Icons.lock,
                    height: fieldHeight,
                    s: s,
                    obscure: hidePassword,
                    suffix: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 42 * s,
                        minHeight: 0,
                      ),
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        size: 19 * s,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                ),

                place(
                  485,
                  SizedBox(
                    width: double.infinity,
                    height: 43 * v,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ecoGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: login,
                      child: Text(
                        'MASUK',
                        style: TextStyle(
                          fontSize: 12 * s,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                place(
                  548,
                  Center(
                    heightFactor: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot-password-email');
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          color: linkBlue,
                          fontSize: 11 * s,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),

                place(
                  603,
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFD8D8D8),
                          thickness: 0.8,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14 * s),
                        child: Text(
                          'Atau',
                          style: TextStyle(
                            fontSize: 10 * s,
                            color: Colors.black54,
                          ),
                        ),
                      ),

                      const Expanded(
                        child: Divider(
                          color: Color(0xFFD8D8D8),
                          thickness: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

                place(
                  662,
                  Material(
                    color: const Color(0xFFF2F2F2),
                    elevation: 4,
                    shadowColor: Colors.black38,
                    borderRadius: BorderRadius.circular(6),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () {},
                      child: SizedBox(
                        width: double.infinity,
                        height: 42 * v,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/images/google.png',
                              width: 20 * s,
                              height: 20 * s,
                            ),

                            SizedBox(width: 10 * s),

                            Text(
                              'Lanjutkan dengan Google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12 * s,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                place(
                  747,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tidak punya akun?',
                        style: TextStyle(
                          fontSize: 10 * s,
                          color: Colors.black54,
                        ),
                      ),

                      SizedBox(width: 4 * s),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Daftar disini',
                          style: TextStyle(color: linkBlue, fontSize: 10 * s),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
