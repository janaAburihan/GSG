import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).checkUser();
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image(
        image: AssetImage('images/gsg_logo.png'),
        //fit: BoxFit.cover,
      ),
    );
  }
}
