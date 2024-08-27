import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/screens/settings_screen.dart';
import 'package:court_project/screens/takecase_screen.dart';
import 'package:court_project/widgets/dashboard_list_tile.dart';
import 'package:flutter/material.dart';
import 'postcase_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Welcome ${UserController.currentUserSignal.value?.name ?? "User"}"),
      ),
      body: Center(
        child: Column(
          children: [
            DashboardListTile(
                assetPath: "assets/images/post.png",
                description: "You can post a case here",
                screenName: "Post Case",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PostCasePage(),
                    ),
                  );
                }),
            DashboardListTile(
                assetPath: "assets/images/law_and_order.png",
                description: "You can take a case here",
                screenName: "Take Case",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TakecaseScreen(),
                    ),
                  );
                }),
            DashboardListTile(
              assetPath: "assets/images/settings.png",
              description: "You can view your profile here",
              screenName: "Settings",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
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
