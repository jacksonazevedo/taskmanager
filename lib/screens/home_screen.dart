import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/task_view_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Task List")),
      body: RefreshIndicator(
        onRefresh: taskVM.loadTasks,
        child: ListView.builder(
          itemCount: taskVM.tasks.length,
          itemBuilder: (context, index) {
            final task = taskVM.tasks[index];
            return Dismissible(
              key: Key(task.id.toString()),
              direction: DismissDirection.endToStart, // swipe para a esquerda
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                taskVM.deleteTask(task);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Task deleted")));
              },
              child: ListTile(
                title: Text(task.name),
                subtitle: Text(task.isCompleted ? "Completed" : "Pending"),
                trailing: Switch(
                  value: task.isCompleted,
                  onChanged: (value) => taskVM.toggleTaskStatus(task),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the add task screen and reload tasks after return
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          taskVM.loadTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
