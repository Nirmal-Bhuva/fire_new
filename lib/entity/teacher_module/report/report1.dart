import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class report1 extends StatefulWidget {
  const report1({super.key});

  @override
  State<report1> createState() => _report1State();
}

class _report1State extends State<report1> {
  @override
  Color primary = Color.fromARGB(252, 24, 200, 153);

  //DateTime _dateTime = DateTime.now();
  //String _dateTime = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //DateFormat _dateTime = DateFormat('dd-MM-yyyy');

  double screenWidth = 0;
  double screenHeight = 0;

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  TextEditingController nk = new TextEditingController();
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime(2023, 3, 22));
  String currentDate2 = DateFormat('dd-MM-yyyy').format(DateTime(2023, 3, 22));

  void initState() {
    // TODO: implement initState
    super.initState();
    //CourseDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    String studentName = 'Khushi';
    DateTime startDate = DateTime(2023, 2, 22);
    DateTime endDate = DateTime(2023, 2, 27);
    int reportCount = 0;

    String dateString = DateFormat('dd-MM-yyyy').format(startDate);
    String dateString2 = DateFormat('dd-MM-yyyy').format(endDate);

    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    //String course2 = _selectedYear + "_PRESENT";
    //print(course2 + " i am nirmal bhuva");
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

      //--------------------
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('FYBCA_PRESENT')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            int count = 0;
            snapshot.data!.docs.forEach((doc) {
              String documentName = doc.id;
              List<String> nameParts = documentName.split(' ');
              if (nameParts.length == 3) {
                DateTime? documentDate = DateTime.tryParse(nameParts[0]);

                if (documentDate != null &&
                    documentDate.isAfter(DateTime.parse(startDate.toString())
                        .subtract(Duration(days: 1))) &&
                    documentDate.isBefore(DateTime.parse(endDate.toString())
                        .add(Duration(days: 1)))) {
                  String studentName = nameParts[2];
                  List<dynamic> divSub = doc['C html'];
                  if (divSub != null && divSub.contains(studentName)) {
                    count++;
                  }
                }
              }
            });
            return Text(
                'Number of times $studentName was present between $startDate and $endDate: $count');
          },
        ),
      ),
    );
  }
}
      /*

      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("FYBCA_PRESENT")
                //.where("course", isEqualTo: widget.value1)
                //.where("div", isEqualTo: dropdownvalue2)
                //.where("year", isEqualTo: widget.value3 ?? "year")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //.where("subject", isEqualTo: "jio")

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(document.id.toString()),
                    subtitle: Text(document.data().toString()),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),*/
    