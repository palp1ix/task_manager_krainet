import 'package:equatable/equatable.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

class Task extends Equatable {
  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.isCompleted,
  });

  final int? id;
  final String title;
  final String description;
  final TaskCategory category;
  final DateTime date;
  final bool isCompleted;

  @override
  List<Object?> get props =>
      [id, title, description, category, date, isCompleted];
}
