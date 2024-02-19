import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class data_manager extends StatefulWidget {
  //String? course = null;

  const data_manager({super.key});

  @override
  State<data_manager> createState() => _data_managerState();
}

class _data_managerState extends State<data_manager> {
  /*String dropdownvalue = 'FY';

  final List<String> items = [
    'FY',
    'SY',
    'TY',
    'FY-SY',
    'SY-TY',
    'FY-TY',
    'FY-SY-TY'
  ];

  String dropdownvalue20 = 'BCA';

  final List<String> items20 = ['BCA', 'BSCIT', 'MSCIT', 'MCA'];

  String dropdownvalue2 = 'A';

  final List<String> items2 = ['A', 'B', 'C', 'A-B', 'B-C', 'A-C', 'A-B-C'];
  */
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.width;
    screenWidth = MediaQuery.of(context).size.width;
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
            children: [
            ],
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Teacher_data")
                  //.where("div", isEqualTo: dropdownvalue2)
                  //.where("year", isEqualTo: dropdownvalue)
                  //.where("course", isEqualTo: dropdownvalue20)
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
