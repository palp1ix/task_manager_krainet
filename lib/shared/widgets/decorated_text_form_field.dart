import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DecoratedTextFormField extends StatelessWidget {
  const DecoratedTextFormField(
      {super.key,
      required this.controller,
      this.maxLines,
      required this.labelText,
      this.validator});

  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final String Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder().copyWith(
              borderRadius:
                  BorderRadius.circular(AppConstants.inputBorderRadius))),
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
