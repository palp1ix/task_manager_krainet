part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class GetTaskEvent extends TaskEvent {
  GetTaskEvent({required this.category});

  final String category;
}

final class UpdateTaskCompletionEvent extends TaskEvent {
  const UpdateTaskCompletionEvent({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}
