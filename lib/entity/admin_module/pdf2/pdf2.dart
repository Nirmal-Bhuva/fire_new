import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/entity/teacher_module/pdf/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

bool isPDFGenerated = false;
String _pdfPath = '';

class pdff extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;
  String? value5 = null;

  pdff({
    super.key,
    required this.value, //name
    required this.value1, //course
    required this.value2, //div
    required this.value3, //year
    required this.value4, //sub
    required this.value5, //sem
  });

  @override
  State<pdff> createState() => _pdffState();
}

class _pdffState extends State<pdff> {
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  List<String> arrayField1 = [];
  List<String> arrayField2 = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isPDFGenerated)
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("Today date:${currentDate}"),
                  SizedBox(height: 20),
                  Text("Year: " +
                      widget.value3! +
                      "     " +
                      "Div :${widget.value2}"),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add padding of 16.0 to all sides
                    child: Table(
                      border:
                          TableBorder.all(), // Add a border around the table
                      children: [
                        TableRow(
                          children: [
                            TableCell(child: Text(" Present:")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TableCell(
                                child: Text(arrayField1.join(",\n ")),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(child: Text(" Absent:")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TableCell(
                                child: Text(arrayField2.join(",\n ")),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          if (isPDFGenerated)
            Expanded(
              child: PDFView(
                filePath: _pdfPath,
                enableSwipe: true,
                swipeHorizontal: true,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(widget.value3! + "_PRESENT")
        .doc(currentDate + " " + widget.value2! + " " + widget.value4!)
        .get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();
      setState(() {
        arrayField1 = List<String>.from(
            data!["Div=" + widget.value2! + " " + "Sub=" + widget.value4!]);
        arrayField2 = List<String>.from(data["absent"]);
      });
    } else
      print("Document does not exist!");
  }
}
