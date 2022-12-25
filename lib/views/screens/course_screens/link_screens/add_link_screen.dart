import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../components/custom_textField.dart';

class AddNewLink extends StatelessWidget {
  const AddNewLink({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Link"),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.addTaskKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.linkDescriptionController,
                    label: 'Link Description',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.linkUrlController,
                    label: 'Link URL',
                    validation: provider.urlValidation,
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
                        provider.addNewLink(courseId);
                      },
                      child: const Text('Add New Link'),
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
