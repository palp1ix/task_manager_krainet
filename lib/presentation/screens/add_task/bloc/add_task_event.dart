part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateTask extends AddTaskEvent {
  CreateTask(
      {required this.title,
      required this.description,
      required this.category,
      required this.date,
      required this.isCompleted});

  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool isCompleted;
}
