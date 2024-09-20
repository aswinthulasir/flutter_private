import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/widgets/posted_and_taken_case_list_tile.dart';
import 'package:flutter/material.dart';

class TakenCasesScreen extends StatefulWidget {
  const TakenCasesScreen({super.key});

  @override
  State<TakenCasesScreen> createState() => _TakenCasesScreenState();
}

class _TakenCasesScreenState extends State<TakenCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taken Cases"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: CaseController().getTakenCases(
                  UserController.currentUserSignal.value!.userUID,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text("An error occurred"),
                    );
                  }
                  final cases = snapshot.data as List<Case>;

                  if (cases.isEmpty) {
                    return const Center(
                      child: Text("No cases found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: cases.length,
                    itemBuilder: (context, index) {
                      return PostedCaseCardListTile(
                        isPosted: false,
                        caseData: cases[index],
                        color: Colors.yellow[50]!,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete Case"),
                                content: const Text(
                                    "Are you sure you want to withdraw from this case?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      CaseController().removeTakenCase(
                                        cases[index].id,
                                        UserController
                                            .currentUserSignal.value!.userUID,
                                        cases[index].court,
                                        cases[index].userId,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
