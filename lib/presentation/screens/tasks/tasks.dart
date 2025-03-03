import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/utils/utils.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/task_details/bloc/task_details_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/task_list_item.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/widgets/task_top_bar.dart';

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

  Widget _buildTasksList(BuildContext context, List<Task> tasks) {
    final isBigScreen = AppUtils.isBigScreen(context);

    if (isBigScreen) {
      // Use GridView with 2 columns for big screens
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            mainAxisExtent: 120, // Fixed height for each task card
          ),
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
          },
        ),
      );
    } else {
      // Use ListView for small screens
      return CustomScrollView(
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
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Bloc to bloc communication via presentation layer
    // Multi bloc listener needed for checking updates
    // like updating, deleting task etc.
    return MultiBlocListener(
      listeners: [
        BlocListener<AddTaskBloc, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccess) {
              _taskBloc.add(GetTaskEvent(category: widget.categoryName));
            }
          },
        ),
        BlocListener<TaskDetailsBloc, TaskDetailsState>(
          listener: (context, state) {
            if (state is TaskDetailsSuccess) {
              _taskBloc.add(GetTaskEvent(category: widget.categoryName));
            }
          },
        )
      ],
      child: Provider<String>.value(
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
                      child: _buildTasksList(context, tasks),
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
      ),
    );
  }
}
