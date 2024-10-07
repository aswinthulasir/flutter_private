import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/screens/edit_case_screen.dart';
import 'package:flutter/material.dart';

class PostedCaseDetailsScreen extends StatefulWidget {
  const PostedCaseDetailsScreen({required this.caseDetails, super.key});

  final Case caseDetails;

  @override
  State<PostedCaseDetailsScreen> createState() =>
      _PostedCaseDetailsScreenState();
}

class _PostedCaseDetailsScreenState extends State<PostedCaseDetailsScreen> {
  late String formattedDate =
      "${widget.caseDetails.date.day}/${widget.caseDetails.date.month}/${widget.caseDetails.date.year}";

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posted Case Details",
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
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return EditCaseScreen(
                                    caseData: widget.caseDetails,
                                  );
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            child: const Text("Edit Case"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // have logic of the users who took the cases be notified
                              db
                                  .collection("cases")
                                  .doc(widget.caseDetails.id)
                                  .delete();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.red[500],
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              "Close Case",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
