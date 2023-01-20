import 'package:flutter/material.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:gsg_app/providers/auth_provider.dart';
import 'package:gsg_app/views/screens/course_screens/task_screens/add_task_screen.dart';
import 'package:gsg_app/views/screens/course_screens/task_screens/display_task_screen.dart';
import 'package:provider/provider.dart';
import '../../../admin/models/course.dart';
import '../../../admin/models/participent.dart';
import '../../components/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.course, required this.user});
  final Course course;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        provider.getAllTasks(course.id!);
        return Scaffold(
          floatingActionButton: user.isTrainer
              ? FloatingActionButton(
                  onPressed: (() => AppRouter.appRouter
                      .goToWidget(AddNewTask(courseId: course.id!))),
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
                            user: user,
                            course: course)),
                    child: TaskWidget(task: provider.allTasks[index]));
              }),
        );
      },
    );
  }
}
