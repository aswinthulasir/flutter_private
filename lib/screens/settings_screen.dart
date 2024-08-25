import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/main.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            UserController().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const InitialiserScreen(),
              ),
            );
          },
          child: const Text(
            "logout",
          ),
        ),
      ),
    );
  }
}
