import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';

/// A widget containing the title and description form fields
/// Used in the add task screen for task information input
class TaskFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const TaskFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        // Title input
        DecoratedTextFormField(
          controller: titleController,
          labelText: localization.title,
        ),
        const SizedBox(height: 16),

        // Description input
        DecoratedTextFormField(
          controller: descriptionController,
          labelText: localization.description,
          maxLines: 3,
        ),
      ],
    );
  }
}