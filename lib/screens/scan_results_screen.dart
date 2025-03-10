import 'package:flutter/material.dart';

class ScanResultsScreen extends StatelessWidget {
  const ScanResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Analysis Result",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🔍 AI Detection: Mild Diabetic Retinopathy"),
                  SizedBox(height: 10),
                  Text("🩺 Recommendation: Schedule an eye check-up"),
                  SizedBox(height: 10),
                  Text("📆 Date: 10 March 2025"),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                child: const Text("View History"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
