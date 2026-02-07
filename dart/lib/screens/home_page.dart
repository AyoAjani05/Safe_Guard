import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SafeGuard Nigeria", 
        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), boxShadow: [BoxShadow(color: Colors.red, blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 8))]),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.location_searching),
          label: const Text("AUTO-DETECT LOCATION", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, 
          foregroundColor: Colors.white, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)), 
          elevation: 0
        )
      ),
    );
  }
}