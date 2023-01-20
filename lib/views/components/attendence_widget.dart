import 'package:flutter/material.dart';
import 'package:gsg_app/models/attendence.dart';

class AttendenceWidget extends StatelessWidget {
  const AttendenceWidget({super.key, required this.attendence});
  final Attendence attendence;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: ListTile(
        title: const Text('Attendence Question'),
        subtitle: Text(attendence.publishingTime.toString()),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[700],
          child: const Icon(Icons.question_mark),
        ),
      ),
    );
  }
}
