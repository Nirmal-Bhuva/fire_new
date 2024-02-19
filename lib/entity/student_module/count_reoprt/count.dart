import 'package:fire_new/entity/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class count extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;

  count({
    super.key,
    required this.value, //course
    required this.value1, //div
    required this.value2, //year
    required this.value3, //name
    required this.value4, //sub
  });

  @override
  State<count> createState() => _countState();
}

@override
void initState() {}

class _countState extends State<count> {
  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MM').format(DateTime.now());

    String course = widget.value2!; //+ widget.value!;
    //String course2 = widget
    //String field = widget.value1! /*+ " " + widget.value4!*/;
    //print(field);
    print("course = " + course);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(252, 24, 200, 153),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(course + "_PRESENT")
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
      ),
    );
  }
}
