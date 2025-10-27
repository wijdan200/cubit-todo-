import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../bloc/counterb.dart';
import '../bloc/counterevent.dart';
import '../bloc/counterstate.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});
  final String title;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        backgroundColor: const Color.fromARGB(255, 203, 192, 251),
        foregroundColor: Colors.white,
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listenWhen: (previous, current) =>
            previous.taskText != current.taskText,
        listener: (context, state) {
          _taskController.text = state.taskText;
          _taskController.selection = TextSelection.fromPosition(
            TextPosition(offset: _taskController.text.length),
          );
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Add Task Section
                  Container(
                    // padding: const EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   color: Colors.blue.shade50,
                    //   borderRadius: BorderRadius.circular(12),
                    //   border: Border.all(color: Colors.blue.shade200),
                    // ),
                    child: Column(
                      children: [
                        const Text(
                          'Add New Task',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _taskController,
                          onChanged: (text) {
                            context.read<TaskBloc>().add(TaskTextUpdate(text));
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter task',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TaskBloc>().add(TaskAdd());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'Add Task',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tasks List
                  if (state.tasksList.isEmpty)
                    const Text('No tasks yet')
                  else
                    ListView.builder(
                      shrinkWrap: true, // مهم داخل SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.tasksList.length,
                      itemBuilder: (context, index) {
                        final task = state.tasksList[index];
                        return ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: task.isDone,
                            onChanged: (_) {
                              context.read<TaskBloc>().add(TaskToggle(task.id));
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<TaskBloc>().add(TaskRemove(task.id));
                            },
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 50),

                  // Counter Section
                  Container(
                    // padding: const EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   color: Colors.purple.shade50,
                    //   borderRadius: BorderRadius.circular(12),
                    //   border: Border.all(color: Colors.purple.shade200),
                    // ),
                    child: Column(
                      children: [
                        const Text(
                          'Counter Section',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Counter A Section
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Counter A',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 10),
                              BlocBuilder<CounterBloc, CounterState>(
                                builder: (context, state) {
                                  return Text(
                                    '${state.counterA}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<CounterBloc>().add(
                                        CounterDecrementA(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(50, 50),
                                    ),
                                    child: const Text(
                                      '-',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<CounterBloc>().add(
                                        CounterIncrementA(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(50, 50),
                                    ),
                                    child: const Text(
                                      '+',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Counter B Section
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Counter B',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 10),
                              BlocBuilder<CounterBloc, CounterState>(
                                builder: (context, state) {
                                  return Text(
                                    '${state.counterB}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<CounterBloc>().add(CounterDecrementB());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(50, 50),
                                    ),
                                    child: const Text('-', style: TextStyle(fontSize: 20)),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<CounterBloc>().add(CounterIncrementB());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(50, 50),
                                    ),
                                    child: const Text('+', style: TextStyle(fontSize: 20)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Reset Button
                        ElevatedButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(CounterReset());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          ),
                          child: const Text('Reset Both Counters', style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
