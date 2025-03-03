import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DecoratedTextFormField extends StatelessWidget {
  const DecoratedTextFormField(
      {super.key,
      required this.controller,
      this.maxLines,
      this.labelText,
      this.validator,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.obscureText = false});

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // Remove all borders but keep the shape
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: maxLines ?? 1,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return localization.enterText;
            }
            return null;
          },
    );
  }
}
