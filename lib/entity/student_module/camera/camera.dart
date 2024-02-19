import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

String? name;
String? roll;
String? roll1;
String? id;
String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

class camera extends StatefulWidget {
  const camera({super.key});

  @override
  State<camera> createState() => _cameraState();
}

class _cameraState extends State<camera> {
  String _barcodeValue = '';

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
      });
      print('Document ID hello: $docId, Name: $name, Id  :$id , roll : $roll');
    }
  }

  @override
  Widget build(BuildContext context) {
    initState() {
      roll = null;
      roll1 = null;

      super.initState();
    }

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
        title: Text('$name'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(_barcodeValue),
            Container(
              width: 220.0,
              height: 220.0,
              child: Image.asset(
                'assets/a1/scan.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[700], // set the background color of the button to blue
                onPrimary: Colors.purple[700], // set the text color of the button to white
              ),
              onPressed: _scanBarcode,
              child: Text('Scan Barcode', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  /*

  void _handleSubmitButtonPress() {
    setState(() {
      _isSubmitted = true;
    });
  }
*/
  Future<void> _scanBarcode() async {
    int _scanTime = DateTime.now().millisecondsSinceEpoch;

    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );
    print("hello barcode" + barcodeScanRes);

    List<dynamic> parts = barcodeScanRes.split("+");
    print(parts);
    String part0 = parts[0];
    print("part0" + part0); //course
    String part1 = parts[1];
    print("part1" + part1); //div
    String part2 = parts[2];
    print("part2" + part2); //year
    String part3 = parts[3];
    print("part3" + part3); //sub
    //int generateTimeStr = parts[4] as int;
    //final int _generateTime =
    //DateFormat('yyyyMMddHHmmss').parse(generateTimeStr as String) as int;
    //final dynamic _generateTime =
        //DateTime.parse(generateTimeStr as String).millisecondsSinceEpoch as int;
    //print("_generateTime: " + _generateTime.toString());
    String present = "${part2}_PRESENT";
    print(present);
    String date = "${currentDate} ${part1} ${part3}";
    print(date);

    //roll1 = '${part1}${roll.toString().padLeft(2, '0')}';
    print(roll1);

/*    int timeDifference =
        (_scanTime - _generateTime) ~/ 1000; // time difference in seconds

    if (timeDifference > 300) {
      // time difference greater than 5 minutes
      setState(() {
        _barcodeValue = 'Barcode scanning is disabled';
      });
    } else {*/
      if (barcodeScanRes != '-1') {
        FirebaseFirestore.instance
            .collection("${part2}_PRESENT")
            .doc("${currentDate} ${part1} ${part3}")
            .get()
            .then((docSnapshot) {
          if (docSnapshot.exists) {
            // If the document already exists, update it

            return FirebaseFirestore.instance
                .collection("${part2}_PRESENT")
                .doc("${currentDate} ${part1} ${part3}")
                .set({
                  "Div" + "=" + part1 + " " + "Sub" + "=" + part3:
                      FieldValue.arrayUnion(['$roll' + " " + '$name'])
                }, SetOptions(merge: true))
                .then((value) => print("Field updated successfully"))
                .catchError((error) => print("Failed to update field: $error"));
          } else {
            // If the document doesn't exist, create it
            return FirebaseFirestore.instance
                .collection("${part2}_PRESENT")
                .doc("${currentDate} ${part1} ${part3}")
                .set({
                  "Div" + "=" + part1 + " " + "Sub" + "=" + part3: [
                    roll! + " " + name!
                  ]
                })
                .then((value) => print("Field added successfully"))
                .catchError((error) => print("Failed to add field: $error"));
          }
        }).catchError((error) => print("Failed to get document: $error"));

        //.add({'value': name});

        setState(() {
          _barcodeValue = barcodeScanRes;
        });
      } else {
        // Barcode scanning was cancelled
        setState(() {
          _barcodeValue = 'Barcode scanning was cancelled';
        });
      }
    }
  }
//}
