import 'package:court_project/models/case_model.dart';
import 'package:court_project/screens/posted_case_details_screen.dart';
import 'package:court_project/screens/taken_cases_details_screen.dart';

import 'package:flutter/material.dart';

class PostedCaseCardListTile extends StatefulWidget {
  const PostedCaseCardListTile({
    super.key,
    required this.caseData,
    required this.color,
    required this.onDelete,
    required this.isPosted,
  });

  final Case caseData;
  final Color color;
  final VoidCallback onDelete;
  final bool isPosted;

  @override
  State<PostedCaseCardListTile> createState() => _PostedCaseCardListTileState();
}

class _PostedCaseCardListTileState extends State<PostedCaseCardListTile> {
  String timestamp = "";

  @override
  Widget build(BuildContext context) {
    if (widget.caseData.date.day == DateTime.now().day) {
      timestamp = "Today";
    } else if (widget.caseData.date.day == DateTime.now().day - 1) {
      timestamp = "Yesterday";
    } else {
      timestamp =
          "${widget.caseData.date.day}/${widget.caseData.date.month}/${widget.caseData.date.year}";
    }
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
          color: widget.color,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                if (widget.isPosted) {
                  return PostedCaseDetailsScreen(caseDetails: widget.caseData);
                } else {
                  return TakenCasesDetailsScreen(caseDetails: widget.caseData);
                }
              }));
            },
            title: Text(
              widget.caseData.advocateName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.caseData.court,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            //show timestamp
            trailing: IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
