import 'package:flutter/material.dart';
import 'package:gsg_app/admin/views/screens/display_participents.dart';
import 'package:provider/provider.dart';
import '../../../app_router/app_router.dart';
import '../../models/course.dart';
import '../../../views/components/custom_textField.dart';
import '../../providers/admin_provider.dart';

// ignore: must_be_immutable
class AddNewParticipent extends StatefulWidget {
  AddNewParticipent({
    super.key,
    required this.course,
  });
  final Course course;
  bool isTrainer = false;

  @override
  State<AddNewParticipent> createState() => _AddNewParticipentState();
}

class _AddNewParticipentState extends State<AddNewParticipent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<AdminProvider>(
            builder: (context, provider, child) => Form(
                key: provider.signUpKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: (() {
                          AppRouter.appRouter.goToWidgetAndReplace(
                              AllParticipentsScreen(course: widget.course));
                        }),
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
                        controller: provider.userPhoneNumberController,
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.emailValidation,
                        label: 'Email',
                        controller: provider.userEmailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validation: provider.passwordValidation,
                        label: 'Password',
                        controller: provider.userPasswordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                          title: const Text('Is Trainer'),
                          value: widget.isTrainer,
                          onChanged: (v) {
                            widget.isTrainer = !widget.isTrainer;
                            setState(() {});
                          }),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            provider.addNewParticipent(
                                widget.course, widget.isTrainer);
                            AppRouter.appRouter.goToWidgetAndReplace(
                                AllParticipentsScreen(course: widget.course));
                          },
                          child: const Text('Add Participent')),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
