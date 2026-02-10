import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Added for HTTPS requests
import 'dart:convert'; // Added for JSON decoding
import 'state_selection_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Loading state to show the spinner
  bool _isLoading = false;

  // 2. Function to handle detection via HTTPS (Works on Vercel)
  Future<void> _handleAutoDetection() async {
    setState(() => _isLoading = true);

    try {
      // Using ipapi.co because it supports HTTPS for free
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String detectedState = data['region'] ?? "Unknown State";
        
        if (!mounted) return;
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location Detected: $detectedState"),
            backgroundColor: Colors.green,
          ),
        );
        _showLocationConfirmation(detectedState);
      } else {
        throw Exception("Failed to reach server");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Detection failed. Please select your state manually."),
          backgroundColor: Colors.red,
        ),
      );
      _showErrorAndRedirect();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLocationConfirmation(String state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Detected"),
        content: Text("We detected your location as $state. Is this correct?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StateSelectionScreen()));
            },
            child: const Text("NO, SELECT MANUALLY"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => StateDetailScreen(stateName: state)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text("YES, PROCEED"),
          ),
        ],
      ),
    );
  }

  void _showErrorAndRedirect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Auto-detect failed. Please select manually.")),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => const StateSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SafeGuard Nigeria", 
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.red)
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildSafetyTicker(),
                const SizedBox(height: 120), 
              ],
            ),
          ),
          Positioned(
            bottom: 30, left: 0, right: 0,
            child: Center(child: _buildStickyDetectButton()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.red.shade50, Colors.white]),
      ),
      child: const Column(
        children: [
          Icon(Icons.health_and_safety, size: 100, color: Colors.red),
          SizedBox(height: 20),
          Text("NIGERIA EMERGENCY\nDIRECTORY", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 1.2)),
          SizedBox(height: 10),
          Text("Instant access to help across all 36 states", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSafetyTicker() {
    return Container(
      margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.red.shade900, borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.white),
          SizedBox(width: 15),
          Expanded(child: Text("IMPORTANT: Always stay on the line until the dispatcher confirms your location.", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildStickyDetectButton() {
    return Container(
      width: 280, height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35), 
        boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 8))]
      ),
      child: ElevatedButton.icon(
        // Disable button while loading
        onPressed: _isLoading ? null : _handleAutoDetection,
        icon: _isLoading 
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Icon(Icons.location_searching),
        label: Text(_isLoading ? "DETECTING..." : "AUTO-DETECT LOCATION", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, 
          foregroundColor: Colors.white, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)), 
          elevation: 0,
          disabledBackgroundColor: Colors.red.withOpacity(0.6), // Stay red-ish even when disabled
        ),
      ),
    );
  }
}