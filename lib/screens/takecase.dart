import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TakeCasePage extends StatefulWidget {
  const TakeCasePage({super.key});

  @override
  _TakeCasePageState createState() => _TakeCasePageState();
}

class _TakeCasePageState extends State<TakeCasePage> {
  String? selectedState;
  String? selectedDistrict;
  List<String> states = [];
  List<String> districts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade900,
        title: Text("Take a Case"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade800,
                Colors.orange.shade400,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      hint: Text("State"),
                      value: selectedState,
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                          selectedDistrict = null;
                        });
                      },
                      items: states.map((state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      hint: Text("District"),
                      value: selectedDistrict,
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                        });
                      },
                      items: districts.map((district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: DateTime.now(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("District court",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CheckboxListTile(
                            title: Text("1. Case 1"),
                            value: false, // Implement your own state management
                            onChanged: (bool? value) {},
                          ),
                          CheckboxListTile(
                            title: Text("2. Case 2"),
                            value: false, // Implement your own state management
                            onChanged: (bool? value) {},
                          ),
                          Text("Sub court",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CheckboxListTile(
                            title: Text("1. Case 3"),
                            value: false, // Implement your own state management
                            onChanged: (bool? value) {},
                          ),
                          CheckboxListTile(
                            title: Text("2. Case 4"),
                            value: false, // Implement your own state management
                            onChanged: (bool? value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        // Take Case logic here
                      },
                      height: 50,
                      color: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Take Case",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
