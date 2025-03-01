import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/add_new_task_button.dart';

class TaskTopBar extends StatelessWidget {
  const TaskTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryName = context.read<String>();

    return Padding(
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
    );
  }
}
