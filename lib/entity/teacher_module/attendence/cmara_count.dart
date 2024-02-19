import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class camara_count extends StatefulWidget {
  String? sub = null;
  String? year = null;
  String? div = null;
  String? sem = null;
  camara_count(
      {super.key,
      required this.sub, //sub
      required this.year, //year
      required this.div, //div
      required this.sem});

  @override
  State<camara_count> createState() => _camara_countState();
}

String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

class _camara_countState extends State<camara_count> {
  @override
  Widget build(BuildContext context) {
    String docuval = currentDate + ' ' + widget.div! + ' ' + widget.sub!;
    print("docuvalue" + docuval);

    return Scaffold(
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.year! + '_PRESENT')
            .doc(currentDate + ' ' + widget.div! + ' ' + widget.sub!)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var fieldValue =
              snapshot.data!["Div=" + widget.div! + " " + "Sub=" + widget.sub!];
          print(fieldValue);
          print(widget.div);
          print(widget.sub);
          print(widget.year);

          return ListView.builder(
            itemCount: fieldValue.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(fieldValue[index]),
              );
            },
          );
        },
      ),
    );
  }
}
