import 'package:flutter/material.dart';
import 'package:gsg_app/admin/providers/admin_provider.dart';
import 'package:provider/provider.dart';
import '../../models/participent.dart';

class ParticipentWidget extends StatelessWidget {
  const ParticipentWidget({super.key, required this.participent});
  final AppUser participent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: ListTile(
        title: Text(participent.userName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email :  ${participent.email}'),
            Text('Password :  ${participent.password}'),
            Text('Phone Number :  ${participent.phoneNumber}'),
            participent.isTrainer
                ? const Text('Position : trainer')
                : const Text('Position : trainee'),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[700],
          child: Center(child: Text(participent.userName[0])),
        ),
        trailing: InkWell(
            onTap: (() => Provider.of<AdminProvider>(context, listen: false)
                .deleteParticipent(participent)),
            child: const Icon(Icons.delete)),
      ),
    );
  }
}
