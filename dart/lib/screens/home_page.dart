import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'state_selection_screen.dart';
import 'state_detail_screen.dart';
import 'about_us_screen.dart';
import 'contact_us_screen.dart';
import 'infographics_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  Future<void> _handleAutoDetection() async {
    setState(() => _isLoading = true);

    try {
      final response =
          await http.get(Uri.parse('https://ipapi.co/json/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String detectedState = data['region'] ?? "Unknown State";

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location Detected: $detectedState"),
            backgroundColor: Colors.green,
          ),
        );

        _showLocationConfirmation(detectedState);
      } else {
        throw Exception("Server error");
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Detection failed. Please select your state manually."),
          backgroundColor: Colors.red,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const StateSelectionScreen()),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLocationConfirmation(String state) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Confirm Location"),
        content: Text(
            "We detected your location as \"$state\".\n\nIs this correct?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const StateSelectionScreen()),
              );
            },
            child: const Text("SELECT MANUALLY"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      StateDetailScreen(stateName: state),
                ),
              );
            },
            child: const Text("PROCEED"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "SafeGuard Nigeria",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 140),
            child: Column(
              children: [
                _buildHeroSection(),
                _buildHowItWorksSection(),
                _buildSafetyBanner(),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(child: _buildDetectButton()),
          ),
        ],
      ),
    );
  }

  // ---------------- HERO SECTION ----------------

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFE53935)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: const [
          Icon(Icons.health_and_safety,
              size: 90, color: Colors.white),
          SizedBox(height: 20),
          Text(
            "Nigeria Emergency Directory",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Instant access to help across all 36 states",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HOW IT WORKS ----------------

  Widget _buildHowItWorksSection() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How SafeGuard Works",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            Icons.location_searching,
            "Detect Your State",
            "Automatically detect your current state or select manually.",
          ),
          const SizedBox(height: 15),
          _buildInfoCard(
            Icons.phone,
            "Access Verified Contacts",
            "View official emergency contact numbers for your state instantly.",
          ),
          const SizedBox(height: 15),
          _buildInfoCard(
            Icons.shield,
            "Stay Safe & Informed",
            "Follow safety instructions while waiting for assistance.",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Colors.red),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SAFETY BANNER ----------------

  Widget _buildSafetyBanner() {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.white),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Remain calm and stay on the line until the dispatcher confirms your location.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DETECT BUTTON ----------------

  Widget _buildDetectButton() {
    return Container(
      width: 300,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed:
            _isLoading ? null : _handleAutoDetection,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.location_searching),
        label: Text(
          _isLoading
              ? "DETECTING LOCATION..."
              : "AUTO-DETECT LOCATION",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)), elevation: 0),
      ),
    );
  }

  // ---------------- DRAWER ----------------

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "SafeGuard Nigeria",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text("Browse All States"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const StateSelectionScreen()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.health_and_safety_outlined),
            title: const Text("Crisis Response Guide"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const InfographicsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.message_outlined),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const ContactUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const AboutUsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
