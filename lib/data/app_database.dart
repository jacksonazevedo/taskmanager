import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'task.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(dbFile);
  });
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  // Construtor padrão
  AppDatabase() : super(_openConnection());

  // Construtor para testes, permitindo injetar um QueryExecutor
  AppDatabase.test(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Insert a new task
  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  // Fetch all tasks
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // Update a task (e.g., toggle status)
  Future<bool> updateTask(Task task) => update(tasks).replace(task);

  // Delete a task by id
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
