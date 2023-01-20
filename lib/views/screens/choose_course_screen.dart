import 'package:flutter/material.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:gsg_app/views/components/course_widget.dart';
import 'package:gsg_app/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../../admin/providers/admin_provider.dart';

class ChooseCourseScreen extends StatelessWidget {
  const ChooseCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME TO',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Text(
                            '       GAZA SKY GEEKS',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('images/gsg icon.jpg',
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 60, right: 60, bottom: 20),
                          child: ListView.builder(
                              itemCount: provider.allCourses.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      AppRouter.appRouter.goToWidgetAndReplace(
                                          SignInScreen(
                                              course:
                                                  provider.allCourses[index])
                                          /*UserMainScreen(
                                      isTrainer: isTrainer,
                                      course: provider.allCourses[index],
                                    )*/
                                          );
                                    },
                                    child: Column(
                                      children: [
                                        CourseWidget(
                                            provider.allCourses[index]),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ));
                              }),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
