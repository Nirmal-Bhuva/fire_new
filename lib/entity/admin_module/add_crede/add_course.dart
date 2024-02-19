import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class add_crede extends StatefulWidget {
  const add_crede({super.key});

  @override
  State<add_crede> createState() => _add_credeState();
}

class _add_credeState extends State<add_crede> {
  final coursename = TextEditingController(); //for course text
  final yearname = TextEditingController(); //for year text
  final divname = TextEditingController(); //for divtext
  final samname = TextEditingController(); //for subject text
  final subject = TextEditingController(); //for subject text

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();

  String? course2; //for year
  String? course3; //for div
  String? year3; //for div
  String? yearsam; //for sam
  String? coursesam; //for sam
  String? divsam; //for sam
  String? course44; //for sub
  String? year44; //for sub
  String? sam44; //for sub

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
        title: Text('Add Course and Division'),
      ),
      body: SingleChildScrollView(
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
                        "Add Course",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                      child: TextFormField(
                        controller: coursename,
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
                            Icons.account_circle,
                            color: Colors.purple[800],
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          hintText: 'Add Course',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Enter Course Name',
                          labelStyle: TextStyle(color: Colors.purple[800]),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) => coursename.text = value!,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final snackBar = SnackBar(
                            content: const Text(
                                'Your data has been sent to the Database'),
                          );
                          _formKey.currentState!.save();
                          FirebaseFirestore.instance
                              .collection("A_Course")
                              .doc(coursename.text)
                              .set({'course_name': coursename.text})
                              .then((value) => print('Data added to Firestore'))
                              .catchError((error) => print(
                                  'Error adding data to Firestore: $error'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                    ),
                  ],
                )),
            Form(
              key: _formKey2,
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            value: course2,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.get('course_name'),
                                child: Text(document.get('course_name')),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                course2 = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Course',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Year ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: yearname,
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
                          Icons.book,
                          color: Colors.purple[800],
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Enter Year',
                        hintStyle: TextStyle(color: Colors.grey),
                        //labelText: 'Add Div',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                      ),
                      validator: (value1) {
                        if (value1 == null || value1.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value1) => yearname.text = value1!,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your data has been sent to the database'),
                        );
                        _formKey2.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("A_Year")
                            .doc()
                            .set({'course': course2, 'year': yearname.text})
                            .then((value) => print('Data added to Firestore'))
                            .catchError((error) => print(
                                'Error adding data to Firestore: $error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey3,
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),

                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Division ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: divname,
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
                          Icons.book,
                          color: Colors.purple[800],
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Enter Division',
                        hintStyle: TextStyle(color: Colors.grey),
                        //labelText: 'Add Div',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) => divname.text = value!,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      _formKey3.currentState!.save();

                      if (_formKey3.currentState!.validate()) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your data has been sent to the database'),
                        );
                        _formKey3.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("A_Div")
                            .doc()
                            .set({
                              //'course': course3,
                              //'year': year3,
                              'div': divname.text,
                            })
                            .then((value) => print('Data added to Firestore'))
                            .catchError((error) => print(
                                'Error adding data to Firestore: $error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey4,
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            value: coursesam,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.get('course_name'),
                                child: Text(document.get('course_name')),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                coursesam = value;
                                yearsam = null;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Course',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Year",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          //.where('year', isEqualTo: )
                          .where('course', isEqualTo: coursesam)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final itemList = snapshot.data!.docs
                            .map((doc) => doc['year'] as String)
                            .toList();

                        itemList.sort();

                        return DropdownButtonFormField<String>(
                          value: yearsam,
                          onChanged: (value) {
                            setState(() {
                              yearsam = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            hintText: 'Select Year',
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
                      "Add Semister ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: samname,
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
                          Icons.book,
                          color: Colors.purple[800],
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Enter Semister',
                        hintStyle: TextStyle(color: Colors.grey),
                        //labelText: 'Add Div',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) => samname.text = value!,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey4.currentState!.validate()) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your data has been sent to the database'),
                        );
                        _formKey4.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("A_Sem")
                            .doc()
                            .set({
                              'course': coursesam,
                              'year': yearsam,
                              'sem': samname.text,
                            })
                            .then((value) => print('Data added to Firestore'))
                            .catchError((error) => print(
                                'Error adding data to Firestore: $error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey5,
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            value: course44,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.get('course_name'),
                                child: Text(document.get('course_name')),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                course44 = value;
                                year44 = null;
                                sam44 = null;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Course',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Year",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          //.where('year', isEqualTo: )
                          .where('course', isEqualTo: course44)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final itemList = snapshot.data!.docs
                            .map((doc) => doc['year'] as String)
                            .toList();

                        itemList.sort();

                        return DropdownButtonFormField<String>(
                          value: year44,
                          onChanged: (value) {
                            setState(() {
                              year44 = value;
                              sam44 = null;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            hintText: 'Select Year',
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
                      "Semester",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          .where('course', isEqualTo: course44)
                          .where('year', isEqualTo: year44)
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
                          value: sam44,
                          onChanged: (value) {
                            setState(() {
                              sam44 = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            hintText: 'Semester',
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
                      "Add Subject ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: subject,
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
                          Icons.book,
                          color: Colors.purple[800],
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Subject',
                        hintStyle: TextStyle(color: Colors.grey),
                        //labelText: 'Add Div',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value1) => subject.text = value1!,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey5.currentState!.validate()) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your data has been sent to the database'),
                        );
                        _formKey5.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("A_Sub")
                            .doc()
                            .set({
                              'course': course44,
                              'year': year44,
                              'sem': sam44,
                              'sub': subject.text,
                            })
                            .then((value) => print('Data added to Firestore'))
                            .catchError((error) => print(
                                'Error adding data to Firestore: $error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
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
    );
  }
}
