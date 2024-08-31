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
  final _selectedState = signal<String?>("Kerala");
  final _selectedDistrict = signal<String?>(null);
  final _selectedCourt = signal<String?>(null);

  final db = FirebaseFirestore.instance;

  get onSelected => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Case"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _selectedCourt.value = null;
                _selectedDate.value = null;
                _selectedDistrict.value = null;
                _selectedState.value = null;
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        label: const Row(
                          children: [
                            Text(
                              "Reset",
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.clear,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                        onSelected: (_) {
                          setState(() {
                            _selectedCourt.value = null;
                            _selectedDate.value = null;
                            _selectedDistrict.value = null;
                            _selectedState.value = null;
                          });
                        }),
                    const SizedBox(
                      width: 10,
                    ),
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
                            pickedDate!.millisecondsSinceEpoch,
                          );
                        });
                      },
                      label: Text(_selectedDate.value == null
                          ? "Date"
                          : formatDate(_selectedDate.value!.toDate())),
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
                      label: Text(_selectedState.value == null
                          ? "State"
                          : "State: ${_selectedState.value}"),
                      avatar: const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                                        .getListOfDistricts(
                                            _selectedState.value ?? "Kerala")
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
                      label: Text(_selectedDistrict.value == null
                          ? "District"
                          : "District: ${_selectedDistrict.value}"),
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
                                      .getListOfCourts(
                                    _selectedDistrict.value ??
                                        "Thiruvananthapuram",
                                  )
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
                              ),
                            );
                          },
                        );
                      },
                      label: Text(_selectedCourt.value == null
                          ? "Court"
                          : "Court: ${_selectedCourt.value}"),
                      avatar: const Icon(
                        Icons.arrow_drop_down,
                      ),
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

  formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
