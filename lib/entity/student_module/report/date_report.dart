import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class date_report extends StatefulWidget {
  const date_report({super.key});

  @override
  State<date_report> createState() => _date_reportState();
}

class _date_reportState extends State<date_report> {
  @override
  Color primary = Color.fromARGB(252, 24, 200, 153);

  //DateTime _dateTime = DateTime.now();
  //String _dateTime = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //DateFormat _dateTime = DateFormat('dd-MM-yyyy');

  double screenWidth = 0;
  double screenHeight = 0;

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  TextEditingController nk = new TextEditingController();
  TextEditingController _date = TextEditingController();

  String _selectedCourse = "MSCIT";
  var course = {'MSCIT': 'im', 'BCA': 'bc', 'BSCIT': 'bs', 'MCA': 'mc'};

  List _course = [];
  CourseDependentDropDown() {
    course.forEach((key, value) {
      _course.add(key);
    });
  }

  String _selectedYear = "FYBSCIT";
  var year = {
    'FYBCA': 'bc',
    'SYBCA': 'bc',
    'TYBCA': 'bc',
    'FYMSCIT': 'im',
    'SYMSCIT': 'im',
    'FYBSCIT': 'bs',
    'SYBSCIT': 'bs',
    'TYBSCIT': 'bs',
    'FYMCA': 'mc',
    'SYMCA': 'mc',
  };

  List _year = [];
  YearDependentDropDown(CourseShortName) {
    year.forEach((key, value) {
      if (CourseShortName == value) {
        _year.add(key);
      }
    });
    _selectedYear = _year[0];
  }

  String _selectedSub = "pmt";
  var sub = {
    'c': "FYBCA",
    'cloud': "FYMSCIT",
    'es': "FYBCA",
    'networkprogramming': "FYMSCIT",
    'ldp': "FYBCA",
    'ml': "FYMSCIT",
    'html': "FYBCA",
    'cryptography': "FYMSCIT",
    'c++': "SYBCA",
    'webpro with java': "SYMSCIT",
    'math': "SYBCA",
    'big data analysis': "SYMSCIT",
    'javascript': "SYBCA",
    'block chain': "SYMSCIT",
    'angular': "SYBCA",
    'robotics': "SYMSCIT",
    'java': "TYBCA",
    'math2': "TYBCA",
    'css': "TYBCA",
    'french language': "TYBCA",
    'psp': "FYBSCIT",
    'html&css': "FYBSCIT",
    'french': "FYBSCIT",
    'pmt': "FYBSCIT",
    'opps': "SYBSCIT",
    'xml': "SYBSCIT",
    'os': "SYBSCIT",
    'data structure': "SYBSCIT",
    'python': "TYBSCIT",
    'ai': "TYBSCIT",
    'information security': "TYBSCIT",
    'se': "TYBSCIT",
    'ai and computing': "FYMCA",
    'webapp': "FYMCA",
    'iml': "FYMCA",
    'cybersecurity': "FYMCA",
    'datascience': "SYMCA",
    'computer_network': "SYMCA",
    'ethical_hacking': "SYMCA",
    'designpattern': "SYMCA",
  };

  List _sub = [];
  SubDependentDropDown(subShortName) {
    sub.forEach((key, value) {
      if (subShortName == value) {
        _sub.add(key);
      }
    });
    _selectedSub = _sub[0];
  }

  String dropdownvalue2 = 'A';

  final List<String> items2 = [
    'A',
    'B',
    'C',
  ];
/*
  String year1 = 'FY';

  final List<String> year11 = ['FY', 'SY', 'TY'];

  String course1 = 'MSCIT';

  final List<String> course11 = [
    'MSCIT',
    'BCA',
    'MCA',
    'BSCIT',
  ];*/

  void initState() {
    // TODO: implement initState
    super.initState();
    CourseDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    String course2 = _selectedYear + "_PRESENT";
    print(course2 + " i am nirmal bhuva");
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        title: SingleChildScrollView(
          child: Center(
            child: Row(
              children: [
                //SizedBox(
                //  height: 23,
                //),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Course",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width:
                        constraints.maxWidth > 80 ? 80 : constraints.maxWidth,
                    child: DropdownButton(
                      value: _selectedCourse,
                      onChanged: (newValue) {
                        setState(() {
                          _year = [];
                          _sub = [];
                          YearDependentDropDown(course[newValue]);
                          _selectedCourse = "$newValue";
                        });
                      },
                      items: _course.map((course) {
                        return DropdownMenuItem(
                          child: new Text(course),
                          value: course,
                        );
                      }).toList(),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text('Year'),
                ),
                SizedBox(
                  height: 23,
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      width:
                          constraints.maxWidth > 80 ? 80 : constraints.maxWidth,
                      child: DropdownButton(
                        value: _selectedYear,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            print(newValue);
                            _sub = [];
                            SubDependentDropDown(newValue);

                            _selectedYear = "$newValue";
                          });
                        },
                        items: _year.map((year) {
                          return DropdownMenuItem(
                            child: new Text(year),
                            value: year,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text('Division'),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        width: constraints.maxWidth > 40
                            ? 40
                            : constraints.maxWidth,
                        child: DropdownButton(
                          value: dropdownvalue2,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: items2.map((String items2) {
                            return DropdownMenuItem(
                                value: items2, child: Text(items2));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue2 = newValue!;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      //--------------------

      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(course2)
                //.where("course", isEqualTo: widget.value1)
                //.where("div", isEqualTo: widget.value2)
                //.where("year", isEqualTo: widget.value3 ?? "year")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //.where("subject", isEqualTo: "jio")

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(document.id.toString()),
                    subtitle: Text(document.data().toString()),
                  );
                }).toList(),
              );
            },

          ),
        ),
      ),
    );
  }
}
