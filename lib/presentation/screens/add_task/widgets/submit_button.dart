import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_button.dart';

/// A widget that displays the submit button for the add task form
class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return DecoratedButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        localization.createTask,
        style: theme.textTheme.bodyLarge
            ?.copyWith(color: AppColors.whiteBackground),
      ),
    );
  }
}
