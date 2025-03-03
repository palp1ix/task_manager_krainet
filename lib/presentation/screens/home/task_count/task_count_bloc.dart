import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/domain/usecases/count_tasks_by_category.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_event.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_state.dart';

/// BLoC for handling task count operations
///
/// This bloc manages the state related to task counts for each category
/// and provides methods to load counts for all categories or a specific one
class TaskCountBloc extends Bloc<TaskCountEvent, TaskCountState> {
  final CountTasksByCategory _countTasksByCategory;

  /// Constructor requiring the CountTasksByCategory use case
  TaskCountBloc({
    required CountTasksByCategory countTasksByCategory,
  })  : _countTasksByCategory = countTasksByCategory,
        super(const TaskCountInitial()) {
    on<LoadTaskCounts>(_onLoadTaskCounts);
    on<LoadTaskCountForCategory>(_onLoadTaskCountForCategory);
  }

  /// Handles the LoadTaskCounts event to fetch counts for all categories
  ///
  /// For web, it will use remote data source
  /// For mobile, it will use local data source (this behavior is managed by the repository)
  Future<void> _onLoadTaskCounts(
    LoadTaskCounts event,
    Emitter<TaskCountState> emit,
  ) async {
    try {
      emit(const TaskCountLoading());

      final categoryCounts = <TaskCategory, int>{};

      // Load counts for all relevant categories
      for (final category in [
        TaskCategory.all,
        TaskCategory.today,
        TaskCategory.work,
        TaskCategory.personal,
        TaskCategory.completed,
      ]) {
        final count = await _countTasksByCategory(category);
        categoryCounts[category] = count;
      }

      emit(TaskCountLoaded(categoryCounts));
    } catch (e) {
      emit(TaskCountError(e.toString()));
    }
  }

  /// Handles the LoadTaskCountForCategory event to fetch count for a specific category
  Future<void> _onLoadTaskCountForCategory(
    LoadTaskCountForCategory event,
    Emitter<TaskCountState> emit,
  ) async {
    try {
      // If we're already in a loaded state, keep the existing counts
      // while loading the new one
      final existingCounts = state is TaskCountLoaded
          ? Map<TaskCategory, int>.from(
              (state as TaskCountLoaded).categoryCounts)
          : <TaskCategory, int>{};

      emit(const TaskCountLoading());

      final count = await _countTasksByCategory(event.category);
      existingCounts[event.category] = count;

      emit(TaskCountLoaded(existingCounts));
    } catch (e) {
      emit(TaskCountError(e.toString()));
    }
  }
}
