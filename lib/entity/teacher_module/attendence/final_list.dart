import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/admin_module/show_teacher/show_user.dart';
import 'package:fire_new/entity/teacher.dart';
import 'package:fire_new/entity/teacher_module/attendence/show_student_att.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'check.dart';

var dates = [];
var attendence = [];

class final_list extends StatefulWidget {
  String? course = null;
  String? value4 = null;
  String? value2 = null;
  final_list(
      {super.key,
      required this.course,
      required this.value4,
      required this.value2 /*div*/});

  @override
  State<final_list> createState() => _final_listState();
}

class _final_listState extends State<final_list> {
  @override
  void initState() {
    // TODO: implement initState
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    getDocuments((widget.course! + "_PRESENT"),
        (currentDate + " " + widget.value2! + " " + widget.value4!));
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return WillPopScope(
        child: Scaffold(
          //key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              "Date = $currentDate",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
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
            backgroundColor: Color.fromARGB(252, 24, 200, 153),
          ),

          body: Container(
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(widget.course! + "_PRESENT")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListTile(
                        title: /*Column(
                          children: [*/
                            Text(attendence.toString()),
                        /*ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        // Builder for the nextpage
                                        // class's constructor.
                                        builder: (context) => login(
                                              onClickedSignUp: () {},
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(249, 38, 168, 133),
                                ),
                                child: Text("Back")),
                          ],
                        ),*/
                      );
                    }
                    //},
                    ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          names.clear();
          itemIndex.clear();
          return true;
        });
  }

  Future<void> getDocuments(String cName, String docData) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection(cName).doc(docData).get();
    var snapData = snapshot.data().toString();

    print("hello");
    setState(() {
      attendence.clear();
      print(snapData);

      if (!attendence.contains(snapData)) attendence.add(snapData);
    });
  }

  Future<void> getListitems(String value) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(value).get();
    dates.clear();
    querySnapshot.docs
        .map((doc) => setState(() {
              dates.add(doc.id.toString());
            }))
        .toList();
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
