import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseConfig.firebaseConfig.value =
      await FirebaseConfig().initialiseFirebase();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
