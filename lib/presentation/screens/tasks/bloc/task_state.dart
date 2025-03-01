part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskInProgress extends TaskState {}

final class TaskFailed extends TaskState {}

final class TaskSuccess extends TaskState {
  const TaskSuccess(this.tasks);

  final List<Task> tasks;

  // It's very important because without that flitter
  // wouldn't update screen after checkBox changed state
  @override
  List<Object> get props => [tasks];
}
