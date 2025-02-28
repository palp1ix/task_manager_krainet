// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:task_manager_krainet/presentation/screens/add_task/add_task.dart'
    as _i1;
import 'package:task_manager_krainet/presentation/screens/home/home.dart'
    as _i2;
import 'package:task_manager_krainet/presentation/screens/login/login.dart'
    as _i3;
import 'package:task_manager_krainet/presentation/screens/registration/registration.dart'
    as _i4;
import 'package:task_manager_krainet/presentation/screens/tasks/tasks.dart'
    as _i5;

/// generated route for
/// [_i1.AddTaskScreen]
class AddTaskRoute extends _i6.PageRouteInfo<void> {
  const AddTaskRoute({List<_i6.PageRouteInfo>? children})
    : super(AddTaskRoute.name, initialChildren: children);

  static const String name = 'AddTaskRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddTaskScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.SignupScreen]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute({List<_i6.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignupScreen();
    },
  );
}

/// generated route for
/// [_i5.TasksScreen]
class TasksScreenRoute extends _i6.PageRouteInfo<TasksScreenRouteArgs> {
  TasksScreenRoute({
    _i7.Key? key,
    required String categoryName,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         TasksScreenRoute.name,
         args: TasksScreenRouteArgs(key: key, categoryName: categoryName),
         initialChildren: children,
       );

  static const String name = 'TasksScreenRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TasksScreenRouteArgs>();
      return _i5.TasksScreen(key: args.key, categoryName: args.categoryName);
    },
  );
}

class TasksScreenRouteArgs {
  const TasksScreenRouteArgs({this.key, required this.categoryName});

  final _i7.Key? key;

  final String categoryName;

  @override
  String toString() {
    return 'TasksScreenRouteArgs{key: $key, categoryName: $categoryName}';
  }
}
