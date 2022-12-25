import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../views/components/custom_textField.dart';
import '../../models/course.dart';
import '../../providers/admin_provider.dart';

class EditCourse extends StatelessWidget {
  const EditCourse({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context, listen: false)
        .nameController
        .text = course.name;
    Provider.of<AdminProvider>(context, listen: false).imageFile =
        File(course.imageUrl);
    Provider.of<AdminProvider>(context, listen: false).imageUrl =
        course.imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Course"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.courseFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      provider.pickImageForCourse();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey,
                      child: provider.imageFile == null
                          ? const Center(
                              child: Icon(Icons.photo),
                            )
                          : Image.file(
                              File(provider.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    controller: provider.nameController,
                    label: 'Course Name',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.updateCourse(course);
                      },
                      child: const Text('Update Course'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
