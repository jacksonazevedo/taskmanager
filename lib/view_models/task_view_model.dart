import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import '../data/app_database.dart';

class TaskViewModel extends ChangeNotifier {
  final AppDatabase db;
  List<Task> tasks = [];

  TaskViewModel({required this.db}) {
    loadTasks();
  }

  // Carrega as tarefas do banco de dados
  Future<void> loadTasks() async {
    tasks = await db.getAllTasks();
    notifyListeners();
  }

  // Alterna o status da tarefa e atualiza a lista
  Future<void> toggleTaskStatus(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await db.updateTask(updatedTask);
    await loadTasks();
  }

  // Adiciona uma nova tarefa
  Future<void> addTask(String name, String? description) async {
    final task = TasksCompanion.insert(
      name: name,
      description: Value(description),
    );
    await db.insertTask(task);
    await loadTasks();
  }

  // Delete a task and reload the tasks list
  Future<void> deleteTask(Task task) async {
    await db.deleteTask(task.id);
    await loadTasks();
  }
}
