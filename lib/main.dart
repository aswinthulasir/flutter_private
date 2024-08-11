import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/screens/dashboard.dart';
import 'package:court_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

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
      return DashboardPage(
        username: UserController.userSignal.value?.displayName ?? "User",
      );
    }
  }
}
