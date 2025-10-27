import 'package:equatable/equatable.dart';
import '../models/task_model.dart';

// Base sealed class for task states
sealed class TaskState extends Equatable {
  final List<TaskModel> tasksList;
  final String taskText;
  const TaskState(this.tasksList, this.taskText);

  @override
  List<Object?> get props => [tasksList, taskText];
  
  // copyWith method for immutable state updates
  TaskState copyWith({List<TaskModel>? tasksList, String? taskText}) {
    if (this is TaskInitial) {
      return TaskInitial();
    } else if (this is TaskTextUpdated) {
      return TaskTextUpdated(
        taskText ?? this.taskText,
        tasksList ?? this.tasksList,
      );
    } else if (this is UpdateTask) {
      return UpdateTask(
        tasksList ?? this.tasksList,
        taskText ?? this.taskText,
      );
    }
    return this;
  }
}

class TaskInitial extends TaskState {
  TaskInitial() : super([], '');

  @override
  List<Object?> get props => [tasksList, taskText];
  
  @override
  TaskState copyWith({List<TaskModel>? tasksList, String? taskText}) {
    return TaskTextUpdated(
      taskText ?? this.taskText,
      tasksList ?? this.tasksList,
    );
  }
}

class TaskTextUpdated extends TaskState {
  const TaskTextUpdated(String taskText, List<TaskModel> tasksList) : super(tasksList, taskText);

  @override
  List<Object?> get props => [tasksList, taskText];
  
  @override
  TaskState copyWith({List<TaskModel>? tasksList, String? taskText}) {
    return TaskTextUpdated(
      taskText ?? this.taskText,
      tasksList ?? this.tasksList,
    );
  }
}

class UpdateTask extends TaskState {
  const UpdateTask(super.tasksList, super.taskText);

  @override
  List<Object?> get props => [tasksList, taskText];
  
  @override
  TaskState copyWith({List<TaskModel>? tasksList, String? taskText}) {
    return UpdateTask(
      tasksList ?? this.tasksList,
      taskText ?? this.taskText,
    );
  }
}


