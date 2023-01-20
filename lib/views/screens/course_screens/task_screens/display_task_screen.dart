import 'package:flutter/material.dart';
import 'package:gsg_app/admin/models/course.dart';
import 'package:gsg_app/providers/auth_provider.dart';
import 'package:gsg_app/views/components/custom_textField.dart';
import 'package:provider/provider.dart';
import '../../../../app_router/app_router.dart';
import '../../../../admin/models/participent.dart';
import '../../../../models/task.dart';
import '../user_main_screen.dart';
import 'edit_task_screen.dart';

class DisplayTaskScreen extends StatelessWidget {
  const DisplayTaskScreen(
      {super.key,
      required this.task,
      required this.user,
      required this.course});
  final Task task;
  final AppUser user;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.isTrainer
                  ? Row(
                      children: [
                        InkWell(
                          onTap: (() => AppRouter.appRouter
                                  .goToWidgetAndReplace(UserMainScreen(
                                user: user,
                                course: course,
                              ))),
                          child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue),
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_back_ios),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text('BACK')
                                ],
                              )),
                        ),
                        const Expanded(child: SizedBox()),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                AppRouter.appRouter
                                    .goToWidget(EditTask(task: task));
                              },
                              icon: const Icon(Icons.edit)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                //
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: (() => AppRouter.appRouter
                              .goToWidgetAndReplace(UserMainScreen(
                            user: user,
                            course: course,
                          ))),
                      child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_back_ios),
                              SizedBox(
                                width: 1,
                              ),
                              Text('BACK')
                            ],
                          )),
                    ),
              const SizedBox(
                height: 30,
              ),
              Text(
                task.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                task.description,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Deadline : ${task.deadline}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              user.isTrainer
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Show Submitions')),
                    )
                  : Column(
                      children: [
                        CustomTextField(
                            validation: Provider.of<AuthProvider>(context)
                                .urlValidation,
                            label: 'submit the link to your work here',
                            controller: Provider.of<AuthProvider>(context)
                                .taskSubmitionController),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  /*Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .taskSubmitions
                                      .add({
                                    user: Provider.of<AuthProvider>(context)
                                        .taskSubmitionController
                                  });*/
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .taskSubmitionController
                                      .clear();
                                },
                                child: const Text('Submit'))),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
