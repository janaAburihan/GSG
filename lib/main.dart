import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_app/firebase_options.dart';
import 'package:gsg_app/providers/auth_provider.dart';
import 'package:gsg_app/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'admin/providers/admin_provider.dart';
import 'admin/views/screens/splash_screen.dart';
import 'app_router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) {
          return AuthProvider();
        },
      ),
      ChangeNotifierProvider<AdminProvider>(
        create: (context) {
          return AdminProvider();
        },
      ),
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.appRouter.navigatorKey,
      title: 'GSG App',
      theme: Provider.of<AuthProvider>(context).isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
