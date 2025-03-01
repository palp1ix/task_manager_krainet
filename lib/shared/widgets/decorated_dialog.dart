import 'package:flutter/material.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';

Future<dynamic> showProgressIndicatorDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.progressIndicator,
        ),
      );
    },
  );
}
