import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/exeptions/exteptions.dart';
import 'package:task_manager_krainet/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  AuthBloc(this.signIn) : super(Unauthorized()) {
    on<AuthLogin>(_onLogin);
  }

  FutureOr<void> _onLogin(event, emit) async {
    emit(AuthInProgress());
    try {
      final params = SignInParams(email: event.email, password: event.password);
      final userCredentials = await signIn(params);
      final user = userCredentials.user;

      // User presence check
      if (userCredentials.user == null) {
        throw Failure(message: 'User credentials does not contain user');
      } else {
        emit(Authorized(user!));
      }
    } catch (e) {
      emit(AuthFailed());
    }
  }
}
