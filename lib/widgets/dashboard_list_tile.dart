import 'package:flutter/material.dart';

class DashboardListTile extends StatelessWidget {
  const DashboardListTile({
    super.key,
    required this.screenName,
    this.onTap,
    required this.description,
    required this.assetPath,
  });

  final String assetPath;
  final String screenName;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          borderOnForeground: true,
          color: Colors.deepPurple[50],
          child: ListTile(
            onTap: onTap,
            leading: Image.asset(assetPath, width: 45, height: 45),
            title: Text(
              screenName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Text(
              description,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
