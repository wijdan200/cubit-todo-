import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_bloc_app/controller/task_cubit.dart';
import 'package:my_flutter_bloc_app/models/task_model.dart';
import 'cubit/counter_cubit.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => TaskCubit(),
        child: TaskPage(title: 'To Do with Cubit'),
      ),
    ),
  );
}



class TaskPage extends StatelessWidget {
  TaskPage({super.key, required this.title});
  final String title ;
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO with Cubit'),
      ),
      
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Enter task',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final task = TaskModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: _taskController.text,
                  isDone: false,
                );
                context.read<TaskCubit>().addTask(task);
                _taskController.clear();
              },
              child: const Text('Add Task'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.tasksList.length,
                itemBuilder: (context, index) {
                  final task = state.tasksList[index];
                  return ListTile(
                    title: Text(task.title),
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (_) {
                        context.read<TaskCubit>().toggleTask(task.id);
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<TaskCubit>().removeTask(task.id);
                      },
                    ),
                  );
                },
              ),
            ),



          ],

          );
        },
      ),
    );
  }
}
