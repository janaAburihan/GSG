import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/link.dart';
import '../../../../providers/auth_provider.dart';
import '../../../components/custom_textField.dart';

class EditLink extends StatelessWidget {
  const EditLink({super.key, required this.link});
  final Link link;

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false)
        .linkDescriptionController
        .text = link.description;
    Provider.of<AuthProvider>(context, listen: false).linkUrlController.text =
        link.url;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Link"),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.addTaskKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.linkDescriptionController,
                    label: 'Link Description',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: provider.linkUrlController,
                    label: 'Link URL',
                    validation: provider.urlValidation,
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        //provider.updateLink(link);
                      },
                      child: const Text('Update Link'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
