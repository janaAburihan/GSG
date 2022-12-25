import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/task.dart';
import '../../../../providers/auth_provider.dart';
import '../../../components/custom_textField.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context).taskDeadlineController.text =
        task.deadline.toString();
    Provider.of<AuthProvider>(context).taskDescriptionController.text =
        task.description;
    Provider.of<AuthProvider>(context).taskTitleController.text = task.title;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
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
                    controller: provider.taskTitleController,
                    label: 'Task Title',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.taskDescriptionController,
                    label: 'Task Description',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.taskDeadlineController,
                    label: 'Task Deadline, eg. 2022-12-24 23:59:59',
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
                        //provider.updateTask(task);
                      },
                      child: const Text('Update Task'),
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
