import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../models/task_model.dart';

// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   TaskBloc() : super(TaskInitial()) {
//     on<TaskTextUpdate>((event, emit) {
//       emit(state.copyWith(taskText: event.text));
//     });

//     on<TaskAdd>((event, emit) {
//       if (state.taskText.isNotEmpty) {
//         final task = TaskModel(
//           id: DateTime.now().millisecondsSinceEpoch,
//           title: state.taskText,
//           isDone: false,
//         );
//         emit(state.copyWith(
//           tasksList: [...state.tasksList, task],
//           taskText: '',
//         ));
//       }
//     });

//     on<TaskRemove>((event, emit) {
//       final List<TaskModel> updatedList = state.tasksList.where((task) => task.id != event.id).toList();
//       emit(state.copyWith(tasksList: updatedList));
//     });

//     on<TaskToggle>((event, emit) {
//       final List<TaskModel> updatedList = state.tasksList.map((task) {
//         return task.id == event.id ? task.copyWith(isDone: !task.isDone) : task;
//       }).toList();
//       emit(state.copyWith(tasksList: updatedList));
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../models/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskTextUpdate>((event, emit) {
      emit(state.copyWith(taskText: event.text));
    });

    on<TaskAdd>((event, emit) {
      if (state.taskText.isNotEmpty) {
        final task = TaskModel(
          id: DateTime.now().millisecondsSinceEpoch,
          title: state.taskText,
          isDone: false,
        );
        emit(state.copyWith(
          tasksList: [...state.tasksList, task],
          taskText: '',
        ));
      }
    });

    on<TaskRemove>((event, emit) {
      final updatedList =
          state.tasksList.where((task) => task.id != event.id).toList();
      emit(state.copyWith(tasksList: updatedList));
    });

    on<TaskToggle>((event, emit) {
      final updatedList = state.tasksList.map((task) {
        return task.id == event.id
            ? task.copyWith(isDone: !task.isDone)
            : task;
      }).toList();
      emit(state.copyWith(tasksList: updatedList));
    });
  }
}

