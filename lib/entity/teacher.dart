import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/teacher_module/between_dates/between.dart';
import 'package:fire_new/entity/teacher_module/date_report/date_report.dart';
import 'package:fire_new/entity/teacher_module/attendence/show_student_att.dart';
import 'package:fire_new/entity/teacher_module/pdf/details.dart';
import 'package:fire_new/entity/teacher_module/profile/profile.dart';
import 'package:fire_new/entity/teacher_module/report/report1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'teacher_module/student_list/student_list.dart';

class teacher extends StatefulWidget {
  const teacher({Key? key}) : super(key: key);

  @override
  State<teacher> createState() => _teacherState();
}

class _teacherState extends State<teacher> {
  double screenHeight = 0;
  double screenWidth = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.width;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        title: Text("HOME - Teacher"),
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
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => show_s(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        /*margin: EdgeInsets.only(
                          top: screenHeight / 35,
                          bottom: screenHeight / 3,
                        ),*/
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/mark_attendence.png'),
                            // alignment: Alignment.,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Attendence",
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
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => date_report(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        /*margin: EdgeInsets.only(
                          top: screenHeight / 70,
                          bottom: screenHeight / 3,
                        ),*/
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/daily_report.png'),
                            // alignment: Alignment.,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Date wise Present",
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
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => profile(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/update_profile.png'),
                            // alignment: Alignment.bottomLeft,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const pdf1(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/report_management.png'),
                            // alignment: Alignment.bottomLeft,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Generate today report",
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
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const s_list(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/daily.png'),
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Student List",
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
