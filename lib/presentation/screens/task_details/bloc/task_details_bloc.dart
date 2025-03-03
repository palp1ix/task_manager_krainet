import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/usecases/delete_task.dart';
import 'package:task_manager_krainet/domain/usecases/update_task.dart';

part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskDetailsBloc(this.updateTask, this.deleteTask)
      : super(TaskDetailsInitial()) {
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  FutureOr<void> _onUpdateTask(event, emit) async {
    try {
      emit(TaskDetailsInProgress());
      final params = UpdateTaskParams(event.task);
      await updateTask(params);
      emit(TaskDetailsSuccess());
    } catch (e) {
      emit(TaskDetailsError());
    }
  }

  FutureOr<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskDetailsState> emit) async {
    try {
      emit(TaskDetailsInProgress());
      // Null sufety, now in this moment id should exist
      // Because we add id to model after creation
      final params = DeleteParams(event.task.id);
      await deleteTask(params);
      emit(TaskDetailsSuccess());
    } catch (e) {
      emit(TaskDetailsError());
    }
  }
}
