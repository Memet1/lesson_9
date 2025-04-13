import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notifyer.dart';

class TodoForm extends StatefulWidget {
  final void Function(String task) onSubmit;

  const TodoForm({super.key, required this.onSubmit});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isInputEmpty = _controller.text.trim().isEmpty;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(hintText: "Нове завдання"),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed:
                isInputEmpty
                    ? null
                    : () {
                      context.read<TaskProvider>().addTasks(
                        _controller.text.trim(),
                      );
                      _controller.clear();
                      setState(() {});
                    },
            child: const Text("Додати"),
          ),
        ],
      ),
    );
  }
}
