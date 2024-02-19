import 'dart:async';

import 'package:fire_new/snackbar/Utils.dart';
import 'package:fire_new/entity/teacher_module/attendence/final_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:random_string/random_string.dart';

import 'cmara_count.dart';

var names = [];
var itemIndex = [];

class check extends StatefulWidget {
  /* final String value1;
  final String value2;
  final String value3;
*/
  String? name = null; //name
  String? course = null; //course
  String? div = null; //div
  String? year = null; //year
  String? sub = null; //sub
  String? sem = null; //sem

  check(
      {super.key,
      required this.name,
      required this.course,
      required this.div,
      required this.year,
      required this.sub,
      required this.sem});

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  //final _auth = FirebaseAuth.instance;

  //late String _selectedValue;
  //late Stream<QuerySnapshot> selectedStream;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    /*
    for (String collectionName in collectionNames) {
      //filter the data by a specific field and value*/

    names.clear();
    super.initState();
  }

/*
  late String _selectedValue;
  late Stream<QuerySnapshot> selectedStream;
*/
  @override
  Widget build(BuildContext context) {
    //bool _isButtonDisabled = false;

    String sub = widget.sub!;
    print(sub + "i am nirmal bhuva"); //sub
    print("value = " + widget.name.toString()); //null
    print("course = " + widget.course.toString()); //course
    print("div = " + widget.div.toString()); //div
    print("year = " + widget.year.toString()); //year
    print("sub = " + widget.sub.toString()); //subject
    String generateTime = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
 // get the current time at the time of generate

/*
I/flutter ( 5610): ci am nirmal bhuva
I/flutter ( 5610): value = null
I/flutter ( 5610): course = BCA
I/flutter ( 5610): div = A
I/flutter ( 5610): year = FYBCA
I/flutter ( 5610): sub = c
*/
    //-----------------------------------------------------------------------------------------
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text(currentDate),
      ),

      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(sub).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            String randomString =
                "${widget.course}+${widget.div}+${widget.year}+${widget.sub}+${widget.sem}+${generateTime}";

            return Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: QrImage(
                    data: randomString,
                    version: QrVersions.auto,
                    size: 400.0,
                  ),
                ),
                ElevatedButton(
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    onPressed: () async {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Your data has been sent to the database'),
                        action: SnackBarAction(
                            label: 'Undo', onPressed: () async {}),
                      );
                      /*setState(() {
                        _isButtonDisabled = true;
                      });
                      Timer(Duration(minutes: 5), () {
                        setState(() {
                          _isButtonDisabled = false;
                        });
                      });
                      style:
                      ElevatedButton.styleFrom(
                        primary:
                            _isButtonDisabled ? Colors.grey : Colors.deepPurple,
                      );
                      // Add tooltip to inform user why the button is disabled
                      tooltip:
                      _isButtonDisabled
                          ? 'Please wait for 5 minutes before submitting again'
                          : '';*/

                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => camara_count(
                                sub: widget.sub,
                                year: widget.year,
                                div: widget.div,
                                sem: widget.sem)),
                      );

                      CollectionReference fycbaCollection =
                          FirebaseFirestore.instance.collection(widget.year!);
                      CollectionReference presentCollection = FirebaseFirestore
                          .instance
                          .collection(widget.year! + "_PRESENT");
                      String? currentDivSubString =
                          currentDate + ' ' + widget.div! + ' ' + widget.sub!;

// create a list to store absent students
                      List<String> absentStudents = [];

// get all documents from FYBCA collection
                      QuerySnapshot fybcaSnapshot = await fycbaCollection.get();

// loop through each document in FYBCA collection
                      for (var doc in fybcaSnapshot.docs) {
                        Map<String, dynamic> docData =
                            doc.data() as Map<String, dynamic>;

                        // get the name field from the current document
                        String studentRollno = docData['roll no'];
                        print("rollno" + studentRollno);

                        String studentName = docData['name'];
                        print("rollno" + studentName);

                        // check if the student is present in the div sub array
                        if (!currentDivSubString
                            .contains(studentRollno + " " + studentName)) {
                          // add the student name to the absent list
                          absentStudents.add(studentRollno + " " + studentName);
                        }
                      }

