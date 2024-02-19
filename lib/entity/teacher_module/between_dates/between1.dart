import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'final_count.dart';

class between1 extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;
  String? value5 = null;

  between1({
    super.key,
    required this.value, //course
    required this.value1, //div
    required this.value2, //year
    required this.value3, //sub
    required this.value4, //startdate
    required this.value5, //enddate
  });

  @override
  State<between1> createState() => _between1State();
}

class _between1State extends State<between1> {
  TextEditingController nk = new TextEditingController();
  TextEditingController roll = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.value2!)
              .where("div", isEqualTo: widget.value1)
              .where("year", isEqualTo: widget.value2)
              .where("course", isEqualTo: widget.value)
              //.where("erno", isEqualTo: "1490")
              //.where("erno",isEqualTo: dropdownvalue22 )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //print(_selectedYear);
            //print(_selectedCourse);

            //.where("subject", isEqualTo: "jio")
            //print(drop());

            return Column(
              children: [
                /*SizedBox(
                  height: 23,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text('Sub'),
                ),
                Container(
                  width: 150,
                  child: DropdownButton(
                    value: _selectedSub,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSub = "$newValue";
                      });
                    },
                    items: _sub.map((sub) {
                      return DropdownMenuItem(
                        child: new Text(sub),
                        value: sub,
                      );
                    }).toList(),
                  ),
                ),*/
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length, //values.length,
                      itemBuilder: (context, index) {
                        print("hello my name " +
                            snapshot.data!.docs[index].get("name"));
                        return GestureDetector(
                            child: ListTile(
                              title: Text(
                                  snapshot.data!.docs[index].get("roll no") +
                                      " report"),
                            ),
                            onTap: () => {
                                  roll.text =
                                      snapshot.data!.docs[index].get("roll no"),
                                  nk.text =
                                      snapshot.data!.docs[index].get("name"),
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => final_count(
                                        value: widget.value, //course
                                        value1: widget.value1, //div
                                        value2: widget.value2, //year
                                        value3: nk.text, //name
                                        roll: roll.text,
                                        value4: widget.value3, //sub]
                                        value5: widget.value4, //startdate
                                        value6: widget.value5, //enddate
                                      ),
                                    ),
                                  )
                                });
                      }),
                ),
                /* ElevatedButton(
                    child: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(249, 38, 168, 133),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ()),
                      );
                    }),*/
              ],
            );
          },
        ),
      )),
    );
  }
}
