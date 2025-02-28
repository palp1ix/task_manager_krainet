import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/tasks_page.dart';

@RoutePage(name: 'TasksScreenRoute')
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
        value: categoryName,
        child: Scaffold(
          body: TasksPage(),
        ));
  }
}
