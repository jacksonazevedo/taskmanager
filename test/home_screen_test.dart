import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:taskmanager/data/app_database.dart';
import 'package:taskmanager/view_models/task_view_model.dart';
import 'package:taskmanager/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays empty task list', (
    WidgetTester tester,
  ) async {
    // Configura o banco de dados em memória e o ViewModel para testes.
    final db = AppDatabase.test(NativeDatabase.memory());
    final taskVM = TaskViewModel(db: db);

    await tester.pumpWidget(
      ChangeNotifierProvider<TaskViewModel>.value(
        value: taskVM,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Aguarda que o loadTasks seja completado
    await tester.pumpAndSettle();

    // Verifica se o título da tela é exibido
    expect(find.text("Task List"), findsOneWidget);
    // Como a lista está vazia, nenhum ListTile deve ser encontrado
    expect(find.byType(ListTile), findsNothing);

    await db.close();
  });
}
