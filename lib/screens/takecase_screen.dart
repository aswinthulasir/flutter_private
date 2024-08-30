import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/controllers/court_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/widgets/case_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class TakecaseScreen extends StatefulWidget {
  const TakecaseScreen({super.key});

  @override
  State<TakecaseScreen> createState() => _TakecaseScreenState();
}

class _TakecaseScreenState extends State<TakecaseScreen> {
  final _selectedDate = signal<Timestamp?>(null);
  final _selectedState = signal<String?>(null);
  final _selectedDistrict = signal<String?>(null);
  final _selectedCourt = signal<String?>(null);

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
                      onSelected: (_) async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        setState(() {
                          _selectedDate.value =
                              Timestamp.fromMillisecondsSinceEpoch(
                            DateTime.now().millisecondsSinceEpoch,
                          );
                        });
                      },
                      label: Text(_selectedDate.value == null
                          ? "Date"
                          : _selectedDate.value!.toDate().toString()),
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
                                          setState(() {
                                            _selectedState.value = e;
                                          });
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
                                          setState(() {});
                                          _selectedDistrict.value = e;
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
                                            setState(() {
                                              _selectedCourt.value = e;
                                            });
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
              child: Watch.builder(
                dependencies: [_selectedDate],
                builder: (context) {
                  return FutureBuilder(
                    future: CaseController().getCases(
                      state: _selectedState.value,
                      district: _selectedDistrict.value,
                      date: _selectedDate.value?.toDate().toString(),
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
                          return CaseCardListTile(
                            caseData: cases[index],
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
