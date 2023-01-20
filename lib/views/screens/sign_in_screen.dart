import 'package:flutter/material.dart';
import 'package:gsg_app/views/screens/choose_course_screen.dart';
import 'package:provider/provider.dart';
import '../../admin/models/course.dart';
import '../../app_router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../components/custom_textField.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) => Form(
                key: provider.signInKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (() => AppRouter.appRouter
                                .goToWidgetAndReplace(
                                    const ChooseCourseScreen())),
                            child: Container(
                                width: 80,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: const [
                                    Icon(Icons.arrow_back_ios),
                                    Text('BACK')
                                  ],
                                )),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      CustomTextField(
                        validation: provider.emailValidation,
                        label: 'Email',
                        controller: provider.loginEmailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.passwordValidation,
                        label: 'Password',
                        controller: provider.passwordLoginController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await provider.signIn(course);
                          },
                          child: const Text('Sign In')),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
