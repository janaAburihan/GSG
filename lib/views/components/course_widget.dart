import 'dart:io';
import 'package:flutter/material.dart';
import '../../admin/models/course.dart';

// ignore: must_be_immutable
class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 250,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              child: SizedBox(
                  //width: 50,
                  height: 150,
                  child: Image.file(
                    File(course.imageUrl),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                course.name,
                style: const TextStyle(
                    fontSize: 22,
                    //fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
