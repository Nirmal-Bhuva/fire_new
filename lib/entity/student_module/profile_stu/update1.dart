import 'package:fire_new/entity/admin_module/show_teacher/show_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

String? name = "null";
String? roll = "null";
String? roll1 = "null";
String? id = "null";
String? year = "null";
String? div = "null";
String? course = "null";
String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

class update1 extends StatefulWidget {
  /*String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;*/

  update1({
    super.key,
    /*required this.value, //erno
    required this.value1, //course
    required this.value2, //year
    required this.value3, //div*/
  });

  @override
  State<update1> createState() => _update1State();
}

class _update1State extends State<update1> {
  var itemIndex = [];
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final _formKey = GlobalKey<FormState>();

/*
  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;
*/

  @override
  void initState() {
    getDocumentDataByEmail();
    print("hello i am,$name");

    super.initState();
  }

  Future<String?> getDocumentDataByEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    late User? user;
    user = _auth.currentUser!;
    final email = user.email;
    final snapshot = await FirebaseFirestore.instance
        .collection("Student_data")
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      setState(() {
        name = snapshot.docs.first['name'];
        id = snapshot.docs.first['id'];
        roll = snapshot.docs.first['roll no'].toString();
        year = snapshot.docs.first['year'];
        course = snapshot.docs.first['course'];
        div = snapshot.docs.first['div'];
      });
      print('Document ID hello: $docId, Name: $name, Id  :$id , roll : $roll');
    }
  }

  @override
  Widget build(BuildContext context) {
    //String course = widget.value2!;
    //print(course);

    TextEditingController _name = new TextEditingController();
    TextEditingController _erno = new TextEditingController();
    TextEditingController _div = new TextEditingController();
    TextEditingController _year = new TextEditingController();
    TextEditingController _course = new TextEditingController();
    TextEditingController _email = new TextEditingController();
    TextEditingController _id = new TextEditingController();
    TextEditingController _sem = new TextEditingController();
    @override
    void dispose() {
      _name.dispose();
      _erno.dispose();
      _div.dispose();
      _year.dispose();
      _course.dispose();
      _email.dispose();
      _id.dispose();
      _sem.dispose();

      super.dispose();
    }

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
      body: Container(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //child: StreamBuilder<QuerySnapshot>(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(year!)
                  .where("roll no", isEqualTo: roll)
                  .where("course", isEqualTo: course)
                  .where("year", isEqualTo: year)
                  .where("div", isEqualTo: div)
                  //.where("year", isEqualTo: widget.value3 ?? "year")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var documents = snapshot.data!.docs; //for document id;

                return ListView.builder(
                  itemCount: snapshot.data?.docs.length, //values.length,
                  itemBuilder: (context, index) {
                    var document = documents[index];
                    var documentID = document.id;
                    _erno.text = snapshot.data!.docs[index].get("roll no");
                    _email.text = snapshot.data!.docs[index].get("email");
                    _id.text = snapshot.data!.docs[index].get("id");
                    _sem.text = snapshot.data!.docs[index].get("sem");
                    _course.text = snapshot.data!.docs[index].get("course");
                    _name.text = snapshot.data!.docs[index].get("name");
                    _div.text = snapshot.data!.docs[index].get("div");
                    _year.text = snapshot.data!.docs[index].get("year");

                    return ListTile(
                      title: Column(children: [
                        Form(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "id",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _id,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "enrollment no ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _erno,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "course",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _course,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "year",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _year,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "sem",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _sem,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "div",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _div,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              TextFormField(
                                controller: _email,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple[800],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );

                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
