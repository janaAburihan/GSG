import 'package:flutter/material.dart';
import 'package:gsg_app/admin/views/screens/add_participent_screen.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../admin/models/course.dart';
import '../../providers/admin_provider.dart';
import '../components/participent_widget.dart';

class AllParticipentsScreen extends StatelessWidget {
  const AllParticipentsScreen({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, child) {
        provider.getAllParticipents(course.id!);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (() => AppRouter.appRouter.goToWidget(AddNewParticipent(
                  course: course,
                ))),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(title: const Text('All Participents')),
          body: ListView.builder(
              itemCount: provider.allParticipents.length,
              itemBuilder: (context, index) {
                return ParticipentWidget(
                    participent: provider.allParticipents[index]);
              }),
        );
      },
    );
  }
}
