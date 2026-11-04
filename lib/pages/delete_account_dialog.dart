import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      useSafeArea: false,
      barrierColor: const Color(0x66000000),
      builder: (context) => const DeleteAccountDialog(),
    );
  }

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  static const Color red = Color(0xFFE5252B);
  static const Color lightRed = Color(0xFFFFE5E6);
  static const Color darkText = Color(0xFF2B2B2B);

  // =====================================
  // UKURAN DESAIN
  // =====================================
  static const double _marginH = 20;
  static const double _radius = 14;

  // JARAK DAN PADDING DIALOG
  static const double _padH = 34;
  static const double _padTop = 23;
  static const double _padBottom = 24;

  // JUDUL
  static const double _titleSize = 19;
  static const double _titleToField = 19;

  // INPUT KATA SANDI
  static const double _labelSize = 10.5;
  static const double _inputSize = 12.5;
  static const double _hintSize = 10.5;
  static const double _fieldPadV = 9;
  static const double _eyeSize = 21;
  static const double _borderWidth = 1.8;

  // PERINGATAN
  static const double _fieldToWarn = 14;
  static const double _warnSize = 9;
  static const double _warnPadH = 8;
  static const double _warnPadV = 9;
  static const double _warnIcon = 16;
  static const double _closeIcon = 13;

  // TOMBOL
  static const double _warnToBtn = 24;
  static const double _btnW = 88;
  static const double _btnH = 34;
  static const double _btnFont = 15;
  static const double _btnGap = 24;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // =====================================
  // VALIDASI HAPUS AKUN
  // =====================================
  void _deleteAccount() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    Navigator.of(context).pop();

    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Validasi berhasil. Penghapusan akun memerlukan backend.',
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // =====================================
  // BORDER INPUT
  // =====================================
  OutlineInputBorder _border(double scale, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(2 * scale),
      borderSide: BorderSide(color: red, width: width * scale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final double scale = (media.size.width / 390).clamp(0.8, 1.2).toDouble();
    final double topOffset = 240 * scale;

    return MediaQuery(
      data: media.copyWith(textScaler: TextScaler.noScaling),
      child: Dialog(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.fromLTRB(
          _marginH * scale,
          topOffset,
          _marginH * scale,
          16 * scale,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius * scale),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              _padH * scale,
              _padTop * scale,
              _padH * scale,
              _padBottom * scale,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // =====================================
                  // JUDUL HAPUS AKUN
                  // =====================================
                  Text(
                    'HAPUS AKUN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _titleSize * scale,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: _titleToField * scale),

                  // =====================================
                  // INPUT KATA SANDI
                  // =====================================
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    obscuringCharacter: '•',
                    autocorrect: false,
                    enableSuggestions: false,
                    style: TextStyle(
                      fontSize: _inputSize * scale,
                      color: darkText,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kata sandi wajib diisi';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        fontSize: (_labelSize / 0.75) * scale,
                        color: darkText,
                        fontWeight: FontWeight.w700,
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: (_labelSize / 0.75) * scale,
                        color: darkText,
                        fontWeight: FontWeight.w700,
                      ),
                      hintText: 'Masukan Kata Sandi',
                      hintStyle: TextStyle(
                        fontSize: _hintSize * scale,
                        color: const Color(0xFF999999),
                        fontWeight: FontWeight.w400,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 10 * scale,
                        color: red,
                        fontWeight: FontWeight.w500,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12 * scale,
                        vertical: _fieldPadV * scale,
                      ),

                      // IKON MATA KANAN
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 35 * scale,
                        minHeight: 34 * scale,
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: 35 * scale,
                          minHeight: 34 * scale,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: darkText,
                          size: _eyeSize * scale,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: _border(scale, _borderWidth),
                      enabledBorder: _border(scale, _borderWidth),
                      focusedBorder: _border(scale, 2),
                      errorBorder: _border(scale, _borderWidth),
                      focusedErrorBorder: _border(scale, 2),
                    ),
                  ),

                  SizedBox(height: _fieldToWarn * scale),

                  // =====================================
                  // KOTAK PERINGATAN MERAH MUDA
                  // =====================================
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: _warnPadH * scale,
                      vertical: _warnPadV * scale,
                    ),
                    decoration: BoxDecoration(
                      color: lightRed,
                      borderRadius: BorderRadius.circular(2 * scale),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: red,
                          size: _warnIcon * scale,
                        ),

                        SizedBox(width: 6 * scale),

                        Expanded(
                          child: Text(
                            'Anda akan menghapus akun anda. '
                            'Tindakan ini tidak dapat dibatalkan. '
                            'Semua data akan hilang.',
                            style: TextStyle(
                              fontSize: _warnSize * scale,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                              color: darkText,
                            ),
                          ),
                        ),

                        SizedBox(width: 3 * scale),

                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(3 * scale),
                            child: Icon(
                              Icons.close,
                              size: _closeIcon * scale,
                              color: const Color(0xFF777777),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: _warnToBtn * scale),

                  // =====================================
                  // TOMBOL HAPUS DAN BATAL
                  // =====================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TOMBOL HAPUS
                      SizedBox(
                        width: _btnW * scale,
                        height: _btnH * scale,
                        child: ElevatedButton(
                          onPressed: _deleteAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3 * scale),
                            ),
                          ),
                          child: Text(
                            'Hapus',
                            style: TextStyle(
                              fontSize: _btnFont * scale,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: _btnGap * scale),

                      // TOMBOL BATAL
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: darkText,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8 * scale,
                            vertical: 4 * scale,
                          ),
                          minimumSize: Size(45 * scale, _btnH * scale),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            fontSize: _btnFont * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
