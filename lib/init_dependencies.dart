import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_krainet/data/datasources/task_remote_data_source.dart';
import 'package:task_manager_krainet/domain/usecases/count_tasks_by_category.dart';
import 'package:task_manager_krainet/domain/usecases/delete_task.dart';
import 'package:task_manager_krainet/domain/usecases/sign_up.dart';
import 'package:task_manager_krainet/presentation/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/data/datasources/auth_remote_data_source.dart';
import 'package:task_manager_krainet/data/datasources/task_local_data_source.dart';
import 'package:task_manager_krainet/data/repositories/auth_repository_impl.dart';
import 'package:task_manager_krainet/data/repositories/task_repository_impl.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';
import 'package:task_manager_krainet/domain/usecases/add_task.dart';
import 'package:task_manager_krainet/domain/usecases/get_task_list.dart';
import 'package:task_manager_krainet/domain/usecases/log_out.dart';
import 'package:task_manager_krainet/domain/usecases/sign_in.dart';
import 'package:task_manager_krainet/domain/usecases/update_task.dart';
import 'package:task_manager_krainet/firebase_options.dart';
import 'package:task_manager_krainet/core/services/notification_service.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/task_details/bloc/task_details_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notification service
  await NotificationService.instance.init();

  _registerInstances();
}

void _registerInstances() {
  serviceLocator
    // Datasources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    ..registerFactory<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(),
    )
    ..registerFactory<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<TaskRepository>(
      () => TaskRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // Usecases
    ..registerFactory(
      () => SignIn(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => LogOut(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => SignUp(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => AddTask(serviceLocator()),
    )
    ..registerFactory(
      () => GetTaskList(serviceLocator()),
    )
    ..registerFactory(
      () => UpdateTask(serviceLocator()),
    )
    ..registerFactory(
      () => DeleteTask(serviceLocator()),
    )
    ..registerFactory(
      () => CountTasksByCategory(serviceLocator()),
    )
    // Blocs
    ..registerFactory<AuthBloc>(
      () => AuthBloc(serviceLocator(), serviceLocator(), serviceLocator()),
    )
    ..registerLazySingleton(
      () => AddTaskBloc(serviceLocator()),
    )
    ..registerFactory(() => TaskDetailsBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(
      () => TaskBloc(
        getTaskList: serviceLocator(),
        updateTaskUseCase: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => TaskCountBloc(
        countTasksByCategory: serviceLocator(),
      ),
    );
}
