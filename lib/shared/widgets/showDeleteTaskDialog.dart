// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';

void showDeleteTaskDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  final localization = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DecoratedDialog(
        title: Text(
          localization.deleteTaskConfirmation,
          style: theme.textTheme.titleMedium,
        ),
        content: Text(
          localization.deleteTaskConfirmationMessage,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              localization.cancel,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            child: Text(
              localization.delete,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      );
    },
  );
}
