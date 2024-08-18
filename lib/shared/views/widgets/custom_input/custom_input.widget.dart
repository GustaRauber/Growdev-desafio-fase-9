import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final int _maxLines;
  final bool _isPassword;
  final bool _obscureText;
  final Function? _onPressedSufixIcon;

  const CustomInput({
    super.key,
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool isPassword = false,
    bool obscureText = false,
    Function? onPressedSufixIcon,
  })  : _controller = controller,
        _label = label,
        _maxLines = maxLines,
        _isPassword = isPassword,
        _obscureText = obscureText,
        _onPressedSufixIcon = onPressedSufixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _label,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: buildSufixIcon(),
      ),
      cursorColor: Colors.black,
      maxLines: _maxLines,
      obscureText: !_obscureText,
    );
  }

  Widget? buildSufixIcon() {
    if (!_isPassword) return null;

    return IconButton(
      onPressed:
          _onPressedSufixIcon != null ? () => _onPressedSufixIcon!() : null,
      icon: Icon(
        !_obscureText ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}
