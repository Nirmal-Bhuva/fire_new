import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class date_output extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;
  String? value5 = null;

  date_output({
    super.key,
    required this.value, //course
    required this.value1, //div
    required this.value2, //year
    required this.value3, //name
    required this.value4, //sub
    required this.value5, //date
  });

  @override
  State<date_output> createState() => _date_outputState();
}

class _date_outputState extends State<date_output> {
  final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //final formattedDate = '${currentDate.year}-${currentDate.month}-${currentDate.day}';

  //TextEditingController _date = TextEditingController();
  //TextEditingController _date2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String course = widget.value2!; //+ widget.value!;
    //String course2 = widget
    //String field = widget.value1! /*+ " " + widget.value4!*/;
    //print(field);
    print("course = " + course);

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
        title: Text(currentDate),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.value2! + "_PRESENT")
            .doc(widget.value5! + " " + widget.value1! + " " + widget.value4!)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (!snapshot.data!.exists) {
            return Text("Field doesn't exist");
          }

          var fieldValue = snapshot
              .data!["Div=" + widget.value1! + " " + "Sub=" + widget.value4!];
          print(fieldValue);
          print(widget.value1);
          print(widget.value4);
          print(widget.value2);
          return ListView.builder(
            itemCount: fieldValue.length,
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text(fieldValue[index]),
                ),
              );
            },
          );
        },
      ),

      /*Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: _date2,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Select to Date",
                    ),
                    onTap: () async {
                      DateTime? pickedate2 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2050));

                      if (pickedate2 != null) {
                        setState(() {
                          _date2.text = DateFormat("dd-MM-yyyy").format(pickedate2);
                        });
                      }
                    },
                  ),
                ),*/
    );
  }
}
