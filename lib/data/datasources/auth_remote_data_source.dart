import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> loginWithEmailPassword(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredentials;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message);
    }
  }
}
