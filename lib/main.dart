import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/app_database.dart';
import 'screens/home_screen.dart';
import 'view_models/task_view_model.dart';

void main() {
  final AppDatabase db = AppDatabase();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  const MyApp({Key? key, required this.db}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (_) => TaskViewModel(db: db),
      child: MaterialApp(
        title: 'Task Application',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
