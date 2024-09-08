import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/screens/dashboard_screen.dart';
import 'package:court_project/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseConfig.firebaseConfig.value =
      await FirebaseConfig().initialiseFirebase();
  UserController().listenToUserChanges();
  
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialiserScreen(),
    ),
  );
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UserController.userSignal.value == null) {
      return const LoginPage();
    } else {
      return const DashboardPage();
    }
  }
}
