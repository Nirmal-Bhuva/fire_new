import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/teacher_module/profile/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// import 'dart:html';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: profile1(),
    );
  }
}

class profile1 extends StatefulWidget {
  const profile1({super.key});

  @override
  State<profile1> createState() => _profile1State();
}

class _profile1State extends State<profile1> {
  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;
  final _formKey = GlobalKey<FormState>();

  final controllerName2 = TextEditingController();

  var itemIndex = [];

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: controllerName2,
                    /*keyboardType: TextInputType.number, //for numberic keyboard
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],*/
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      icon: Icon(
                        Icons.numbers,
                        color: Colors.purple[800],
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      hintText: 'Enrollment No',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Enrollment No',
                      labelStyle: TextStyle(color: Colors.purple[800]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 23),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select Course",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('A_Course')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
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
                const SizedBox(height: 23),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select Year",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('A_Year')
                        .where("course", isEqualTo: course3)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return DropdownButtonFormField<String>(
                        value: year3,
                        items: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return DropdownMenuItem<String>(
                            value: document.get('year'),
                            child: Text(document.get('year')),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            year3 = value;
                            sem3 = null;
                            sub3 = null;
                            div3 = null;
                          });
                        },
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
                const SizedBox(height: 23),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Semester",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('A_Sem')
                        .where("course", isEqualTo: course3)
                        .where("year", isEqualTo: year3)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return DropdownButtonFormField<String>(
                        value: sem3,
                        items: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return DropdownMenuItem<String>(
                            value: document.get('sem'),
                            child: Text(document.get('sem')),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            sem3 = value;
                            sub3 = null;
                            div3 = null;
                          });
                        },
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
                const SizedBox(height: 23),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select Division",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 23),
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
                            //sem3 = null;
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
                const SizedBox(height: 23),
                ElevatedButton(
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  onPressed: () {
                    // Navigator to the next page.
                   /* Navigator.of(context).push(
                      MaterialPageRoute(
                          // Builder for the nextpage
                          // class's constructor.
                          builder: (context) => update(
                                // Date as arguments to
                                // send to next page.
                                value: controllerName2.text, //no
                                value1: course3, //course
                                value2: year3, //year(fy/sy/ty)
                                value3: div3, //div
                              )),
                    );*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
