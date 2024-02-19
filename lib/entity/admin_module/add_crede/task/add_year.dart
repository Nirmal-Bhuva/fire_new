import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class add_year extends StatefulWidget {
  const add_year({super.key});

  @override
  State<add_year> createState() => _add_yearState();
}

class _add_yearState extends State<add_year> {
  final yearname = TextEditingController(); //for year text

  final _formKey2 = GlobalKey<FormState>();

  var course2; //for year

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.deepPurple,
        title: Text('Add Course and Division'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey2,
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Container(
                      width: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('A_Course')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return DropdownButtonFormField<String>(
                            value: course2,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.get('course_name'),
                                child: Text(document.get('course_name')),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                course2 = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: 'Select Course',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Year ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: yearname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        icon: Icon(
                          Icons.book,
                          color: Colors.purple[800],
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Enter Year',
                        hintStyle: TextStyle(color: Colors.grey),
                        //labelText: 'Add Div',
                        labelStyle: TextStyle(color: Colors.purple[800]),
                      ),
                      validator: (value1) {
                        if (value1 == null || value1.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value1) => yearname.text = value1!,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your data has been sent to the database'),
                        );
                        _formKey2.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("A_Year")
                            .doc()
                            .set({'course': course2, 'year': yearname.text})
                            .then((value) => print('Data added to Firestore'))
                            .catchError((error) => print(
                                'Error adding data to Firestore: $error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
