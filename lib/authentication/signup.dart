import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fire_new/snackbar/Utils.dart';
import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/main.dart';
import 'package:fire_new/authentication/AuthPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'forgetpass.dart';

class signup extends StatefulWidget {
  final Function() onClickedSignIn;

  const signup({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _obsecureText = true;

  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final ernoController = TextEditingController();
  final nameController = TextEditingController();
  final rollnumController = TextEditingController();

  double screenWidth = 0;
  double screenHeight = 0;
  @override
  void dispose() {
    nameController.dispose();
    //emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    ernoController.dispose();
    rollnumController.dispose();
    emailController.dispose();

    super.dispose();
  }

  String? email;
  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    bool _isEmailValid = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SIGN UP PAGE UPPER CONTAINER
                  Container(
                      height: screenHeight / 3.9,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        // color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(75),
                          bottomLeft: Radius.circular(75),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: screenWidth / 4.5,
                        ),
                      )),

                  // SIGN UP TEXT
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight / 15, bottom: screenWidth / 35),
                    child: const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 121, 24, 139),
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // NAME TEXT AREA
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                        controller: nameController,
                        cursorColor: Colors.purple[800],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Enter your Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Name',
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

                  // EMAIL TEXT AREA
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
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Email',
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
                  const SizedBox(height: 30),

                  // EMAIL VERIFIED CHECKER - COURSE PICKER
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
                                    prefixIcon: Icon(
                                      Icons.book,
                                      color: Colors.purple[800],
                                    ),
                                    hintText: 'Course',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.purple),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                  const SizedBox(height: 30),

                  // COURSE CHECKER - YEAR PICKER
                  _isEmailValid
                      ? Container()
                      : Container(
                          width: 360,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('A_Year')
                                .where("course", isEqualTo: course3)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return Visibility(
                                visible: !emailController.text
                                    .endsWith("@glsica.com"),
                                child: DropdownButtonFormField<String>(
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
                                  enableFeedback: !emailController.text
                                      .endsWith('@glsica.com'),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.purple[800],
                                    ),
                                    hintText: 'Year',
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

                  const SizedBox(height: 30),

                  // YEAR CHECKER - SEMESTER PICKER
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
                                    prefixIcon: Icon(
                                      Icons.menu_book,
                                      color: Colors.purple[800],
                                    ),
                                    hintText: 'Semester',
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

                  const SizedBox(height: 30),

                  // SEMESTER CHECKER - DIVISION PICKER
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
                                    prefixIcon: Icon(
                                      Icons.abc_rounded,
                                      size: 40,
                                      color: Colors.purple[800],
                                    ),
                                    hintText: 'Division',
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

                  // PASSWORD TEXT AREA
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
                        labelText: 'Password',
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
                          Icons.password,
                          color: Colors.purple[800],
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          child: Icon(
                            _obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.purple[800],
                          ),
                        ),
                      ),
                      obscureText: _obsecureText,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (pass) =>
                          pass != null && pass != null && pass.length < 6
                              ? 'Enter at least 6 Characters'
                              : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CONFIRM PASSWORD TEXT AREA
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                        maxLength: 10,
                        controller: password2Controller,
                        cursorColor: Colors.purple[800],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Confirm Password',
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
                            Icons.password,
                            color: Colors.purple[800],
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: Icon(
                              _obsecureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.purple[800],
                            ),
                          ),
                        ),
                        obscureText: _obsecureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (pass) {
                          if (pass != passwordController.text) {
                            return 'Password should be Match';
                          } else {
                            return null;
                          }
                        }),
                  ),

                  const SizedBox(height: 40),

                  // SIGN UP BUTTON
                  Padding(
                    padding: const EdgeInsets.fromLTRB(125, 0, 125, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Colors.deepPurple,
                        elevation: 10,
                      ),
                      onPressed: signup,
                      child: Text("Sign Up"),
                    ),
                  ),

                  SizedBox(height: 30),

                  // LOG IN REDIRECT LINK
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 9, 6, 6),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      text: 'Already have an Account? ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: 'Log In',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.purple[800],
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  //----------------------------------------
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signup() async {
    final isValid = formKey.currentState!.validate();

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
      var log1 = "Student_data";

      if (role == "Student") {
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
      CollectionReference ref1 = FirebaseFirestore.instance.collection(log1);

      //QuerySnapshot snapshot = await ref.get();
      //List<DocumentSnapshot> existingDocuments = snapshot.docs;
      //String newIndex = (existingDocuments.length + 1).toString();
      QuerySnapshot snapshot = await ref.get();
      //List<DocumentSnapshot> existingDocuments = snapshot.docs;
      int newIndexInt = (await ref.get()).size + 1;
      String newIndex = "${course3}${DateTime.now().year}$newIndexInt";
      String newIndex2 = "${course3}${DateTime.now().year}$newIndexInt";
      String newIndex1 = "${DateTime.now().year}$newIndexInt";
      int numDocs = snapshot.size;

      String? rollNumber;
      // Generate a roll number based on the number of existing documents
      int rollNumberInt = (await ref.get()).size + 1;

      rollNumber = '${div3}${rollNumberInt.toString().padLeft(2, '0')}';

      ref1.doc(user!.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'id': newIndex,
        "course": course3,
        'roll no': rollNumber,
        "year": year3,
        "sem": sem3,
        "div": div3,
        'role': role,
      });

      if (email.endsWith('@glsica.com')) {
        ref.doc(user.uid).set({
          'name': nameController.text,
          'email': email,
          'id': newIndex1,
          'role': role,
        });
      } else if (email.endsWith('@imscit.com')) {
        ref.doc(user.uid).set({
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
        ref.doc(user.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'id': newIndex,
          'roll no': rollNumber,
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
