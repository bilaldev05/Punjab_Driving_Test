import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class RuleBookPdfScreen extends StatefulWidget {
  const RuleBookPdfScreen({super.key});

  @override
  State<RuleBookPdfScreen> createState() => _RuleBookPdfScreenState();
}

class _RuleBookPdfScreenState extends State<RuleBookPdfScreen> {
  final String pdfUrl = "http://192.168.100.153:8000/rulebook/pdf";
  bool isLoading = true;
  Uint8List? pdfBytes;
  late PdfViewerController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
    loadPdf();
  }

  Future<void> loadPdf() async {
    try {
      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        setState(() {
          pdfBytes = response.bodyBytes;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        debugPrint("Failed to fetch PDF, status: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error loading PDF: $e");
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Punjab Rule Book"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfBytes != null
              ? SfPdfViewer.memory(
                  pdfBytes!,
                  controller: _pdfController,
                )
              : const Center(child: Text("Failed to load PDF")),
    );
  }
}