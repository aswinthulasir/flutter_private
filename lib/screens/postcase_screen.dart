import 'package:court_project/configs/local_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCasePage extends StatefulWidget {
  const PostCasePage({super.key});

  @override
  PostCasePageState createState() => PostCasePageState();
}

class PostCasePageState extends State<PostCasePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _mobileController = TextEditingController();
  final _advocateNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post a Case",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade900,
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  hint: const Text("Select State"),
                  value: _selectedState,
                  decoration: InputDecoration(
                    labelText: "State",
                    labelStyle: TextStyle(color: Colors.orange.shade900),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade900),
                    ),
                  ),
                  onChanged: (newValue) async {
                    print(await LocalDatabase().getKeralaCourtComplexes());
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
                  items: [DropdownMenuItem(child: Text("Kerala"), value: "KL")],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
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
