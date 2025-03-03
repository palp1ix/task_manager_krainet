import 'package:equatable/equatable.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

/// Base event class for TaskCountBloc
abstract class TaskCountEvent extends Equatable {
  const TaskCountEvent();

  @override
  List<Object?> get props => [];
}

/// Event to trigger loading task counts for all categories
class LoadTaskCounts extends TaskCountEvent {
  const LoadTaskCounts();
}

/// Event to trigger loading task count for a specific category
class LoadTaskCountForCategory extends TaskCountEvent {
  final TaskCategory category;

  const LoadTaskCountForCategory(this.category);

  @override
  List<Object?> get props => [category];
}