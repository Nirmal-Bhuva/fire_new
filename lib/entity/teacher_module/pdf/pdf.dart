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

class pdf extends StatefulWidget {
  String? value = null;
  String? value1 = null;
  String? value2 = null;
  String? value3 = null;
  String? value4 = null;
  String? value5 = null;

  pdf({
    super.key,
    required this.value, //name
    required this.value1, //course
    required this.value2, //div
    required this.value3, //year
    required this.value4, //sub
    required this.value5, //sem
  });

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
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
                  ElevatedButton(
                    onPressed: generatePdf,
                    child: Text("Generate PDF"),
                  ),
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.picture_as_pdf),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDFViewer(filePath: _pdfPath)),
            );
          }),
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

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: pw.FixedColumnWidth(200), // width of the first column
              1: pw.FlexColumnWidth(1), // width of the second column
            },
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Today date:${currentDate}",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Year: " +
                          widget.value3! +
                          "     " +
                          "Div :${widget.value2}",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Present:",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      arrayField1.join(",\n "),
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Absent:",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      arrayField2.join(",\n "),
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output?.path}/example.pdf" as String);
    await file.writeAsBytes(await pdf.save());
    print("PDF file saved!");

    setState(() {
      setState(() {
        _pdfPath = file.path;
      });
    });
  }
  /*
 void share(BuildContext context, String text) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
 */
}
