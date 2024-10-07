import 'package:court_project/screens/posted_case_screen.dart';
import 'package:court_project/screens/settings_screen.dart';
import 'package:court_project/screens/take_case_screen.dart';
import 'package:court_project/screens/taken_cases_screen.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:court_project/widgets/dashboard_list_tile.dart';
import 'package:flutter/material.dart';
import 'post_case_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${LocalDatabase().getName() ?? "User"}"),
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
                assetPath: "assets/images/taken_case.png",
                description: "You can see the taken cases here.",
                screenName: "Taken Cases",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TakenCasesScreen(),
                    ),
                  );
                }),
            DashboardListTile(
              assetPath: "assets/images/posted_case.png",
              description: "You can see the posted cases here.",
              screenName: "Posted Cases",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PostedCaseScreen(),
                  ),
                );
              },
            ),
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
