import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/student.dart';
import 'package:fire_new/entity/teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'date_output.dart';

class date_report extends StatefulWidget {
  const date_report({super.key});

  @override
  State<date_report> createState() => _date_reportState();
}

class _date_reportState extends State<date_report> {
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

  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    //CourseDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,

        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        //title: Text(currentDate),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Course",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Course')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return DropdownButtonFormField<String>(
                            value: course3,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.get('course_name'),
                                child: Text(document.get('course_name')),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                course3 = value;
                                year3 = null;
                                sem3 = null;
                                sub3 = null;
                                div3 = null;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Course',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Year",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Year')
                            .where("course", isEqualTo: course3)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          final itemList = snapshot.data!.docs
                              .map((doc) => doc['year'] as String)
                              .toList();

                          itemList.sort();
                          return DropdownButtonFormField<String>(
                            value: year3,
                            onChanged: (String? value) {
                              setState(() {
                                year3 = value;
                                sem3 = null;
                                sub3 = null;
                                div3 = null;
                              });
                            },
                            items: itemList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Select Year',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Semester",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Sem')
                            //.where('year', isEqualTo: )
                            .where('course', isEqualTo: course3)
                            .where('year', isEqualTo: year3)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          final itemList = snapshot.data!.docs
                              .map((doc) => doc['sem'] as String)
                              .toList();

                          itemList.sort();

                          return DropdownButtonFormField<String>(
                            value: sem3,
                            onChanged: (value) {
                              setState(() {
                                sem3 = value;
                                div3 = null;
                                sub3 = null;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Semester',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                            items: itemList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Division",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Div')
                            //.where('year', isEqualTo: year3)
                            //.where('course', isEqualTo: course3)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          final itemList = snapshot.data!.docs
                              .map((doc) => doc['div'] as String)
                              .toList();

                          itemList.sort();

                          return DropdownButtonFormField<String>(
                            value: div3,
                            onChanged: (value) {
                              setState(() {
                                div3 = value;
                                sub3 = null;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Division',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                            items: itemList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Subject",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Sub')
                            .where('year', isEqualTo: year3)
                            .where('course', isEqualTo: course3)
                            .where('sem', isEqualTo: sem3)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          final itemList = snapshot.data!.docs
                              .map((doc) => doc['sub'] as String)
                              .toList();

                          itemList.sort();

                          return DropdownButtonFormField<String>(
                            value: sub3,
                            onChanged: (value) {
                              setState(() {
                                sub3 = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Subject',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                            items: itemList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _date,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          /*icon: Icon(
                            Icons.account_circle,
                            color: Colors.purple[800],
                          ),*/
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          hintText: 'Select Date',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Select Date',
                          labelStyle: TextStyle(color: Colors.purple[800]),
                        ),
                        /*validator: (value) {
                          if (value == null ||
                              value.isEmpty /*_entries.contains(value)*/) {
                            return 'Field is null or duplicate';
                          }
                          return null;
                        }*/
                        onTap: () async {
                          DateTime? pickedate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050));

                          if (pickedate != null) {
                            setState(() {
                              _date.text =
                                  DateFormat("dd-MM-yyyy").format(pickedate);
                              print(_date);
                            });
                          }
                        },
                        /*onSaved: (value) => setState(() {
                          _newEntry = value!;
                        }),*/
                      ),
                    ),

                    SizedBox(
                      height: 23,
                    ),
                    ElevatedButton(
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => date_output(
                                value: course3, //course
                                value1: div3, //div
                                value2: year3, //year
                                value3: nk.text, //name
                                value4: sub3, //sub
                                value5: _date.text,
                              ),
                            ),
                          );
                        }),
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
