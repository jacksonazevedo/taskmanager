import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:taskmanager/data/app_database.dart';
import 'package:taskmanager/view_models/task_view_model.dart';

void main() {
  late AppDatabase db;
  late TaskViewModel taskVM;

  setUp(() {
    // Cria um banco de dados em memória para testes.
    db = AppDatabase.test(NativeDatabase.memory());
    taskVM = TaskViewModel(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Initial tasks list should be empty', () async {
    await taskVM.loadTasks();
    expect(taskVM.tasks, isEmpty);
  });

  test('Adding a task should increase tasks count', () async {
    await taskVM.addTask("Test Task", "Test Description");
    expect(taskVM.tasks.length, 1);
    expect(taskVM.tasks.first.name, "Test Task");
  });

  test('Toggle task status should update task state', () async {
    await taskVM.addTask("Task to Toggle", null);
    final task = taskVM.tasks.first;
    final initialStatus = task.isCompleted;
    await taskVM.toggleTaskStatus(task);
    final updatedTask = taskVM.tasks.first;
    expect(updatedTask.isCompleted, !initialStatus);
  });
}
