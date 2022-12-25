import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../components/attendence_widget.dart';

class AttendenceScreen extends StatelessWidget {
  const AttendenceScreen(
      {super.key, required this.courseId, required this.isTrainer});
  final String courseId;
  final bool isTrainer;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        provider.getAllQuestions(courseId);
        return Scaffold(
          floatingActionButton: isTrainer
              ? FloatingActionButton(
                  onPressed: () {
                    provider.addNewQuestion(courseId);
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          body: ListView.builder(
              itemCount: provider.allAttendenceQuestions.length,
              itemBuilder: (context, index) {
                return isTrainer
                    ? Stack(
                        children: [
                          AttendenceWidget(
                              attendence:
                                  provider.allAttendenceQuestions[index]),
                          Positioned(
                              right: 15,
                              top: 5,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          provider.deleteLink(
                                              provider.allLinks[index]);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ),
                                ],
                              ))
                        ],
                      )
                    : AttendenceWidget(
                        attendence: provider.allAttendenceQuestions[index]);
              }),
        );
      },
    );
  }
}
