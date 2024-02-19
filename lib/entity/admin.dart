import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/admin_module/add_crede/add_course.dart';
import 'package:fire_new/entity/admin_module/generate_id/generate_id.dart';
import 'package:fire_new/entity/admin_module/pdf2/details1.dart';
import 'package:fire_new/entity/admin_module/show_teacher/show_user.dart';
import 'package:fire_new/entity/admin_module/new_teacher/addTeacher.dart';
import 'package:fire_new/entity/teacher_module/pdf/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'admin_module/new_stu/add_student.dart';
import 'admin_module/student_list/student_list.dart';

class admin extends StatefulWidget {
  admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  double screenHeight = 0;
  double screenWidth = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
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
        backgroundColor: Colors.deepPurple,
        title: Text("HOME - Admin"),
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
                    padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => addTeacher(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/add_teache_2.png'),
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
                            "Add Teacher",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => data_manager(),
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
                            "Teacher List",
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

              // -----------------------
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const addStudent(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        /*margin: EdgeInsets.only(
                              top: screenHeight / 40,
                              bottom: screenHeight / 3,
                            ),*/
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/add_stu.png'),
                            // alignment: Alignment.bottomLeft,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "New Student",
                            textAlign: TextAlign.center,
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
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const add_crede(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        /*margin: EdgeInsets.only(
                              top: screenHeight / 40,
                              bottom: screenHeight / 3,
                            ),*/
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/crede.png'),
                            // alignment: Alignment.bottomLeft,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Add Credentials",
                            textAlign: TextAlign.center,
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
              // ------------------
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const pdf2(),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 1.9,
                        width: screenWidth / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          image: const DecorationImage(
                            image: AssetImage('assets/a1/view_re.png'),
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
                            "View Report",
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
