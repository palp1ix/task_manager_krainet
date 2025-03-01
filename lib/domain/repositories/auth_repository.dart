import 'package:firebase_auth/firebase_auth.dart';

// FIXME: Domain layer should not depend on UserCredential Firebase class
abstract interface class AuthRepository {
  Future<UserCredential> login(String email, String password);
}
