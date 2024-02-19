import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fire_new/entity/admin_module/show_teacher/show_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fire_new/snackbar/Utils.dart';

import '../../../main.dart';

class addTeacher extends StatefulWidget {
  const addTeacher({
    super.key,
  });

  @override
  State<addTeacher> createState() => addTeacherState();
}

class addTeacherState extends State<addTeacher> {
  //CollectionReference users2 = FirebaseFirestore.instance.collection('users2');
  @override
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  final controllerName = TextEditingController();
  final controllerSub = TextEditingController();
  //------------------------

  //--------------------
  /*
  String dropdownvalue = 'FY';

  final List<String> items = [
    'FY',
    'SY',
    'TY',
    'FY - SY',
    'SY - TY',
    'FY - TY',
    'FY - SY - TY'
  ];

  String dropdownvalue20 = 'BCA';

  final List<String> items20 = ['BCA', 'BSCIT', 'MSCIT', 'MCA'];

  String dropdownvalue2 = 'A';

  final List<String> items2 = [
    'A',
    'B',
    'C',
    'A - B',
    'B - C',
    'A - C',
    'A - B - C'
  ];
  */
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final ernoController = TextEditingController();
  final nameController = TextEditingController();

  bool _obsecureText = true;

  double screenWidth = 0;
  double screenHeight = 0;
  @override
  void dispose() {
    nameController.dispose();
    //emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    ernoController.dispose();
    emailController.dispose();

    super.dispose();
  }

  String? email;
  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;
  //String? course3; //for div
  //String? year3; //for div
  //String? div3; //for div
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    bool _isEmailValid = false;
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
        title: Text('Add Teacher'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                        controller: nameController,
                        cursorColor: Colors.purple[800],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Enter Name',
                          labelStyle: TextStyle(color: Colors.purple[800]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.purple[800],
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Enter your Name';
                          } /*else {
                        return null;
                      }*/
                        }),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: emailController,
                      onChanged: (value) {
                        setState(() {
                          _isEmailValid = value.endsWith("@glsica.com");
                        });
                      },
                      cursorColor: Colors.purple[800],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Enter Email',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.purple[800],
                        ),
                      ),
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid Email'
                              : null,
                    ),
                  ),

                  SizedBox(
                    height: 23,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _isEmailValid
                      ? Container()
                      : Container(
                          width: 360,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('A_Course')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return Visibility(
                                visible: !emailController.text
                                    .endsWith("@glsica.com"),
                                child: DropdownButtonFormField<String>(
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
                                ),
                              );
                            },
                          ),
                        ),

                  SizedBox(
                    height: 30,
                  ),
                  _isEmailValid
                      ? Container()
                      : Container(
                          width: 360,
                          child: Visibility(
                            visible:
                                !emailController.text.endsWith("@glsica.com"),
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
                        ),

                  SizedBox(
                    height: 30,
                  ),
                  _isEmailValid
                      ? Container()
                      : Container(
                          width: 360,
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

                              return Visibility(
                                visible: !emailController.text
                                    .endsWith("@glsica.com"),
                                child: DropdownButtonFormField<String>(
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    filled: true,
                                  ),
                                  items: itemList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ))
                                      .toList(),
                                ),
                              );
                            },
                          ),
                        ),

                  SizedBox(
                    height: 30,
                  ),
                  _isEmailValid
                      ? Container()
                      : Container(
                          width: 360,
                          child: Visibility(
                            visible:
                                !emailController.text.endsWith("@glsica.com"),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      maxLength: 10,
                      controller: passwordController,
                      cursorColor: Colors.purple[800],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Enter Password',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.purple[800],
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          child: Icon(_obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: _obsecureText,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (pass) =>
                          pass != null && pass != null && pass.length < 6
                              ? 'Enter min. 6 characters'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                        maxLength: 10,
                        controller: password2Controller,
                        cursorColor: Colors.purple[800],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(color: Colors.purple[800]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.purple[800],
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: Icon(_obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: _obsecureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (pass) {
                          if (pass != passwordController.text) {
                            return 'Password should Match';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ],
              ),
            ),

            //---------------------------

            //----------------------------------

            SizedBox(height: 20),
            Container(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(125, 0, 125, 0),
                child: ElevatedButton(
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.deepPurple,
                      elevation: 10,
                    ),
                    onPressed: signup),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future signup() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      var role = "";
      if (emailController.text.trim().contains("@imscit.com")) {
        role = "Teacher";
      } else if (emailController.text.trim().contains("@glsica.com")) {
        role = "Admin";
      } else {
        role = "Student";
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) =>
              {postDetailsToFirestore(emailController.text.trim(), role)});
    } on FirebaseAuthException catch (e) {
      print(e);

      utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;

    try {
      var log = "";
      if (role == "Student") {
        log = "Student_data";
        if (year3!.contains("FYBCA")) {
          log = "FYBCA";
        } else if (year3!.contains("SYBCA")) {
          log = "SYBCA";
        } else if (year3!.contains("TYBCA")) {
          log = "TYBCA";
        } else if (year3!.contains("FYMSCIT")) {
          log = "FYMSCIT";
        } else if (year3!.contains("SYMSCIT")) {
          log = "SYMSCIT";
        } else if (year3!.contains("FYBSCIT")) {
          log = "FYBSCIT";
        } else if (year3!.contains("SYBSCIT")) {
          log = "SYBSCIT";
        } else if (year3!.contains("TYBSCIT")) {
          log = "TYBSCIT";
        } else if (year3!.contains("FYMCA")) {
          log = "FYMCA";
        } else if (year3!.contains("SYMCA")) {
          log = "SYMCA";
        } else {
          print("not valid");
        }
      } else {
        if (role == "Teacher") {
          log = "Teacher_data";
          /*if (course3!.contains("BCA")) {
            log = "_BCA_teacher";
          } else if (course3!.contains("MSCIT")) {
            log = "_MSCIT_teacher";
          } else if (course3!.contains("MCA")) {
            log = "_MCA_teacher";
          } else {
            log = "_BSCIT_teacher";
          }
        } else {
          print("not valid");
        }*/
        } else if (role == "Admin") {
          log = "Admin_data";
        } else {
          print("not valid");
        }
      }
      CollectionReference ref = FirebaseFirestore.instance.collection(log);
      //QuerySnapshot snapshot = await ref.get();
      //List<DocumentSnapshot> existingDocuments = snapshot.docs;
      //String newIndex = (existingDocuments.length + 1).toString();
      QuerySnapshot snapshot = await ref.get();
      List<DocumentSnapshot> existingDocuments = snapshot.docs;
      int newIndexInt = existingDocuments.length + 1;
      String newIndex = "${course3}${DateTime.now().year}$newIndexInt";
      String newIndex2 = "${course3}${DateTime.now().year}$newIndexInt";
      String newIndex1 = "${DateTime.now().year}$newIndexInt";

      if (email.endsWith('@glsica.com')) {
        ref.doc(user!.uid).set({
          'name': nameController.text,
          'email': email,
          'id': newIndex1,
          'role': role,
        });
      } else if (email.endsWith('@imscit.com')) {
        ref.doc(user!.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'id': newIndex2,
          "course": course3,
          "year": year3,
          "sem": sem3,
          "div": div3,
          'role': role,
        });
      } else {
        ref.doc(user!.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'id': newIndex,
          "course": course3,
          "year": year3,
          "sem": sem3,
          "div": div3,
          'role': role,
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e);

      utils.showSnackBar(e.message);
    }
  }
}
