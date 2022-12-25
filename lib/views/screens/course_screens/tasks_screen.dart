import 'package:flutter/material.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:gsg_app/providers/auth_provider.dart';
import 'package:gsg_app/views/screens/course_screens/task_screens/add_task_screen.dart';
import 'package:gsg_app/views/screens/course_screens/task_screens/display_task_screen.dart';
import 'package:provider/provider.dart';
import '../../components/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen(
      {super.key, required this.courseId, required this.isTrainer});
  final String courseId;
  final bool isTrainer;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        provider.getAllTasks(courseId);
        return Scaffold(
          floatingActionButton: isTrainer
              ? FloatingActionButton(
                  onPressed: (() => AppRouter.appRouter
                      .goToWidget(AddNewTask(courseId: courseId))),
                  child: const Icon(Icons.add),
                )
              : null,
          body: ListView.builder(
              itemCount: provider.allTasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => AppRouter.appRouter.goToWidget(
                        DisplayTaskScreen(
                            task: provider.allTasks[index],
                            isTrainer: isTrainer,
                            courseId: courseId)),
                    child: TaskWidget(task: provider.allTasks[index]));
              }),
        );
      },
    );
  }
}
