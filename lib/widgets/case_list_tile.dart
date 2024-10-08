import 'package:court_project/models/case_model.dart';
import 'package:court_project/screens/case_details_screen.dart';
import 'package:flutter/material.dart';

class CaseCardListTile extends StatefulWidget {
  const CaseCardListTile(
      {super.key, required this.caseData, required this.color});

  final Case caseData;
  final Color color;

  @override
  State<CaseCardListTile> createState() => _CaseCardListTileState();
}

class _CaseCardListTileState extends State<CaseCardListTile> {
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
                return CaseDetailsScreen(
                  caseDetails: widget.caseData,
                );
              }));
            },
            title: Text(
              widget.caseData.advocateName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Text(
              widget.caseData.court,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //show timestamp
            trailing: Text(
              timestamp,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
