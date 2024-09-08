import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/main.dart';
import 'package:court_project/screens/edit_account_screen.dart';
import 'package:court_project/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SettingsListTile(
                icon: Icons.account_circle,
                title: "Edit Account Details",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const EditAccountScreen();
                      },
                    ),
                  );
                }),
            SettingsListTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                UserController().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const InitialiserScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