// check if the "a b" combination is in FYBCA_PRESENT collection
                      DocumentSnapshot presentDoc = await presentCollection
                          .doc(currentDate +
                              ' ' +
                              widget.div! +
                              ' ' +
                              widget.sub!)
                          .get();
                      Map<String, dynamic> presentData =
                          presentDoc.data() as Map<String, dynamic>;
                      List<String> presentStudents = (presentData["Div" +
                              "=" +
                              widget.div! +
                              " " +
                              "Sub" +
                              "=" +
                              widget.sub!] as List<dynamic>)
                          .cast<String>();

// check each absent student against the present students
                      for (var i = 0; i < absentStudents.length; i++) {
                        String student = absentStudents[i];
                        if (presentStudents.contains(student)) {
                          // remove the student from the absent list
                          absentStudents.removeAt(i);
                          i--;
                        }
                      }

// update the absent list in the current date div sub document
                      await presentCollection.doc(currentDivSubString).update(
                          {'absent': FieldValue.arrayUnion(absentStudents)});

//-------------------------------------------------------------------------
/*



                      CollectionReference fycbaCollection =
                          FirebaseFirestore.instance.collection('FYBCA');
                      CollectionReference presentCollection = FirebaseFirestore
                          .instance
                          .collection('FYBCA_PRESENT');
                      String? currentDivSubString =
                          currentDate + ' ' + widget.div! + ' ' + widget.sub!;
// create a list to store absent students
                      List<String> absentStudents = [];

// get all documents from FYBCA collection
                      QuerySnapshot fybcaSnapshot = await fycbaCollection.get();

// loop through each document in FYBCA collection
                      fybcaSnapshot.docs.forEach((doc) {
                        Map<String, dynamic> docData =
                            doc.data() as Map<String, dynamic>;

                        // get the name field from the current document
                        String studentRollno = docData['roll no'];
                        String studentName = docData['name'];

                        // check if the student is present in the div sub array
                        if (!currentDivSubString.contains(studentRollno)) {
                          // add the student name to the absent list
                          absentStudents.add(studentRollno + " " + studentName);
                        }
                      });

// update the absent list in the current date div sub document
                      await presentCollection.doc(currentDivSubString).update(
                          {'absent': FieldValue.arrayUnion(absentStudents)});
*/

//------------------------------------------------------------------------------------
                      /*final TextEditingController _nameController =
                          TextEditingController();
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;

                      Map<String, List<dynamic>> absentNames = {};
                      final QuerySnapshot fybcaDocs =
                          await firestore.collection(widget.year!).get();

                      // Iterate through fybca docs
                      await Future.forEach(fybcaDocs.docs, (fybcaDoc) async {
                        // Check div field
                        final String div = fybcaDoc['div'];
                        if (div == widget.div) {
                          // Div is A, fetch fybca_present document for this index
                          final String index = fybcaDoc.id;
                          final DocumentReference fybcaPresentDoc = firestore
                              .collection(widget.year! + "_PRESENT")
                              .doc(index);
                          final fybcaPresentDocSnapshot =
                              await fybcaPresentDoc.get();
                          if (fybcaPresentDocSnapshot.exists) {
                            // fybca_present document exists, check absent names
                            final Map<String, dynamic> fybcaPresentData =
                                fybcaPresentDocSnapshot.data()
                                    as Map<String, dynamic>;
                            final String name = fybcaDoc['name'];
                            fybcaPresentData.forEach((index, array) {
                              List<dynamic> fybcaPresentArray = array;
                              for (int i = 0;
                                  i < fybcaPresentArray.length;
                                  i++) {
                                if (fybcaPresentArray[i] == name) {
                                  // Match found, move to next value in array
                                  continue;
                                } else {
                                  // No match found, add name to absentNames object
                                  if (!absentNames.containsKey(index)) {
                                    absentNames[index] = [];
                                  }
                                  absentNames[index]!.add(name);
                                }
                              }
                            });
                          } else {
                            // fybca_present document does not exist, create it with this index and add name as absent
                            final Map<String, dynamic> data = {
                              'absent': [fybcaDoc['name']]
                            };
                            fybcaPresentDoc.set(data);
                          }
                        }
                      });

                      // Clear the text field after submitting
                      _nameController.clear();
                      setState(() {});*/
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
