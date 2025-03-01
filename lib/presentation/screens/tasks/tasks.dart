import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/task_list_item.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/task_top_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage(name: 'TasksScreenRoute')
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    // Init bloc
    _taskBloc = context.read<TaskBloc>();
    // Get all tasks for this category
    _taskBloc.add(GetTaskEvent(category: widget.categoryName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Provider<String>.value(
      value: widget.categoryName,
      child: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          SizedBox(height: AppConstants.topInset),
          TaskTopBar(),
          BlocBuilder<TaskBloc, TaskState>(
              bloc: _taskBloc,
              builder: (context, state) {
                if (state is TaskSuccess) {
                  final tasks = state.tasks;
                  return Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskListItem(
                                key: ValueKey(task.id),
                                task: task,
                                onCheckBoxChanged: (bool? value) {
                                  // Dispatch event to update completion status
                                  _taskBloc.add(
                                    UpdateTaskCompletionEvent(task: task),
                                  );
                                },
                              );
                            })
                      ],
                    ),
                  );
                } else if (state is TaskInProgress) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else {
                  // Just empty list of items if failure
                  return SizedBox.shrink();
                }
              }),
        ],
      ))),
    );
  }
}
