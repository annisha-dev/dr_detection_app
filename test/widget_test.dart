import 'package:flutter/material.dart'; 
import 'package:flutter_test/flutter_test.dart';
import 'package:dr_detection_app/main.dart'; // Corrected import

void main() {
  testWidgets('App starts without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp()); // Ensure this matches the main app class name
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}


