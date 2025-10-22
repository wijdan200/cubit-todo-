// part of 'task_cubit.dart';

// // Base sealed class for task states
// sealed class TaskState extends Equatable {
//  final List<TaskModel> tasksList;
//  const TaskState( this.tasksList);
//   @override
//   List<Object?> get props => [tasksList];
// }


// class TaskInitial extends TaskState {
//   TaskInitial():super([]);

//   @override
//   List<Object?> get props => [];
// }


// class   UpdateTask extends TaskState {
//   const UpdateTask(super.tasksList);

//   @override
//   List<Object?> get props => [];
// }


part of 'task_cubit.dart';

// Base sealed class for task states
sealed class TaskState extends Equatable {
  final List<TaskModel> tasksList;
  const TaskState(this.tasksList);

  @override
  List<Object?> get props => [tasksList];
}

class TaskInitial extends TaskState {
  TaskInitial() : super([]);

  @override
  List<Object?> get props => [tasksList];
}

class UpdateTask extends TaskState {
  const UpdateTask(super.tasksList);

  @override
  List<Object?> get props => [tasksList];
}
