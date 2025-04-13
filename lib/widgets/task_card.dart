import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/notifyer.dart';
import 'package:todo_list/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final int index;
  final Animation<double> animation;
  final Function()? onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.index,
    required this.animation,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListTile(
          title: Text(
            task.text,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted ? Colors.grey : Colors.black,
            ),
          ),
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) {
              context.read<TaskProvider>().toggleComplete(index);
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
