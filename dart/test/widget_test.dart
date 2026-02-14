import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_guard/main.dart';
import 'package:safe_guard/screens/state_selection_screen.dart';
import 'package:safe_guard/screens/state_detail_screen.dart';
import 'package:safe_guard/screens/contact_us_screen.dart';

void main() {
  /// group tests together so they are easy to find and run as a set.
  group('SafeGuard Nigeria Extensive Test Suite', () {
    
    // --- 1. HOME PAGE & CORE BRANDING ---

    /// TEST 1: Check if the app looks the way it should when it first opens.
    testWidgets('HomePage loads with correct branding and fonts', (WidgetTester tester) async {
      // Load our app into the test environment
      await tester.pumpWidget(const EmergencyDirectoryApp());

      // Check: Is the name SafeGuard Nigeria visible?
      expect(find.text('SafeGuard Nigeria'), findsOneWidget);
      
      // Check: Is the text extra bold (w900)? This confirms our custom font is working.
      final Text branding = tester.widget(find.text('SafeGuard Nigeria'));
      expect(branding.style?.fontWeight, equals(FontWeight.w900));
      
      // Check: Is the AUTO-DETECT button there?
      expect(find.text('AUTO-DETECT LOCATION'), findsOneWidget);
    });

    /// TEST 2: Check if the loading spinner appears when we click the button.
    testWidgets('Tapping Auto-Detect triggers loading feedback', (WidgetTester tester) async {
      await tester.pumpWidget(const EmergencyDirectoryApp());

      // runAsync tells the test to wait for the background detecting logic to start.
      await tester.runAsync(() async {
        // Tap the button
        await tester.tap(find.text('AUTO-DETECT LOCATION'));
        
        // pump takes a snapshot of the screen immediately after the tap.
        await tester.pump(); 

        // Check: Do we see the spinning loading circle?
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      });
    });

    /// TEST 3: Check if pop-up windows (Dialogs) open and close.
    testWidgets('Location confirmation dialog logic works (Open & Dismiss)', (WidgetTester tester) async {
      // We build a temporary button just to test if a pop-up works.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Location Detected"),
                  content: const Text("Is Lagos correct?"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("NO")),
                  ],
                ),
              ),
              child: const Text("Trigger"),
            );
          }),
        ),
      ));

      // Click the trigger button
      await tester.tap(find.text("Trigger"));
      
      // pumpAndSettle waits for the pop-up animation (fade in) to finish.
      await tester.pumpAndSettle();

      // Check: Is the pop-up title visible?
      expect(find.text("Location Detected"), findsOneWidget);
      
      // Click NO to close the pop-up
      await tester.tap(find.text("NO"));
      
      // Wait for the closing animation (fade out) to finish.
      await tester.pumpAndSettle();
      
      // Check: Is the pop-up gone?
      expect(find.text("Location Detected"), findsNothing);
    });

    // --- 2. SEARCH & FILTERING (STATE SELECTION) ---

    /// TEST 4: Check if searching works even if the user types in lowercase.
    testWidgets('StateSelectionScreen handles case-insensitivity and empty results', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StateSelectionScreen()));
      final searchField = find.byType(TextField);

      // Type lagos (all lowercase) into the search box
      await tester.enterText(searchField, 'lagos');
      await tester.pump(); // Refresh the screen
      
      // Check: Does it still find Lagos (with a capital L)?
      expect(find.text('Lagos'), findsOneWidget);

      // Type a fake state that doesn't exist
      await tester.enterText(searchField, 'Unknown_State_Name');
      await tester.pump();
      
      // Check: Is the screen empty (no state cards showing)?
      expect(find.byType(Card), findsNothing); 
    });

    // --- 3. STATE DETAIL & DIRECTORY CONTENT ---

    /// TEST 5: Check if the phone numbers and print button appear for a specific state.
    testWidgets('StateDetailScreen renders Directory info and Print option', (WidgetTester tester) async {
      // Load the screen for Oyo state specifically
      await tester.pumpWidget(const MaterialApp(
        home: StateDetailScreen(stateName: 'Oyo'),
      ));

      // Check: Does the screen show Oyo?
      expect(find.textContaining('Oyo'), findsWidgets);
      
      // Check: Is there a list of numbers and a print icon?
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsWidgets);
      expect(find.byIcon(Icons.print), findsOneWidget);
    });

    // --- 4. CONTACT US & EXTERNAL LINKS ---

    /// TEST 6: Check if the Contact Us page has the right info.
    testWidgets('ContactUsScreen cards display metadata and support links', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ContactUsScreen()));

      // Check: Do we see the support icon, the email, and the code link?
      expect(find.byIcon(Icons.support_agent), findsOneWidget);
      expect(find.text('Email Us'), findsOneWidget);
      expect(find.text('View Source Code'), findsOneWidget);

      // Check: Is the actual email address correct?
      expect(find.text('e_link_group_2_project@gmail.com'), findsOneWidget);

      // Check: Does the card look raised (elevation 2)?
      final Card firstCard = tester.widget(find.byType(Card).first);
      expect(firstCard.elevation, equals(2));
    });
  });
}