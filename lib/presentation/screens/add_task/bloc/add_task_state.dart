part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskFailed extends AddTaskState {}

final class AddTaskInProgress extends AddTaskState {}

final class AddTaskInitial extends AddTaskState {}
