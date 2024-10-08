import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:flutter/material.dart';

class CaseDetailsScreen extends StatefulWidget {
  const CaseDetailsScreen({required this.caseDetails, super.key});

  final Case caseDetails;

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late String formattedDate =
      "${widget.caseDetails.date.day}/${widget.caseDetails.date.month}/${widget.caseDetails.date.year}";

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Case Details",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Advocate Name: ${widget.caseDetails.advocateName}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Date: $formattedDate",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Court Name: ${widget.caseDetails.court}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "State: ${widget.caseDetails.state}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "District: ${widget.caseDetails.district}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Case Description: ${widget.caseDetails.caseDescription} ",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (alertContext) {
                                    return AlertDialog(
                                      title: const Text("Taking Case"),
                                      content: const Text(
                                        "Are you sure you want to take this case?\nThis will notify the user that you have taken the case.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            // query for the user device token
                                            final deviceToken =
                                                await UserController()
                                                    .getPostedUserDeviceToken(
                                                        widget.caseDetails
                                                            .userId);
                                            // Take the case
                                            CaseController()
                                                .takeCase(
                                                    widget.caseDetails.id,
                                                    LocalDatabase()
                                                        .getUserId()!,
                                                    widget.caseDetails.court,
                                                    deviceToken)
                                                .then((value) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Case taken successfully!",
                                                    ),
                                                  ),
                                                );
                                              }
                                            }).catchError((err) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Error taking case: $err"),
                                                  ),
                                                );
                                              }
                                            });
                                            if (context.mounted) {
                                              Navigator.of(alertContext).pop();
                                            }
                                          },
                                          child: const Text("OK"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(alertContext).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            child: const Text(
                              'Take Case',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
