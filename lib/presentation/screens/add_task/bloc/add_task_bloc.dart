import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/usecases/add_task.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTask addTask;
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
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskFailed());
      }
    });
  }
}
