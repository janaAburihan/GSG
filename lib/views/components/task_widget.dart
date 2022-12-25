import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.publishingTime.toString()),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[700],
          child: const Icon(Icons.task),
        ),
      ),
    );
  }
}
