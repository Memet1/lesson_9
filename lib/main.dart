import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screen/home_screen.dart';
import 'package:todo_list/models/notifyer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TaskProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Homescreen(),
    );
  }
}
