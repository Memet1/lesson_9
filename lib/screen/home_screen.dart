import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task_card.dart';
import 'package:todo_list/widgets/todo_form.dart';
import 'package:provider/provider.dart';
import '../models/notifyer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late TaskProvider _provider;
  int _previousLength = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = context.read<TaskProvider>();
      _provider.addListener(_onProviderUpdate);
    });
  }

  void _onProviderUpdate() {
    final tasks = _provider.tasks;
    if (tasks.length > _previousLength) {
      _listKey.currentState?.insertItem(0);
    }
    _previousLength = tasks.length;
  }

  @override
  void dispose() {
    _provider.removeListener(_onProviderUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: Column(
        children: [
          TodoForm(
            onSubmit: (text) {
              context.read<TaskProvider>().addTasks(text);
            },
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, _) {
                final tasks = provider.tasks;
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      "Створіть нове завдання",
                      style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                    ),
                  );
                }
                return AnimatedList(
                  key: _listKey,
                  initialItemCount: tasks.length,
                  itemBuilder: (context, index, animation) {
                    final task = tasks[index];
                    return TaskItem(
                      task: task,
                      index: index,
                      animation: animation,
                      onDelete: () {
                        final provider = context.read<TaskProvider>();
                        final removedTask = provider.tasks[index];

                        _listKey.currentState?.removeItem(
                          index,
                          (context, animation) => TaskItem(
                            task: removedTask,
                            index: index,
                            animation: animation,
                            onDelete: () {},
                          ),
                          duration: const Duration(milliseconds: 300),
                        );

                        provider.removeTask(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
