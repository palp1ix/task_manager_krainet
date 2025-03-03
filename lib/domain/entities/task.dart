import 'package:equatable/equatable.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  Task({
    String? id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.isCompleted,
    // We should generate id if id equal null
  }) : id = id ?? Uuid().v4();

  final String id;
  final String title;
  final String description;
  final TaskCategory category;
  final DateTime date;
  final bool isCompleted;

  @override
  List<Object?> get props =>
      [id, title, description, category, date, isCompleted];
}
