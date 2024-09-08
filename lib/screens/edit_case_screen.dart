import 'package:court_project/controllers/case_controller.dart';
import 'package:court_project/controllers/court_controller.dart';
import 'package:court_project/models/case_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

class EditCaseScreen extends StatefulWidget {
  const EditCaseScreen({super.key, required this.caseData});

  final Case caseData;

  @override
  EditCaseScreenState createState() => EditCaseScreenState();
}

class EditCaseScreenState extends State<EditCaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _advocateNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  final _selectedState = signal<String>("Kerala");
  final _selectedDistrict = signal<String?>(null);
  final _selectedCourtComplex = signal<String?>(null);

  late final _selectedDistricts = computed(() {
    return CourtController().getListOfDistricts(_selectedState.value);
  });

  late final _selectedCourtComplexes = computed(() {
    if (_selectedDistrict.value != null) {
      return CourtController().getListOfCourts(_selectedDistrict.value!);
    }
    return null;
  });

  final _selectedDate = signal<DateTime>(DateTime.now());
  final _caseController = CaseController();

  @override
  void initState() {
    _selectedDate.value = widget.caseData.date;
    _mobileController.text = widget.caseData.mobileNumber.toString();
    _advocateNameController.text = widget.caseData.advocateName;
    _descriptionController.text = widget.caseData.caseDescription;
    _selectedDistrict.value = widget.caseData.district;
    _selectedState.value = widget.caseData.state;
    _selectedCourtComplex.value = widget.caseData.court;
    _dateController.text =
        "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Case",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile No.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate.value = pickedDate;
                        _dateController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  hint: const Text("Select State"),
                  value: _selectedState.value,
                  decoration: InputDecoration(
                    labelText: "State",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (newValue) async {
                    setState(() {
                      _selectedState.value = newValue ?? "Kerala";
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "Kerala",
                      child: Text("Kerala"),
                    ),
                    DropdownMenuItem(
                      value: "Coming",
                      child: Text("Coming Soon"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _selectedDistricts.value.isNotEmpty
                    ? DropdownButtonFormField(
                        hint: const Text("Select District"),
                        value: _selectedDistrict.value,
                        decoration: InputDecoration(
                          labelText: "District",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _selectedDistricts.value
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDistrict.value = value ?? "Trivandrum";
                          });
                        })
                    : const SizedBox(),
                const SizedBox(height: 20),
                _selectedCourtComplexes.value != null
                    ? Column(
                        children: [
                          DropdownButtonFormField(
                              value: _selectedCourtComplex.value,
                              decoration: InputDecoration(
                                labelText: "Court Complex",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: _selectedCourtComplexes.value!
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                _selectedCourtComplex.value =
                                    value ?? "Trivandrum District Court";
                              }),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(),
                TextFormField(
                  controller: _advocateNameController,
                  decoration: InputDecoration(
                    labelText: "Advocate Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter advocate name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description of case",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 2,
                  maxLength: 1000,
                ),
                const SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Implement edit case logic
                        _caseController
                            .editCase(
                          caseId: widget.caseData.id,
                          mobileNumber: int.parse(_mobileController.text),
                          date: _selectedDate.value,
                          state: _selectedState.value,
                          district: _selectedDistrict.value!,
                          court: _selectedCourtComplex.value!,
                          advocateName: _advocateNameController.text,
                          caseDescription: _descriptionController.text,
                        )
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Case edited successfully"),
                            ),
                          );
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err.toString()),
                            ),
                          );
                        });
                      }
                    },
                    height: 60,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit Edit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
