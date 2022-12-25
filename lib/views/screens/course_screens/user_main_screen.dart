import 'package:flutter/material.dart';
import 'package:gsg_app/app_router/app_router.dart';
import 'package:gsg_app/providers/auth_provider.dart';
import 'package:gsg_app/views/screens/course_screens/attendence_screen.dart';
import 'package:gsg_app/views/screens/course_screens/links_screen.dart';
import 'package:gsg_app/views/screens/course_screens/tasks_screen.dart';
import 'package:gsg_app/views/screens/course_screens/zoom_meeting_screen.dart';
import 'package:provider/provider.dart';
import '../../../admin/models/course.dart';

class UserMainScreen extends StatelessWidget {
  const UserMainScreen({
    Key? key,
    required this.isTrainer,
    required this.course,
  }) : super(key: key);
  final bool isTrainer;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'images/gsg_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Zoom Meeting'),
                leading: Image.asset(
                  'images/zoom icon.png',
                  width: 22,
                  height: 22,
                ),
                onTap: () {
                  AppRouter.appRouter.goToWidget(const ZoomMeeting());
                  //Navigator.pop(context);
                },
              ),
              /*ListTile(
                title: const Text('Links'),
                leading: const Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                onTap: () {
                  AppRouter.appRouter.goToWidget(TasksScreen(
                      courseId: 'kMwsV7XS0FGHwkogSgQB', isTrainer: isTrainer));
                  Navigator.pop(context);
                },
              ),*/
              const Divider(
                thickness: 1,
              ),
              ListTile(
                title: const Text('Office Hours'),
                leading: const Icon(
                  Icons.timelapse_outlined,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Contact Us'),
                leading: const Icon(
                  Icons.contact_support,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
              const Divider(
                thickness: 1,
              ),
              Provider.of<AuthProvider>(context).isDarkMode
                  ? ListTile(
                      title: const Text('Light Mode'),
                      leading: const Icon(
                        Icons.light_mode_outlined,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .changeIsDarkMode();
                        Navigator.pop(context);
                      },
                    )
                  : ListTile(
                      title: const Text('Dark Mode'),
                      leading: const Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .changeIsDarkMode();
                        Navigator.pop(context);
                      },
                    ),
            ],
          ),
        ),
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Tasks',
            ),
            Tab(
              text: 'Links',
            ),
            Tab(
              text: 'Attendence',
            )
          ]),
          title: ListTile(
            title: Text(course.name),
            subtitle: const Text('Home Page'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .changeIsDarkMode();
                },
                icon: Icon(Provider.of<AuthProvider>(context).isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode))
          ],
        ),
        body: TabBarView(children: [
          TasksScreen(
            courseId: course.id!,
            isTrainer: isTrainer,
          ),
          LinksScreen(
            courseId: course.id!,
            isTrainer: isTrainer,
          ),
          AttendenceScreen(
            courseId: course.id!,
            isTrainer: isTrainer,
          )
        ]),
      ),
    );
  }
}
