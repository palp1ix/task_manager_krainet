import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isCompleted,
      required this.category});

  final String id;
  final String title;
  final String description;
  final DateTime date;
  @BoolIntConverter()
  final bool isCompleted;
  @TaskCategoryConverter()
  final TaskCategory category;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}

class BoolIntConverter implements JsonConverter<bool, int> {
  const BoolIntConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}

/// Converts TaskCategory enum to and from strings for JSON serialization
///
/// This allows storing the category in a language-independent way in the database
/// while still using the enum type in the application code.
class TaskCategoryConverter implements JsonConverter<TaskCategory, String> {
  const TaskCategoryConverter();

  @override
  TaskCategory fromJson(String json) {
    // Convert the stored string identifier to the corresponding TaskCategory
    return TaskCategory.fromString(json);
  }

  @override
  String toJson(TaskCategory object) {
    // Store the enum's identifier (name) in the database
    return object.identifier;
  }
}
