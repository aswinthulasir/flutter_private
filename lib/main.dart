import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/screens/dashboard_screen.dart';
import 'package:court_project/screens/login_screen.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseConfig.firebaseConfig.value =
      await FirebaseConfig().initialiseFirebase();
  LocalDatabase.initialise();
  UserController().listenToUserChanges();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialiserScreen(),
    ),
  );
}

class InitialiserScreen extends StatefulWidget {
  const InitialiserScreen({super.key});

  @override
  State<InitialiserScreen> createState() => _InitialiserScreenState();
}

class _InitialiserScreenState extends State<InitialiserScreen> {
  final LocalDatabase localDB = LocalDatabase();

  @override
  Widget build(BuildContext context) {
    if (localDB.getUserId() == null || localDB.getName() == null) {
      return const LoginPage();
    } else {
      return const DashboardPage();
    }
  }
}
