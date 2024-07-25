import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCasePage extends StatefulWidget {
  const PostCasePage({super.key});

  @override
  PostCasePageState createState() => PostCasePageState();
}

class PostCasePageState extends State<PostCasePage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _dateController = TextEditingController();
  final _advocateNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedCourtComplex;
  String? _selectedCourt;

  final Map<String, List<String>> _stateDistrictMap = {
    "State1": ["District1", "District2"],
    "State2": ["District3", "District4"],
    // Add all states or ill share db
  };

  final Map<String, List<String>> _districtCourtComplexMap = {
    "District1": ["Complex1", "Complex2"],
    "District2": ["Complex3", "Complex4"],
    // Add all districts or use db
  };

  final Map<String, List<String>> _courtComplexCourtMap = {
    "Complex1": ["Court1", "Court2"],
    "Complex2": ["Court3", "Court4"],
    // Add all court complexes. ill share db of it
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post a Case"),
        backgroundColor: Colors.orange.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile No.",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    suffixIcon: Icon(Icons.calendar_today,
                        color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
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
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  hint: Text("Select State"),
                  value: _selectedState,
                  decoration: InputDecoration(
                    labelText: "State",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedState = newValue;
                      _selectedDistrict = null;
                      _selectedCourtComplex = null;
                      _selectedCourt = null;
                    });
                  },
                  items: _stateDistrictMap.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                if (_selectedState != null)
                  DropdownButtonFormField<String>(
                    hint: Text("Select District"),
                    value: _selectedDistrict,
                    decoration: InputDecoration(
                      labelText: "District",
                      labelStyle: TextStyle(color: Colors.orange.shade900),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade900),
                      ),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDistrict = newValue;
                        _selectedCourtComplex = null;
                        _selectedCourt = null;
                      });
                    },
                    items: _stateDistrictMap[_selectedState]!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
                if (_selectedDistrict != null)
                  DropdownButtonFormField<String>(
                    hint: Text("Select Court Complex"),
                    value: _selectedCourtComplex,
                    decoration: InputDecoration(
                      labelText: "Court Complex",
                      labelStyle: TextStyle(color: Colors.orange.shade900),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade900),
                      ),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCourtComplex = newValue;
                        _selectedCourt = null;
                      });
                    },
                    items: _districtCourtComplexMap[_selectedDistrict]!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
                if (_selectedCourtComplex != null)
                  DropdownButtonFormField<String>(
                    hint: Text("Select Court"),
                    value: _selectedCourt,
                    decoration: InputDecoration(
                      labelText: "Court",
                      labelStyle: TextStyle(color: Colors.orange.shade900),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade900),
                      ),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCourt = newValue;
                      });
                    },
                    items: _courtComplexCourtMap[_selectedCourtComplex]!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _advocateNameController,
                  decoration: InputDecoration(
                    labelText: "Advocate Name",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter advocate name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Give a description of your case",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
                    ),
                  ),
                  maxLines: 4,
                  maxLength: 1000,
                ),
                SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Implement post case logic
                      }
                    },
                    height: 50,
                    color: Colors.orange[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "Post Case",
                        style: TextStyle(
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
