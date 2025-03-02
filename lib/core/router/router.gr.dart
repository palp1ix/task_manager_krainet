// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:task_manager_krainet/domain/entities/task.dart' as _i10;
import 'package:task_manager_krainet/presentation/screens/add_task/add_task.dart'
    as _i1;
import 'package:task_manager_krainet/presentation/screens/home/home.dart'
    as _i2;
import 'package:task_manager_krainet/presentation/screens/login/login.dart'
    as _i3;
import 'package:task_manager_krainet/presentation/screens/profile/profile.dart'
    as _i4;
import 'package:task_manager_krainet/presentation/screens/registration/registration.dart'
    as _i5;
import 'package:task_manager_krainet/presentation/screens/task_details/task_details.dart'
    as _i6;
import 'package:task_manager_krainet/presentation/screens/tasks/tasks.dart'
    as _i7;

/// generated route for
/// [_i1.AddTaskScreen]
class AddTaskRoute extends _i8.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i9.Key? key,
    required String categoryName,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         AddTaskRoute.name,
         args: AddTaskRouteArgs(key: key, categoryName: categoryName),
         initialChildren: children,
       );

  static const String name = 'AddTaskRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddTaskRouteArgs>();
      return _i1.AddTaskScreen(key: args.key, categoryName: args.categoryName);
    },
  );
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({this.key, required this.categoryName});

  final _i9.Key? key;

  final String categoryName;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i5.SignupScreen]
class SignupRoute extends _i8.PageRouteInfo<void> {
  const SignupRoute({List<_i8.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignupScreen();
    },
  );
}

/// generated route for
/// [_i6.TaskDetailsScreen]
class TaskDetailsRoute extends _i8.PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    _i9.Key? key,
    required _i10.Task task,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         TaskDetailsRoute.name,
         args: TaskDetailsRouteArgs(key: key, task: task),
         initialChildren: children,
       );

  static const String name = 'TaskDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailsRouteArgs>();
      return _i6.TaskDetailsScreen(key: args.key, task: args.task);
    },
  );
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({this.key, required this.task});

  final _i9.Key? key;

  final _i10.Task task;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [_i7.TasksScreen]
class TasksScreenRoute extends _i8.PageRouteInfo<TasksScreenRouteArgs> {
  TasksScreenRoute({
    _i9.Key? key,
    required String categoryName,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         TasksScreenRoute.name,
         args: TasksScreenRouteArgs(key: key, categoryName: categoryName),
         initialChildren: children,
       );

  static const String name = 'TasksScreenRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TasksScreenRouteArgs>();
      return _i7.TasksScreen(key: args.key, categoryName: args.categoryName);
    },
  );
}

class TasksScreenRouteArgs {
  const TasksScreenRouteArgs({this.key, required this.categoryName});

  final _i9.Key? key;

  final String categoryName;

  @override
  String toString() {
    return 'TasksScreenRouteArgs{key: $key, categoryName: $categoryName}';
  }
}
