part of 'task_details_bloc.dart';

sealed class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateTaskEvent extends TaskDetailsEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

final class DeleteTaskEvent extends TaskDetailsEvent {
  const DeleteTaskEvent(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}
