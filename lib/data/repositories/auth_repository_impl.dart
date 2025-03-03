import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/data/datasources/auth_remote_data_source.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remoteDataSource);

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<UserCredential> login(String email, String password) async {
    final userCredentials =
        await remoteDataSource.loginWithEmailPassword(email, password);
    return userCredentials;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<UserCredential> register(String email, String password) async {
    final userCredentials =
        await remoteDataSource.registerWithEmailPassword(email, password);
    return userCredentials;
  }
}
