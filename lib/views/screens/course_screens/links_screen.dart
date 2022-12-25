import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_router/app_router.dart';
import '../../../providers/auth_provider.dart';
import '../../components/link_widget.dart';
import 'link_screens/add_link_screen.dart';
import 'link_screens/edit_link_screen.dart';

class LinksScreen extends StatelessWidget {
  const LinksScreen(
      {super.key, required this.courseId, required this.isTrainer});
  final String courseId;
  final bool isTrainer;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        provider.getAllLinks(courseId);
        return Scaffold(
          floatingActionButton: isTrainer
              ? FloatingActionButton(
                  onPressed: (() => AppRouter.appRouter
                      .goToWidget(AddNewLink(courseId: courseId))),
                  child: const Icon(Icons.add),
                )
              : null,
          body: ListView.builder(
              itemCount: provider.allLinks.length,
              itemBuilder: (context, index) {
                return isTrainer
                    ? Stack(
                        children: [
                          LinkWidget(link: provider.allLinks[index]),
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
                                          AppRouter.appRouter.goToWidget(
                                              EditLink(
                                                  link: provider
                                                      .allLinks[index]));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                    : LinkWidget(link: provider.allLinks[index]);
              }),
        );
      },
    );
  }
}
