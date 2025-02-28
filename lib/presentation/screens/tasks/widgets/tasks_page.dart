import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/add_new_task_button.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryName;

    categoryName = Provider.of<String>(context);

    final theme = Theme.of(context);

    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: AppConstants.topInset),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButton(),
              SizedBox(width: 5),
              Text(categoryName,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 24)),
              Spacer(),
              AddNewTaskButton()
            ],
          ),
        )
      ],
    ));
  }
}
