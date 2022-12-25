import 'package:flutter/material.dart';
import 'package:gsg_app/models/attendence.dart';

class AttendenceWidget extends StatelessWidget {
  const AttendenceWidget({super.key, required this.attendence});
  final Attendence attendence;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Attendence Question',
      ),
      subtitle: Text(attendence.publishingTime.toString()),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
