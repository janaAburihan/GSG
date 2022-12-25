import 'package:flutter/material.dart';
import 'package:gsg_app/views/screens/choose_course_screen.dart';
import '../../app_router/app_router.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME TO',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Text(
                            '       GAZA SKY GEEKS',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('images/gsg icon.jpg',
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'YOU\'RE JOINING AS A :',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: (() => AppRouter.appRouter.goToWidgetAndReplace(
                      const ChooseCourseScreen(isTrainer: true))),
                  clipBehavior: Clip.hardEdge,
                  child: const Text('TRAINER')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (() => AppRouter.appRouter.goToWidgetAndReplace(
                      const ChooseCourseScreen(isTrainer: false))),
                  clipBehavior: Clip.hardEdge,
                  child: const Text('TRAINEE')),
            ],
          ),
        ),
      ),
    );
  }
}
