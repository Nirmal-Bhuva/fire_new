import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class final_count extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;
  String? value5 = null;
  String? value6 = null;
  String? roll = null;

  final_count(
      {super.key,
      required this.value, //course
      required this.value1, //div
      required this.value2, //year
      required this.value3, //name
      required this.value4, //subject
      required this.value5, //startdate
      required this.value6, //enddate
      required this.roll});

  @override
  State<final_count> createState() => _final_countState();
}

class _final_countState extends State<final_count> {
  TextEditingController nk = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? startdate = widget.value5;
    String? enddate = widget.value6;
    String? div = widget.value1;
    String? sub = widget.value4;
    String? name = widget.value3;
    String? fname = widget.roll! + " " + widget.value3!;
    String? divsub = 'Div=$div Sub=$sub';
    print(divsub);
    print(fname);
    print(widget.value);
    print(widget.value1);
    print(widget.value2);
    print(widget.value3);
    print(widget.value4);
    print(widget.value5);
    print(widget.value6);
    print(widget.roll);

    //String documentName = '$startdate $div $sub to $enddate $div $sub';
    //print(documentName);

    //final startDate = DateFormat('dd-MM-yyyy').parse(startdate!);
    //final endDate = DateFormat('dd-MM-yyyy').parse(enddate!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Presence Counter'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.value2! + '_PRESENT')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            // Get the current year and month
            int currentYear = DateTime.now().year;
            print(currentYear);
            String currentMonth =
                DateTime.now().month.toString().padLeft(2, '0');
            //currentMonth.toString().padLeft(2, '0');

            print(currentMonth);

            int count = 0;
            for (var doc in snapshot.data!.docs) {
              //if ((doc.data() as Map).containsKey('$divsub')) {
              //String div = doc['div'];
              //String sub = doc['sub'];

              // Extract the year and month from the document ID
              List<String> docParts = doc.id.split(' ');
              print(doc.id);
              print(docParts);
              int year = int.parse(docParts[0].split('-')[2]);
              print(year);
              String month = int.parse(docParts[0].split('-')[1])
                  .toString()
                  .padLeft(2, '0');
              print(month);
              // Check if the document year and month match the current year and month
              if (year == currentYear && month == currentMonth) {
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
                  }
                }
              }
            }
            // }

            return Text(
                '$name was present $count times in the current month across all documents.');
          }),
    );

    /*Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(widget.value! + "_PRESENT")
                //.doc(currentDate)
                .where(
                    "Div=" +
                        widget.value1! +
                        " " +
                        "Sub=" +
                        widget.value4! /*div sub*/,
                    arrayContains: widget.value3! /*name*/)
                //.where("year", isEqualTo: widget.value2)
                //.where("course", isEqualTo: widget.value)
                //.where("name", isEqualTo: widget.value3)
                .snapshots(),
            builder: (context, snapshot) {
              /*if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }*/
              //print(course);
              //print(widget.value);
              //print(widget.value1);
              //print(widget.value2);
              //print(widget.value3);
              //print(widget.value4);
              if (snapshot.hasData) {
                int count = snapshot.data!.docs.length;
                return Text("Document count: $count");
              } else {
                return Text("Loading...");
              }
            },
          ),
        ),
      ),*/
  }
}
