import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/student_module/camera/camera.dart';
import 'package:fire_new/entity/teacher_module/attendence/final_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

String? name;
String? rollno;
String? course;
String? year;
String? div;
String? sem;
String? sub;

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  final _formKey = GlobalKey<FormState>();

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
        .collection("Student_data")
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      setState(() {
        name = snapshot.docs.first['name'];
        roll = snapshot.docs.first['roll no'];
        course = snapshot.docs.first['course'];
        year = snapshot.docs.first['year'];
        sem = snapshot.docs.first['sem'];
        div = snapshot.docs.first['div'];
      });
      print(
          'Document ID hello: $docId, year $year Name: $name course $course sem $sem , div = $div');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? fname = roll! + " " + name!;
    print("myfname");
    print("hellof1" + fname);
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
                        "Select Subject",
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
                            .where('year', isEqualTo: year)
                            .where('course', isEqualTo: course)
                            .where('sem', isEqualTo: sem)
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
                            value: sub,
                            onChanged: (value) {
                              setState(() {
                                sub = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.menu_book_sharp),
                              hintText: 'Select sub',
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
                    const SizedBox(height: 28),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Monthly Report",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(year! + '_PRESENT')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          

//---------------------------------------------------------
// -------------------------------------------------------------------
                          // Get the current year and month
                          int currentYear = DateTime.now().year;
                          print(currentYear);
                          String currentMonth =
                              DateTime.now().month.toString().padLeft(2, '0');
                          //currentMonth.toString().padLeft(2, '0');

                          print(currentMonth);

                          int count = 0;
                          int totalDays = 0;
                          List<String> presentDates = [];

                          List<String> datesPresent =
                              []; // Create an empty list to store dates

                          for (var doc in snapshot.data!.docs) {
                            //if ((doc.data() as Map).containsKey('$divsub')) {
                            //String div = doc['div'];
                            //String sub = doc['sub'];

                            // Extract the year and month from the document ID
                            var divsub = 'Div=' +
                                div.toString() +
                                ' ' +
                                'Sub=' +
                                sub.toString();
                            print(divsub);
                            List<String> docParts = doc.id.split(' ');
                            print(doc.id);
                            print(docParts);
                            int year = int.parse(docParts[0].split('-')[2]);
                            print(year);
                            String month = int.parse(docParts[0].split('-')[1])
                                .toString()
                                .padLeft(2, '0');
                            String day = int.parse(docParts[0].split('-')[0])
                                .toString()
                                .padLeft(2, '0');
                            String? div1 = docParts[1];
                            String? sub2 = docParts[2];

                            print(month);
                            // Check if the document year and month match the current year and month
                            if (year == currentYear &&
                                month == currentMonth &&
                                div == div1 &&
                                sub == sub2) {
                              print('$name');
                              if ((doc.data() as Map).containsKey('$divsub')) {
                                // Check if the student is present in the present array
                                List<dynamic> presentStudents =
                                    doc['$divsub'] as List<dynamic>;
                                print('presentstudent $presentStudents');
                                if (presentStudents.contains('$fname')) {
                                  count += presentStudents
                                      .where((name) => name == '$fname')
                                      .length;
                                  String date = '$day/$month/$year';
                                  presentDates.add('$date ($count times)');
// Add the date to the list

                                  // Print the name, date, and present count
                                  //print(
                                  //  '$name was present on $date $count times.');

                                  // Update the Text widget to show the name, date, and present count
                                  Text('$name was present on $date.');
                                } /*else {
                                  totalDays += 1;
                                }*/
                              } //else {
                              totalDays += 1;
                              //}
                            }
                          }

                          // Calculate the attendance ratio
                          if (count == 0) {
                            presentDates.add("0 presence");
                          }

// Calculate the attendance ratio
                          double attendanceRatio = 0.0;
                          if (totalDays > 0) {
                            attendanceRatio = (count / totalDays) * 100.0;
                          }

// Check if the attendance is below 75% and set the attendanceStatus variable accordingly
                          String attendanceStatus = "";
                          if (attendanceRatio < 75.0) {
                            attendanceStatus = "Low Attendance";
                          }

                          Color textColor = attendanceRatio < 75.0 ? Colors.red : Colors.black;

                          // Update the Text widget to show the name, present dates, total days of subject attendance, and attendance ratio
                          return Column(
                            children: [
                              Text(attendanceStatus),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  '\t $name was present on the \n\t following dates: ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                                ),
                              ),
                              for (var presentDate in presentDates)
                                Text(presentDate, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                    '\t Out of $totalDays days of attendance in \n\t the current month,'
                                        '\n \t$name was present \n\t for $count days (${attendanceRatio.toStringAsFixed(2)}%).',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                                ),
                              ),
                            ],
                          );
                        }),
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
