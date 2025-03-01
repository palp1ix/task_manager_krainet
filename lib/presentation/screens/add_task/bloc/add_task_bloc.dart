import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/services/notification_service.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/usecases/add_task.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTask addTask;
  final NotificationService _notificationService = NotificationService.instance;
  
  AddTaskBloc(this.addTask) : super(AddTaskInitial()) {
    on<CreateTask>((event, emit) async {
      emit(AddTaskInProgress());
      try {
        // Create task entity from event field
        final task = Task(
          title: event.title,
          description: event.description,
          category: event.category,
          date: event.date,
          isCompleted: event.isCompleted,
        );
        // Create params for usecase using
        final params = AddTaskParams(task: task);
        // Call usecase
        await addTask(params);
        
        // Schedule a notification for the task at its due date
        // Only schedule if the task is not already completed
        if (!task.isCompleted) {
          await _notificationService.scheduleTaskNotification(task);
        }
        
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskFailed());
      }
    });
  }
}
