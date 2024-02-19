import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

String? name;
String? roll;
String? id;

class status extends StatefulWidget {
  const status({super.key});

  @override
  State<status> createState() => _statusState();
}

class _statusState extends State<status> {
  /*String dropdownvalue22 = 'MSCIT';

  final List<String> items22 = ['MSCIT', 'BCA', 'MCA', 'BSCIT'];

  String dropdownvalue2 = 'A';

  final List<String> items2 = [
    'A',
    'B',
    'C',
  ];

  String dropdownvalue3 = 'FY';
  final List<String> items3 = ['FY', 'SY', 'TY'];*/

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('bca_present').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final presentList = List.from(doc['present']);
            final absentList = List.from(doc['absent']);
            final studentName = doc.id.split(' ')[1];
            final status = presentList.contains(studentName)
                ? 'Present'
                : absentList.contains(studentName)
                    ? 'Absent'
                    : 'Not marked';
            return ListTile(
              title: Text(studentName),
              subtitle: Text(status),
            );
          },
        );
      },
    );
  }
}
