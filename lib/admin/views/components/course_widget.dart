import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsg_app/admin/views/screens/display_participents.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:provider/provider.dart';
import '../../models/course.dart';
import '../../providers/admin_provider.dart';
import '../screens/edit_course_screen.dart';

// ignore: must_be_immutable
class CourseWidget extends StatelessWidget {
  Course course;
  CourseWidget(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(13)),
                  child: SizedBox(
                      width: double.infinity,
                      height: 170,
                      child: Image.file(
                        File(course.imageUrl),
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                    right: 15,
                    top: 10,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .deleteCourse(course);
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                AppRouter.appRouter.goToWidget(
                                    EditCourse(course: course));
                              },
                              icon: const Icon(Icons.edit)),
                        ),
                      ],
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Course Name: ${course.name}',
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    AppRouter.appRouter.goToWidget(const AllParticipentsScreen());
                  },
                  child: const Text('Show Participents')),
            )
          ],
        ),
      ),
    );
  }
}