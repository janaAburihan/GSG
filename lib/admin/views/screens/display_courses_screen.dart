import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_router/app_router.dart';
import '../../providers/admin_provider.dart';
import '../components/course_widget.dart';
import 'add_course_screen.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(const AddNewCourse());
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('All Courses'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCourses.isEmpty
            ? const Center(
                child: Text('No Courses Found'),
              )
            : ListView.builder(
                itemCount: provider.allCourses.length,
                itemBuilder: (context, index) {
                  return CourseWidget(provider.allCourses[index]);
                });
      }),
    );
  }
}
