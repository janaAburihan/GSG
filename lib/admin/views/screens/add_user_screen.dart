import 'package:flutter/material.dart';
import 'package:gsg_app/views/screens/choose_course_screen.dart';
import 'package:gsg_app/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../../admin/models/course.dart';
import '../../app_router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../components/custom_textField.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen(
      {super.key, required this.course, required this.isTrainer});
  final Course course;
  final bool isTrainer;

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
                      InkWell(
                        onTap: (() => AppRouter.appRouter
                                .goToWidgetAndReplace(ChooseCourseScreen(
                              isTrainer: isTrainer,
                            ))),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: const [
                                Icon(Icons.arrow_back_ios),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('BACK')
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        validation: provider.requiredValidation,
                        label: 'Name',
                        controller: provider.userNameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.phoneValidation,
                        label: 'Phone Number',
                        controller: provider.phoneController,
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.emailValidation,
                        label: 'Email',
                        controller: provider.registerEmailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.passwordValidation,
                        label: 'Password',
                        controller: provider.passwordRegisterController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            provider.signUp(course, isTrainer);
                          },
                          child: const Text('Sign Up')),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Already has an account?',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            AppRouter.appRouter
                                .goToWidgetAndReplace(SignInScreen(
                              course: course,
                              isTrainer: isTrainer,
                            ));
                          },
                          child: const Text('Sign In'))
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
