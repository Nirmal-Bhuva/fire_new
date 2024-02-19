import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uuid/uuid.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class generate_id extends StatefulWidget {
  const generate_id({super.key});

  @override
  State<generate_id> createState() => _generate_idState();
}

class _generate_idState extends State<generate_id> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Student_data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          List<DocumentSnapshot> students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> studentData =
                  students[index].data() as Map<String, dynamic>;

              String studentId = studentData.containsKey('id')
                  ? studentData['id']
                  : _generateId(studentData['course']);

              // Save the generated ID to the Firestore document
              if (!studentData.containsKey('id')) {
                students[index]
                    .reference
                    .set({'id': studentId}, SetOptions(merge: true));
              }

              return ListTile(
                title: Text(studentData['name']),
                subtitle: Text('ID: $studentId'),
              );
            },
          );
        },
      ),
    );
  }

  String _generateId(String course) {
    // Get the current year
    String year = DateTime.now().year.toString();

    // Generate the ID using the current year and course name
    String id = year + course.replaceAll(" ", "").toUpperCase();

    return id;
  }
}
