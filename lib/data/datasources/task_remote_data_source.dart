import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/core/utils/utils.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

/// Interface defining the operations for interacting with task data in remote storage.
abstract interface class TaskRemoteDataSource {
  /// Saves a new task to the remote database.
  ///
  /// Returns the document ID of the newly created task.
  Future<String> saveTask(TaskModel task);

  /// Retrieves tasks from the remote database filtered by category.
  ///
  /// [category] determines which tasks to retrieve.
  /// Returns a list of [TaskModel] objects.
  Future<List<TaskModel>> getTasks(TaskCategory category);

  /// Updates an existing task in the remote database.
  ///
  /// Returns a boolean indicating whether the update was successful.
  Future<bool> updateTask(TaskModel task);

  /// Deletes a task from the remote database by its ID.
  ///
  /// [id] is the document ID of the task to delete.
  Future<void> deleteTask(String id);
}

/// Implementation of [TaskRemoteDataSource] using Firebase Cloud Firestore.
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  /// Firestore instance for database operations
  final firestore = FirebaseFirestore.instance;

  /// Firebase Auth instance for user authentication
  final firebaseAuth = FirebaseAuth.instance;

  /// Collection reference for tasks
  late final CollectionReference tasksCollection;

  TaskRemoteDataSourceImpl() {
    // We'll initialize the collection reference dynamically for each operation
    // to ensure we're always using the current user's collection
  }

  /// Gets the user-specific tasks collection reference
  /// Throws UnauthorizedException if no user is authenticated
  CollectionReference _getUserTasksCollection() {
    final user = firebaseAuth.currentUser;
    if (user == null || user.uid.isEmpty) {
      throw UnauthorizedException('User is not authenticated');
    }

    return firestore.collection('users').doc(user.uid).collection('tasks');
  }

  @override
  Future<String> saveTask(TaskModel task) async {
    return AppUtils.serverResponseHandler<Future<String>, ServerException>(
      () async {
        try {
          // Get user-specific tasks collection
          final userTasksCollection = _getUserTasksCollection();

          // Use the ID from the task model instead of auto-generating one
          await userTasksCollection.doc(task.id).set(task.toJson());

          // Return the task's ID
          return task.id;
        } catch (e) {
          if (e is UnauthorizedException) {
            rethrow;
          }
          throw ServerException(e.toString());
        }
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }

  @override
  Future<List<TaskModel>> getTasks(TaskCategory category) async {
    return AppUtils.serverResponseHandler<Future<List<TaskModel>>,
        ServerException>(
      () async {
        try {
          // Get user-specific tasks collection
          final userTasksCollection = _getUserTasksCollection();

          QuerySnapshot querySnapshot;

          // For the 'all' category, return all tasks without filtering
          if (category == TaskCategory.all) {
            querySnapshot = await userTasksCollection.get();
          }
          // For the 'completed' category, return all tasks that are marked as completed
          else if (category == TaskCategory.completed) {
            querySnapshot = await userTasksCollection
                .where('isCompleted', isEqualTo: 1)
                .get();
          }
          // For all other categories, return tasks matching that category
          else {
            querySnapshot = await userTasksCollection
                .where('category', isEqualTo: category.identifier)
                .get();
          }

          // Convert Firestore documents to TaskModel objects
          return querySnapshot.docs.map((doc) {
            // Combine document data with its ID
            final data = {
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            };
            return TaskModel.fromJson(data);
          }).toList();
        } catch (e) {
          if (e is UnauthorizedException) {
            rethrow;
          }
          throw ServerException(e.toString());
        }
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }

  @override
  Future<bool> updateTask(TaskModel task) async {
    return AppUtils.serverResponseHandler<Future<bool>, ServerException>(
      () async {
        try {
          // Get user-specific tasks collection
          final userTasksCollection = _getUserTasksCollection();

          // Convert task to JSON and update in Firestore
          await userTasksCollection.doc(task.id).update(task.toJson());
          return true;
        } catch (e) {
          if (e is UnauthorizedException) {
            rethrow;
          }
          throw ServerException(e.toString());
        }
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    return AppUtils.serverResponseHandler<Future<void>, ServerException>(
      () async {
        try {
          // Get user-specific tasks collection
          final userTasksCollection = _getUserTasksCollection();

          // Delete the document with the given ID
          await userTasksCollection.doc(id).delete();
        } catch (e) {
          if (e is UnauthorizedException) {
            rethrow;
          }
          throw ServerException(e.toString());
        }
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }
}
