import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/controllers/court_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/widgets/case_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class TakecaseScreen extends StatefulWidget {
  const TakecaseScreen({super.key});

  @override
  State<TakecaseScreen> createState() => _TakecaseScreenState();
}

class _TakecaseScreenState extends State<TakecaseScreen> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Case"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      onSelected: (_) {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                      },
                      label: const Text("Date"),
                      avatar: const Icon(Icons.calendar_today),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                      onSelected: (_) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Select State"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: ["Kerala"].map((e) {
                                      return ListTile(
                                        title: Text(e),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            });
                      },
                      label: const Text("State"),
                      avatar: const Icon(Icons.arrow_drop_down),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                      onSelected: (_) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Select District"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: CourtController()
                                        .getListOfDistricts("Kerala")
                                        .map((e) {
                                      return ListTile(
                                        title: Text(e),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            });
                      },
                      label: const Text("District"),
                      avatar: const Icon(Icons.arrow_drop_down),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                      onSelected: (_) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title: const Text("Select Court"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: CourtController()
                                          .getListOfCourts("Thiruvananthapuram")
                                          .map((e) {
                                        return ListTile(
                                          title: Text(e),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ));
                            });
                      },
                      label: const Text("Court"),
                      avatar: const Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PaginateFirestore(
                itemBuilder: (context, snapshots, index) {
                  final Case caseData = Case.fromFirestore(
                    snapshots[index] as DocumentSnapshot<Map<String, dynamic>>,
                    null,
                  );
                  return CaseCardListTile(
                    caseData: caseData,
                  );
                },
                query: db.collection("cases").orderBy("date", descending: true),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
