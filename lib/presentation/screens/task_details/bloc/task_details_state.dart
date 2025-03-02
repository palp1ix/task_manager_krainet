part of 'task_details_bloc.dart';

sealed class TaskDetailsState extends Equatable {
  const TaskDetailsState();

  @override
  List<Object> get props => [];
}

final class TaskDetailsInitial extends TaskDetailsState {}

final class TaskDetailsInProgress extends TaskDetailsState {}

final class TaskDetailsSuccess extends TaskDetailsState {}

final class TaskDetailsError extends TaskDetailsState {}
