import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:court_project/widgets/posted_and_taken_case_list_tile.dart';
import 'package:flutter/material.dart';

class PostedCaseScreen extends StatefulWidget {
  const PostedCaseScreen({super.key});

  @override
  State<PostedCaseScreen> createState() => _PostedCaseScreenState();
}

class _PostedCaseScreenState extends State<PostedCaseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posted Cases"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: CaseController().getPostedCases(
                  LocalDatabase().getUserId()!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
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
                        isPosted: true,
                        caseData: cases[index],
                        color: Colors.yellow[50]!,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete Case"),
                                content: const Text(
                                    "Are you sure you want to delete this case?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        CaseController()
                                            .deleteCase(cases[index].id);
                                      });
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
