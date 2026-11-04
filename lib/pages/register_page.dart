import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool agree = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void register() {
    final String username = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Semua kolom harus diisi.');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Konfirmasi kata sandi tidak sama.');
      return;
    }

    if (!agree) {
      showMessage('Anda harus menyetujui persyaratan dan privasi pengguna.');
      return;
    }

    Navigator.pushNamed(context, '/verification-hp');
  }

  Widget buildField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required double height,
    required double s,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 13 * s, color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          prefixIcon: Icon(icon, size: 19 * s, color: Colors.black54),
          prefixIconConstraints: BoxConstraints(minWidth: 48 * s, minHeight: 0),
          suffixIcon: suffix,
          suffixIconConstraints: BoxConstraints(minWidth: 48 * s, minHeight: 0),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13 * s,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10 * s,
            vertical: (height - 18) / 2,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ecoGreen, width: 1),
          ),
        ),
      ),
    );
  }

  Widget buildEyeButton({
    required bool hidden,
    required VoidCallback onPressed,
    required double s,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: 48 * s, minHeight: 0),
      onPressed: onPressed,
      icon: Icon(
        hidden ? Icons.visibility_off : Icons.visibility,
        size: 19 * s,
        color: Colors.black54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    final double v = screen.height / 844;
    final double s = screen.width / 390;

    const double sidePad = 22;
    final double fieldHeight = 47 * v;

    Widget place(double top, Widget child) {
      return Positioned(
        top: top * v,
        left: sidePad * s,
        right: sidePad * s,
        child: child,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: screen.width,
            height: screen.height,
            child: Stack(
              children: [
                place(
                  120,
                  Center(
                    heightFactor: 1,
                    child: SizedBox(
                      width: 223 * s,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BUAT AKUN',
                            style: TextStyle(
                              fontSize: 16 * s,
                              color: ecoGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6 * v),
                          Image.asset(
                            'lib/images/logo_ecowalk_white.png',
                            width: 223 * s,
                            fit: BoxFit.contain,
                            color: ecoGreen,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                place(
                  250,
                  buildField(
                    controller: usernameController,
                    icon: Icons.person,
                    hint: 'Nama Pengguna',
                    height: fieldHeight,
                    s: s,
                  ),
                ),

                place(
                  317,
                  buildField(
                    controller: emailController,
                    icon: Icons.email,
                    hint: 'Email',
                    height: fieldHeight,
                    s: s,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                place(
                  384,
                  buildField(
                    controller: phoneController,
                    icon: Icons.phone,
                    hint: 'Nomor Hp',
                    height: fieldHeight,
                    s: s,
                    keyboardType: TextInputType.phone,
                  ),
                ),

                place(
                  452,
                  buildField(
                    controller: passwordController,
                    icon: Icons.lock,
                    hint: 'Kata Sandi',
                    height: fieldHeight,
                    s: s,
                    obscure: hidePassword,
                    suffix: buildEyeButton(
                      hidden: hidePassword,
                      s: s,
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                ),

                place(
                  519,
                  buildField(
                    controller: confirmPasswordController,
                    icon: Icons.lock,
                    hint: 'Konfirmasi Kata Sandi',
                    height: fieldHeight,
                    s: s,
                    obscure: hideConfirmPassword,
                    suffix: buildEyeButton(
                      hidden: hideConfirmPassword,
                      s: s,
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                place(
                  592,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.9 * s,
                        child: Checkbox(
                          value: agree,
                          activeColor: ecoGreen,
                          side: const BorderSide(
                            color: Colors.black45,
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            setState(() {
                              agree = value ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8 * s),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Saya telah membaca dan menyetujui ',
                                style: TextStyle(
                                  fontSize: 11.5 * s,
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: 'persyaratan dan\nprivasi pengguna',
                                style: TextStyle(
                                  fontSize: 11.5 * s,
                                  color: linkBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                place(
                  655,
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
                      onPressed: register,
                      child: Text(
                        'BUAT AKUN',
                        style: TextStyle(
                          fontSize: 12 * s,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                place(
                  726,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          fontSize: 11 * s,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(width: 4 * s),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Masuk',
                          style: TextStyle(color: linkBlue, fontSize: 11 * s),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 4. VERIFICATION PAGE
// ====================================================
