import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_guard/screens/home_page.dart';
import 'package:safe_guard/screens/state_selection_screen.dart';
import 'package:safe_guard/screens/state_detail_screen.dart';
import 'package:safe_guard/screens/contact_us_screen.dart';
import 'package:safe_guard/screens/infographics_screen.dart';

void main() {
  group('SafeGuard Nigeria Complete Widget Test Suite', () {
    
    testWidgets('HomePage loads with branding and key sections', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      expect(find.text('SafeGuard Nigeria'), findsOneWidget);
      expect(find.text('AUTO-DETECT LOCATION'), findsOneWidget);
    });

    testWidgets('Auto-detect button shows loading state', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      await tester.runAsync(() async {
        await tester.tap(find.text('AUTO-DETECT LOCATION'));
        await tester.pump(); 
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      });
    });

    testWidgets('Drawer navigation opens correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text('Browse All States'), findsOneWidget);
      expect(find.text('About Us'), findsOneWidget);
    });

    testWidgets('StateSelectionScreen search filtering works', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StateSelectionScreen()));
      await tester.enterText(find.byType(TextField), 'Lagos');
      await tester.pump();
      expect(find.text('Lagos'), findsWidgets);
    });

    testWidgets('StateDetailScreen renders contacts correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StateDetailScreen(stateName: 'Lagos')));
      expect(find.textContaining('Lagos Directory'), findsOneWidget);
    });

    testWidgets('ContactUsScreen displays support options', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ContactUsScreen()));
      expect(find.text('Email Us'), findsOneWidget);
      expect(find.text('e_link_group_2_project@gmail.com'), findsOneWidget);
    });


    testWidgets('InfographicsScreen renders crisis guide sections', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: InfographicsScreen()));
      expect(find.text('Crisis Response Guide'), findsOneWidget);
      expect(find.text('112 / 199'), findsOneWidget);
    });
  });
}