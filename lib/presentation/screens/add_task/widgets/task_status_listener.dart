import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';

/// A widget that listens to the task status changes and shows appropriate UI feedback
/// Used to handle loading, success, and error states when creating a task
class TaskStatusListener extends StatelessWidget {
  final Widget child;

  const TaskStatusListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskInProgress) {
          showProgressIndicatorDialog(context);
        } else if (state is AddTaskFailed) {
          // Close progress dialog
          Navigator.of(context).pop();

          // Show message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(localization.errorMessage),
            ),
          );
        } else if (state is AddTaskSuccess) {
          // Return to tasks page
          context.router.back();
          // Show message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text(localization.taskCreated),
            ),
          );
        }
      },
      child: child,
    );
  }
}