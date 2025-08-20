import 'package:flutter/material.dart';
import 'package:influeconnect/utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.creamWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.lightBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.lightBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.mediumBrown, width: 2),
        ),
        labelStyle: const TextStyle(color: AppTheme.textLight),
        hintStyle: const TextStyle(color: AppTheme.textLight),
        errorStyle: const TextStyle(color: AppTheme.errorRed),
      ),
    );
  }
}