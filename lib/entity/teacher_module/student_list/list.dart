import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/student_module/monthly_report/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class list extends StatefulWidget {
  String? name = null;
  String? course = null;
  String? div = null;
  String? year = null;
  String? sub = null;
  String? sem = null;

  list({
    super.key,
    required this.name, //name
    required this.course, //course
    required this.div, //div
    required this.year, //year
    required this.sub, //sub
    required this.sem, //sem
  });

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.width;
    screenWidth = MediaQuery.of(context).size.width;

    var years = widget.year!;
    print(years);
    //String course1 = widget.course!;
    //print(course1);

    //bool _value = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Row(
            children: [],
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(years)
                  .where("div", isEqualTo: widget.div)
                  .where("year", isEqualTo: widget.year)
                  .where("course", isEqualTo: widget.course)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data!.docs[index].get("name"));
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Image(
                            image: AssetImage('assets/nk.png'),
                          )),
                          title: Text(snapshot.data!.docs[index].get("name")),
                          //trailing: Text(snapshot.data!.docs[index].get("subject")),
                          subtitle:
                              Text(snapshot.data!.docs[index].get("course")),
                          //trailing: Text(
                          //"div - " + snapshot.data!.docs[index].get("div")),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
