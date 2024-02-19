import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/admin_module/new_teacher/addTeacher.dart';
import 'package:fire_new/entity/admin_module/pdf2/pdf2.dart';
import 'package:fire_new/entity/teacher_module/attendence/check.dart';
import 'package:fire_new/entity/teacher_module/pdf/pdf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

String? name;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const pdf2(),
    );
  }
}

/*

class MyFirebaseClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;
  String? name;
}*/

class pdf2 extends StatefulWidget {
  const pdf2({super.key});

  @override
  State<pdf2> createState() => _pdf2State();
}

class _pdf2State extends State<pdf2> {


  @override
  void initState() {
    getDocumentDataByEmail();
    print("hello i am,$name");

    super.initState();
  }

  Future<String?> getDocumentDataByEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    late User? user;
    user = _auth.currentUser!;
    final email = user.email;
    final snapshot = await FirebaseFirestore.instance
        .collection("Admin_data")
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      setState(() {
        name = snapshot.docs.first['name'];
      });
      print('Document ID hello: $docId, Name: $name');
    }
  }


  final _formKey = GlobalKey<FormState>();


  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text('$name'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
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
                                  hintText: 'Course',
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
                                  hintText: 'Year',
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
                            "Sem",
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
                                  hintText: 'Sem',
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
                            "Div",
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
                                  hintText: 'Div',
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
                            "Sub",
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
                                  hintText: 'Sub',
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
                      ],
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final snackBar = SnackBar(
                            content: const Text(
                                'Your data has been sent to the database'),
                            action: SnackBarAction(
                                label: 'Undo', onPressed: () async {}),
                          );
                          // Navigator to the next page.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                // Builder for the nextpage
                                // class's constructor.
                                builder: (context) => pdff(
                                    // Date as arguments to
                                    // send to next page.
                                    value: name, //name
                                    value1: course3, //course
                                    value2: div3, //div
                                    value3: year3, //year
                                    value4: sub3, //sub,
                                    value5: sem3 //sem
                                    )),
                          );
                        }
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
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
