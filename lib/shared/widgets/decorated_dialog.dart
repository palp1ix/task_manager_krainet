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

class DecoratedDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const DecoratedDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
