import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../views/components/custom_textField.dart';
import '../../providers/admin_provider.dart';

class AddNewCourse extends StatelessWidget {
  const AddNewCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Course"),
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
                              child: Icon(Icons.camera),
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
                    height: 20,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.addNewCourse();
                      },
                      child: const Text('Add New Course'),
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
