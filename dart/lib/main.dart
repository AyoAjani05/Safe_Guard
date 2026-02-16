import 'package:flutter/material.dart';
import 'screens/home_page.dart'; // The new Landing Hub with GPS

void main() {
  runApp(const EmergencyDirectoryApp());
}

class EmergencyDirectoryApp extends StatelessWidget {
  const EmergencyDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGuard Nigeria',
      debugShowCheckedModeBanner: false,
      
      // --- THEME CONFIGURATION ---
      // This sets the "Emergency Red" branding globally as per your project theme
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Montserrat",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.red,
          secondary: Colors.redAccent,
        ),
        // Customizing the AppBar globally for a consistent look
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w900, 
            letterSpacing: 1.2
          ),
        ),

        // Applying the "Minimalist" look to all buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      // --- INITIAL ROUTE ---
      // Starting with the HomePage (Landing/GPS Hub)
      home: const HomePage(),
    );
  }
}