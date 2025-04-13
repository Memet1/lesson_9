import 'package:flutter/material.dart';

void createTask(
  String task,
  List<String> tasks,
  List<bool> compleated,
  GlobalKey<AnimatedListState> listKey,
) {
  tasks.insert(0, task);
  compleated.insert(0, false);
  listKey.currentState?.insertItem(0);
}
