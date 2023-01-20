import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../admin/models/participent.dart';
import '../../../providers/auth_provider.dart';
import '../../components/attendence_widget.dart';

class AttendenceScreen extends StatelessWidget {
  const AttendenceScreen(
      {super.key, required this.courseId, required this.user});
  final String courseId;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        provider.getAllQuestions(courseId);
        return Scaffold(
          floatingActionButton: user.isTrainer
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
                return user.isTrainer
                    ? Stack(
                        children: [
                          AttendenceWidget(
                              attendence:
                                  provider.allAttendenceQuestions[index]),
                          Positioned(
                              right: 20,
                              top: 20,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          provider.deleteAttendence(provider
                                              .allAttendenceQuestions[index]);
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
