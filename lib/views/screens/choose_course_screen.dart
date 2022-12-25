import 'package:flutter/material.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:gsg_app/views/components/course_widget.dart';
import 'package:gsg_app/views/screens/join_as_screen.dart';
import 'package:provider/provider.dart';
import '../../admin/providers/admin_provider.dart';
import 'course_screens/user_main_screen.dart';

class ChooseCourseScreen extends StatelessWidget {
  const ChooseCourseScreen({super.key, required this.isTrainer});
  final bool isTrainer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (() => AppRouter.appRouter
                    .goToWidgetAndReplace(const JoinAsScreen())),
                child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_back_ios),
                        SizedBox(
                          width: 1,
                        ),
                        Text('BACK')
                      ],
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Select Course',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<AdminProvider>(builder: (context, provider, w) {
                  return provider.allCourses.isEmpty
                      ? const Center(
                          child: Text('No Courses Found'),
                        )
                      : ListView.builder(
                          itemCount: provider.allCourses.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  AppRouter.appRouter
                                      .goToWidgetAndReplace(UserMainScreen(
                                    isTrainer: isTrainer,
                                    course: provider.allCourses[index],
                                  ));
                                },
                                child:
                                    CourseWidget(provider.allCourses[index]));
                          });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
