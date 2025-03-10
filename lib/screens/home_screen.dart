import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart'; // ✅ Add this import
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  bool _isAnalysisComplete = false; // ✅ Track if analysis is done

  // Dummy analysis report (replace with real data later)
  final Map<String, dynamic> _analysisReport = {
    "result": "Diabetic Retinopathy Detected",
    "severity": "Moderate",
    "affected_eye": "Right Eye",
    "recommendation": "Consult an ophthalmologist within the next 3 months.",
    "confidence": "87%",
    "detailed_findings": [
      "Microaneurysms observed in the retina.",
      "Moderate hemorrhages detected.",
      "Early signs of neovascularization present."
    ]
  };

  // ✅ Function to Pick Image from Gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _isAnalysisComplete = false; // Reset analysis when a new image is picked
      });
    }
  }

  // ✅ Function to Simulate Analysis
  void _analyzeImage() {
    if (_selectedImage == null) return;

    setState(() {
      _isAnalysisComplete = true; // Mark analysis as complete
    });
  }

  // ✅ Function to Export Report as PDF
  Future<void> _exportReportToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("AI Retinopathy Analysis Report",
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Divider(),
                pw.Text("Diagnosis: ${_analysisReport['result']}",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text("Severity Level: ${_analysisReport['severity']}"),
                pw.Text("Affected Eye: ${_analysisReport['affected_eye']}"),
                pw.Text("Confidence Level: ${_analysisReport['confidence']}"),
                pw.SizedBox(height: 10),
                pw.Text("🔍 Detailed Findings:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ..._analysisReport['detailed_findings']
                    .map<pw.Widget>((finding) => pw.Text("- $finding"))
                    .toList(),
                pw.SizedBox(height: 10),
                pw.Text("📌 Recommendation: ${_analysisReport['recommendation']}",
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.red)),
              ],
            ),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/retinopathy_report.pdf");

    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved to: ${file.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF68A6BC), // Matching login page color
      appBar: AppBar(
        title: const Text("Welcome, User! 👋"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ Upload Image Box
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset("lib/images/diabetes-test.png", height: 80),
                        const SizedBox(height: 10),
                        const Text(
                          "📤 Upload Retinal Scan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Show selected image preview
              if (_selectedImage != null) ...[
                Image.file(_selectedImage!, height: 200),
                const SizedBox(height: 10),
                const Text("Image selected! Click 'Analyze' to generate report."),
                const SizedBox(height: 20),
              ],

              // ✅ Analyze/Scan Box
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _selectedImage != null ? _analyzeImage : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedImage != null ? Colors.white : Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset("lib/images/retinopathy.png", height: 80),
                        const SizedBox(height: 10),
                        Text(
                          "🔍 Analyze Retinal Scan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _selectedImage != null ? Colors.black : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ AI Analysis Report & PDF Export Button
              if (_isAnalysisComplete) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("📝 AI Analysis Report",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Divider(),
                      Text("Diagnosis: ${_analysisReport['result']}", style: const TextStyle(fontSize: 18)),
                      Text("Severity Level: ${_analysisReport['severity']}"),
                      Text("Affected Eye: ${_analysisReport['affected_eye']}"),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _exportReportToPDF,
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text("Export to PDF"),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}






