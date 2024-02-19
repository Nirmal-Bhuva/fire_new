import 'package:fire_new/entity/admin_module/show_teacher/show_user.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class update extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;

  update({
    super.key,
    required this.value, //erno
    required this.value1, //course
    required this.value2, //year
    required this.value3, //div
    required this.value4,
  });

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  var itemIndex = [];
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_name = TextEditingController(text: widget.value1.toString());
    //_div = TextEditingController(text: widget.value3.toString());
  }

  String? sub3;
  String? course3;
  String? div3;
  String? year3;
  String? sem3;
  @override
  Widget build(BuildContext context) {
    // String course = widget.value2!;
    // print(course);
    print(widget.value);
    print(widget.value1);
    print(widget.value2);
    print(widget.value3);
    print(widget.value4);

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
                  .collection("Teacher_data")
                  .where("id", isEqualTo: widget.value)
                  .where("course", isEqualTo: widget.value1)
                  .where("year", isEqualTo: widget.value2)
                  .where("div", isEqualTo: widget.value3)
                  .where("sem", isEqualTo: widget.value4)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  // if there is no data or the data is null, display a message
                  return Text('No data exists.');
                }
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
                    // _erno.text = snapshot.data!.docs[index].get("roll no");
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
                                controller: _name,
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
                                  "Id",
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
                                  "Course",
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
                                  "Year",
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
                                  "Sem",
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
                                  "Div",
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
                                  "Email",
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
