import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_guard/main.dart';
// import 'package:safe_guard/screens/home_page.dart';
import 'package:safe_guard/screens/state_selection_screen.dart';
import 'package:safe_guard/screens/state_detail_screen.dart';

void main() {
  group('SafeGuard Nigeria Widget Tests', () {
    
    testWidgets('HomePage loads with branding and detect button', (WidgetTester tester) async {
      await tester.pumpWidget(const EmergencyDirectoryApp());

      // Verify branding text
      expect(find.text('SafeGuard Nigeria'), findsOneWidget);
      expect(find.text('NIGERIA EMERGENCY\nDIRECTORY'), findsOneWidget);

      // Verify the Auto-Detect button exists
      expect(find.text('AUTO-DETECT LOCATION'), findsOneWidget);
      expect(find.byIcon(Icons.location_searching), findsOneWidget);
    });

    testWidgets('StateSelectionScreen search filters states correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StateSelectionScreen()));

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Lagos');
      await tester.pump(); 

      // Look for Lagos only within the Grid results
      expect(find.descendant(of: find.byType(GridView), matching: find.text('Lagos')), findsOneWidget);
      
      // Verify that a state that shouldn't be there is gone
      expect(find.text('Kano'), findsNothing); 
    });

    testWidgets('Navigation to StateDetailScreen via Manual Selection', (WidgetTester tester) async {
      await tester.pumpWidget(const EmergencyDirectoryApp());

      // 1. Simulate failing/skipping auto-detect to get to StateSelection
      // For testing, we can just push the StateSelectionScreen directly
      await tester.pumpWidget(const MaterialApp(home: StateSelectionScreen()));

      // 2. Tap on a state card (assuming the first state is 'Abia' or similar)
      // We search for any text in the GridView and tap it
      final stateCard = find.byType(InkWell).first;
      await tester.tap(stateCard);
      await tester.pumpAndSettle(); // Wait for navigation animation

      // 3. Verify we are on the Detail Screen (Check for the Directory suffix in AppBar)
      expect(find.textContaining('Directory'), findsOneWidget);
      expect(find.byIcon(Icons.print), findsOneWidget);
    });

    testWidgets('StateDetailScreen displays call buttons for contacts', (WidgetTester tester) async {
      // Directly load Detail Screen for a specific state
      await tester.pumpWidget(const MaterialApp(
        home: StateDetailScreen(stateName: 'Lagos'),
      ));

      // Check if the list builds (assuming your database isn't empty)
      // It should show at least one phone icon
      expect(find.byIcon(Icons.phone), findsWidgets);
    });
  });
}