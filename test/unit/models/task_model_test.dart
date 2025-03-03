import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
// import 'package:task_manager_krainet/data/models/task_model.dart';

void main() {
  final testTaskModel = TaskModel(
    id: '1',
    category: TaskCategory.completed,
    title: 'Test Task',
    description: 'Test Description',
    isCompleted: false,
    date: DateTime(2024, 3, 1),
  );

  group('TaskModel', () {
    test('should be a subclass of Task entity', () {
      // TODO: Implement when TaskModel is accessible
      expect(testTaskModel, isA<Task>());
    });

    test('should create TaskModel from JSON', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'title': 'Test Task',
        'description': 'Test Description',
        'completed': false,
        'createdAt': '2024-03-01T00:00:00.000Z',
        'updatedAt': '2024-03-01T00:00:00.000Z',
      };

      // Act
      final result = TaskModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(testTaskModel));
    });

    test('should convert TaskModel to JSON', () {
      // Arrange
      final expectedJsonMap = {
        'id': '1',
        'title': 'Test Task',
        'description': 'Test Description',
        'completed': false,
        'createdAt': '2024-03-01T00:00:00.000Z',
        'updatedAt': '2024-03-01T00:00:00.000Z',
      };

      // Act
      final result = testTaskModel.toJson();

      // Assert
      expect(result, equals(expectedJsonMap));
    });

    test('should validate required fields', () {
      // Arrange
      final invalidJson = {
        'id': '1',
        'completed': false,
      };

      // Act & Assert
      expect(
        () => TaskModel.fromJson(invalidJson),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
