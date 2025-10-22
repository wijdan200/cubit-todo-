import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask(TaskModel task) {
    //task جديدة وبحددث عليها  اهم شي يخزن
    // or emit (UpdateTask(list.from(state.tasksList)..add(task)));
    //emit >> مهمة بغيرها ما رح يغير ولا شي 
    emit (UpdateTask([...state.tasksList, task])); 
  }
  
  void removeTask(int id) {
    // حذف  مهمة من الليست يكون الاي د يمختلف عن الي رحح يجيببو 
    final List<TaskModel> updatedList = state.tasksList.where((task) => task.id != id).toList();
    emit(UpdateTask(updatedList));
  }

  void toggleTask(int id) {
    final List<TaskModel> updatedList = state.tasksList.map((task) {
      //! > true or false 
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
    }).toList();
    emit(UpdateTask(updatedList));
  }
}