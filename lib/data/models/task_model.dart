import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Task {
  TaskModel(
      {required super.title,
      required super.description,
      required super.date,
      required super.isCompleted,
      required super.category});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
