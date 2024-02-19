import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/student_module/camera/camera.dart';
import 'package:fire_new/entity/student_module/profile_stu/update1.dart';
import 'package:fire_new/entity/student_module/status/status.dart';
import 'package:fire_new/entity/student_module/report/date_report.dart';
import 'package:fire_new/entity/teacher_module/profile/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'student_module/count_reoprt/count_drop.dart';
import 'student_module/monthly_report/details.dart';

class student extends StatefulWidget {
  const student({Key? key}) : super(key: key);

  @override
  State<student> createState() => _studentState();
}

class _studentState extends State<student> {
  double screenHeight = 0;
  double screenWidth = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.width;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        title: Text("HOME - Student"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => login(
                    onClickedSignUp: () {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 55, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => details(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/monthly_report.png'),
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Monthly Report",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 55, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => update1(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/crede.png'),
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Profile",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => camera(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/barcode.png'),
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Scan Camera",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();

      print('User signed out successfully.');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
