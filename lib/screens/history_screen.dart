import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan History')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHistoryItem("03 March 2025", "No Diabetic Retinopathy"),
          _buildHistoryItem("28 Feb 2025", "Mild Diabetic Retinopathy"),
          _buildHistoryItem("15 Feb 2025", "No Diabetic Retinopathy"),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String date, String result) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(result),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Future: Open detailed scan result
        },
      ),
    );
  }
}
