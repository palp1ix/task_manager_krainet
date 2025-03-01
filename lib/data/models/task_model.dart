import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  TaskModel(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isCompleted,
      required this.category});

  final int? id;
  final String title;
  final String description;
  final DateTime date;
  @BoolIntConverter()
  final bool isCompleted;
  final String category;

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
