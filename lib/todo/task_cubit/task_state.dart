part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {}

class TaskFailure extends TaskState {}

class ChangePage extends TaskState {}

class ChangeStatus extends TaskState {}

class CompletedTasks extends TaskState {}
