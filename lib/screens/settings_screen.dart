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
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              UserController().signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InitialiserScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
