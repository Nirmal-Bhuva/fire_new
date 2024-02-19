import 'package:fire_new/entity/teacher_module/pdf/pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';

class PDFViewer extends StatelessWidget {
  final String filePath;

  const PDFViewer({Key? key, required this.filePath}) : super(key: key);

  Future<void> _sharePDF() async {
    try {
      // ignore: deprecated_member_use
      await Share.shareFiles(
        [filePath],
        text: 'PDF document',
        mimeTypes: ['application/pdf'],
      );
    } catch (e) {
      print('Error sharing PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _sharePDF,
          ),
        ],
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
