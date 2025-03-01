import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_krainet/core/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/data/datasources/auth_remote_data_source.dart';
import 'package:task_manager_krainet/data/repositories/auth_repository_impl.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';
import 'package:task_manager_krainet/domain/usecases/sign_in.dart';
import 'package:task_manager_krainet/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _initAuth();
}

void _initAuth() {
  serviceLocator
    // Datasources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(
      () => SignIn(serviceLocator()),
    )
    // Blocs
    ..registerFactory<AuthBloc>(
      () => AuthBloc(serviceLocator()),
    );
}
