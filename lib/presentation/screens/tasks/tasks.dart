import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/add_new_task_button.dart';

@RoutePage(name: 'TasksScreenRoute')
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Provider<String>.value(
      value: categoryName,
      child: Scaffold(
          body: SafeArea(
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
      ))),
    );
  }
}
