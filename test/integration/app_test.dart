import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_manager_krainet/main.dart' as app;

void main() {
  // Initialize integration test framework
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end tests', () {
    testWidgets('Full task creation and completion flow', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Login flow (assuming app starts with login screen)
      await _loginFlow(tester);

      // Navigate to tasks screen (if not automatically navigated after login)
      await _navigateToTasksScreen(tester);

      // Create a new task
      await _createNewTask(tester, 'Integration Test Task');

      // Verify task was created and appears in the list
      expect(find.text('Integration Test Task'), findsOneWidget);

      // Complete the task
      await _completeTask(tester, 'Integration Test Task');

      // Verify task is marked as completed
      final completedTaskFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == 'Integration Test Task' &&
          widget.style?.decoration == TextDecoration.lineThrough);
      expect(completedTaskFinder, findsOneWidget);

      // Delete the task
      // await _deleteTask(tester, 'Integration Test Task');

      // Verify task was deleted
      expect(find.text('Integration Test Task'), findsNothing);
    });

    testWidgets('Filter tasks flow', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Login if needed
      await _loginFlow(tester);

      // Navigate to tasks screen
      await _navigateToTasksScreen(tester);

      // Create multiple tasks with different statuses
      await _createNewTask(tester, 'Active Task 1');
      await _createNewTask(tester, 'Active Task 2');
      await _createNewTask(tester, 'Task To Complete');

      // Complete one task
      await _completeTask(tester, 'Task To Complete');

      // Apply filter for active tasks
      await _filterTasks(tester, 'Active');

      // Verify only active tasks are visible
      expect(find.text('Active Task 1'), findsOneWidget);
      expect(find.text('Active Task 2'), findsOneWidget);
      expect(find.text('Task To Complete'), findsNothing);

      // Apply filter for completed tasks
      await _filterTasks(tester, 'Completed');

      // Verify only completed tasks are visible
      expect(find.text('Active Task 1'), findsNothing);
      expect(find.text('Active Task 2'), findsNothing);
      expect(find.text('Task To Complete'), findsOneWidget);

      // Reset filter
      await _filterTasks(tester, 'All');

      // Verify all tasks are visible
      expect(find.text('Active Task 1'), findsOneWidget);
      expect(find.text('Active Task 2'), findsOneWidget);
      expect(find.text('Task To Complete'), findsOneWidget);

      // Clean up created tasks
      await _deleteTask(tester, 'Active Task 1');
      await _deleteTask(tester, 'Active Task 2');
      await _deleteTask(tester, 'Task To Complete');
    });
  });
}

// Helper functions for common test flows

Future<void> _loginFlow(WidgetTester tester) async {
  // Find email and password fields and enter credentials
  await tester.enterText(
      find.byKey(const Key('email_field')), 'test@example.com');
  await tester.enterText(
      find.byKey(const Key('password_field')), 'password123');

  // Tap login button
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
}

Future<void> _navigateToTasksScreen(WidgetTester tester) async {
  // Tap on tasks navigation item if needed
  final tasksNavItem = find.byKey(const Key('tasks_nav_item'));
  if (tasksNavItem.evaluate().isNotEmpty) {
    await tester.tap(tasksNavItem);
    await tester.pumpAndSettle();
  }
}

Future<void> _createNewTask(WidgetTester tester, String taskName) async {
  // Tap on add task button
  await tester.tap(find.byKey(const Key('add_task_button')));
  await tester.pumpAndSettle();

  // Enter task name
  await tester.enterText(find.byKey(const Key('task_name_field')), taskName);

  // Submit new task
  await tester.tap(find.byKey(const Key('submit_task_button')));
  await tester.pumpAndSettle();
}

Future<void> _completeTask(WidgetTester tester, String taskName) async {
  // Find the task and tap on its checkbox
  final taskItem = find.ancestor(
    of: find.text(taskName),
    matching: find.byType(ListTile),
  );
  final checkbox = find.descendant(
    of: taskItem,
    matching: find.byType(Checkbox),
  );
  await tester.tap(checkbox);
  await tester.pumpAndSettle();
}

Future<void> _deleteTask(WidgetTester tester, String taskName) async {
  // Find the task and swipe to delete or tap delete button
  final taskItem = find.ancestor(
    of: find.text(taskName),
    matching: find.byType(Dismissible),
  );
  await tester.drag(taskItem, const Offset(-500, 0)); // Swipe left to delete
  await tester.pumpAndSettle();
}

Future<void> _filterTasks(WidgetTester tester, String filterType) async {
  // Tap filter button
  await tester.tap(find.byKey(const Key('filter_button')));
  await tester.pumpAndSettle();

  // Select filter type
  await tester.tap(find.text(filterType));
  await tester.pumpAndSettle();
}
