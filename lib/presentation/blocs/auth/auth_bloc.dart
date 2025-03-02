import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/usecases/log_out.dart';
import 'package:task_manager_krainet/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // UseCases
  final SignIn signIn;
  final LogOut logOut;

  AuthBloc(this.signIn, this.logOut) : super(Unauthorized()) {
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  FutureOr<void> _onLogout(event, emit) async {
    emit(AuthInProgress());
    try {
      logOut(NoParams());
      emit(Unauthorized());
    } catch (e) {
      emit(AuthFailed());
    }
  }

  FutureOr<void> _onLogin(event, emit) async {
    emit(AuthInProgress());
    try {
      final params = SignInParams(email: event.email, password: event.password);
      final userCredentials = await signIn(params);
      final user = userCredentials.user;

      // User presence check
      if (userCredentials.user == null) {
        throw EmptyStateException('User credentials does not contain user');
      } else {
        emit(Authorized(user!));
      }
    } catch (e) {
      emit(AuthFailed());
    }
  }
}
