import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/services/notification_service.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/usecases/get_task_list.dart';
import 'package:task_manager_krainet/domain/usecases/update_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTaskList getTaskList;
  final UpdateTask updateTaskUseCase;
  final NotificationService _notificationService = NotificationService.instance;

  TaskBloc({
    required this.getTaskList,
    required this.updateTaskUseCase,
  }) : super(TaskInitial()) {
    on<GetTaskEvent>(_onGetTask);
    on<UpdateTaskCompletionEvent>(_onUpdateTaskCompletion);
  }

  FutureOr<void> _onGetTask(GetTaskEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskInProgress());
      final params = GetTaskListParams(category: event.category);
      final taskList = await getTaskList(params);
      emit(TaskSuccess(taskList));
    } catch (e) {
      emit(TaskFailed());
    }
  }

  FutureOr<void> _onUpdateTaskCompletion(
      UpdateTaskCompletionEvent event, Emitter<TaskState> emit) async {
    try {
      final currentState = state;
      if (currentState is TaskSuccess) {
        // Create a new task with toggled completion status
        final Task updatedTask = Task(
          id: event.task.id,
          title: event.task.title,
          description: event.task.description,
          category: event.task.category,
          date: event.task.date,
          isCompleted: !event.task.isCompleted,
        );

        final params = UpdateTaskParams(updatedTask);
        // Update in database
        await updateTaskUseCase(params);

        // Handle notifications based on completion status
        if (updatedTask.isCompleted) {
          // Task is now completed, cancel any scheduled notification
          await _notificationService.cancelTaskNotification(updatedTask);
        } else {
          // Task is now uncompleted, schedule a notification if the date is in the future
          final now = DateTime.now();
          if (updatedTask.date.isAfter(now)) {
            await _notificationService.scheduleTaskNotification(updatedTask);
          }
        }

        // Update the task list in the state
        final List<Task> updatedTasks = List<Task>.from(currentState.tasks)
            .map((task) => task.id == updatedTask.id ? updatedTask : task)
            .toList();

        emit(TaskSuccess(updatedTasks));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskFailed());
    }
  }
}
