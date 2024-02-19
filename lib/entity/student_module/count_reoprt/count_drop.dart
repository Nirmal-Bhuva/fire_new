import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/student.dart';
import 'package:fire_new/entity/student_module/count_reoprt/count.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class count_drop extends StatefulWidget {
  //final List<String> items;
  //final VoidCallback onClickedCD;

  const count_drop({
    super.key,
    //required this.onClickedCD,

    /*required this.items*/
  });

  @override
  State<count_drop> createState() => _count_dropState();
}

class _count_dropState extends State<count_drop> {
  @override
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  TextEditingController nk = new TextEditingController();

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

        //title: Text("HOME - Student"),
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

      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(_selectedYear)
              .where("div", isEqualTo: dropdownvalue2)
              .where("year", isEqualTo: _selectedYear)
              .where("course", isEqualTo: _selectedCourse)
              //.where("erno", isEqualTo: "1490")
              //.where("erno",isEqualTo: dropdownvalue22 )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(_selectedYear);
            print(_selectedCourse);

            //.where("subject", isEqualTo: "jio")
            //print(drop());

            return Column(
              children: [
                /*SizedBox(
                  height: 23,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text('Sub'),
                ),
                Container(
                  width: 150,
                  child: DropdownButton(
                    value: _selectedSub,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSub = "$newValue";
                      });
                    },
                    items: _sub.map((sub) {
                      return DropdownMenuItem(
                        child: new Text(sub),
                        value: sub,
                      );
                    }).toList(),
                  ),
                ),*/
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length, //values.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.docs[index].get("name"));
                        return GestureDetector(
                            child: ListTile(
                              title: Text(
                                  snapshot.data!.docs[index].get("erno") +
                                      " report"),
                            ),
                            onTap: () => {
                                  nk.text =
                                      snapshot.data!.docs[index].get("name"),
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => count(
                                        value: _selectedCourse, //course
                                        value1: dropdownvalue2, //div
                                        value2: _selectedYear, //year
                                        value3: nk.text, //name
                                        value4: _selectedSub, //sub
                                      ),
                                    ),
                                  )
                                });
                      }),
                ),
                ElevatedButton(
                    child: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(249, 38, 168, 133),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => student()),
                      );
                    }),
              ],
            );
          },
        ),
      )),
    );
  }
}
