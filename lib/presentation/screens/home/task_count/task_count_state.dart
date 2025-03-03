import 'package:equatable/equatable.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

/// Base state class for the TaskCountBloc
abstract class TaskCountState extends Equatable {
  const TaskCountState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any task counts are loaded
class TaskCountInitial extends TaskCountState {
  const TaskCountInitial();
}

/// State while task counts are being loaded
class TaskCountLoading extends TaskCountState {
  const TaskCountLoading();
}

/// State representing successful loading of task counts
class TaskCountLoaded extends TaskCountState {
  final Map<TaskCategory, int> categoryCounts;

  const TaskCountLoaded(this.categoryCounts);

  @override
  List<Object?> get props => [categoryCounts];
}

/// State representing failure during task count loading
class TaskCountError extends TaskCountState {
  final String message;

  const TaskCountError(this.message);

  @override
  List<Object?> get props => [message];
}