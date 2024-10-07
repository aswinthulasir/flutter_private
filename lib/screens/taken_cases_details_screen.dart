import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:flutter/material.dart';

class TakenCasesDetailsScreen extends StatefulWidget {
  const TakenCasesDetailsScreen({required this.caseDetails, super.key});

  final Case caseDetails;

  @override
  State<TakenCasesDetailsScreen> createState() =>
      _TakenCasesDetailsScreenState();
}

class _TakenCasesDetailsScreenState extends State<TakenCasesDetailsScreen> {
  late String formattedDate =
      "${widget.caseDetails.date.day}/${widget.caseDetails.date.month}/${widget.caseDetails.date.year}";

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Taken Case Details",
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
                                    title: const Text("Withdraw Case"),
                                    content: const Text(
                                        "Are you sure you want to withdraw this case?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          CaseController()
                                              .removeTakenCase(
                                            widget.caseDetails.id,
                                            LocalDatabase().getUserId()!,
                                            widget.caseDetails.court,
                                            widget.caseDetails.userId,
                                          )
                                              .then((value) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Case withdrawn successfully",
                                                  ),
                                                ),
                                              );
                                              Navigator.of(alertContext).pop();
                                            }
                                          }).catchError((err) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "An error occurred while withdrawing case"),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(alertContext).pop();
                                        },
                                        child: const Text("No"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            child: const Text(
                              'Withdraw Case',
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
