import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';
import 'package:web/web.dart' as web;

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
  String _loadingMessage = "DETECTING LOCATION...";

  static const List<String> _nigerianStates = [
    'Abia', 'Adamawa', 'Akwa Ibom', 'Anambra', 'Bauchi', 'Bayelsa',
    'Benue', 'Borno', 'Cross River', 'Delta', 'Ebonyi', 'Edo',
    'Ekiti', 'Enugu', 'FCT', 'Gombe', 'Imo', 'Jigawa', 'Kaduna',
    'Kano', 'Katsina', 'Kebbi', 'Kogi', 'Kwara', 'Lagos', 'Nasarawa',
    'Niger', 'Ogun', 'Ondo', 'Osun', 'Oyo', 'Plateau', 'Rivers',
    'Sokoto', 'Taraba', 'Yobe', 'Zamfara',
  ];

  String _matchNigerianState(String raw) {
    final lower = raw.toLowerCase();

    for (final state in _nigerianStates) {
      if (lower.contains(state.toLowerCase())) return state;
    }

    if (lower.contains('abuja') || lower.contains('fct')) return 'FCT';
    if (lower.contains('port harcourt') || lower.contains('ph')) return 'Rivers';
    if (lower.contains('calabar')) return 'Cross River';
    if (lower.contains('uyo')) return 'Akwa Ibom';
    if (lower.contains('awka')) return 'Anambra';
    if (lower.contains('owerri')) return 'Imo';
    if (lower.contains('asaba')) return 'Delta';
    if (lower.contains('benin')) return 'Edo';
    if (lower.contains('ibadan')) return 'Oyo';
    if (lower.contains('abeokuta')) return 'Ogun';
    if (lower.contains('akure')) return 'Ondo';
    if (lower.contains('ado')) return 'Ekiti';
    if (lower.contains('osogbo')) return 'Osun';
    if (lower.contains('ilorin')) return 'Kwara';
    if (lower.contains('lokoja')) return 'Kogi';
    if (lower.contains('lafia')) return 'Nasarawa';
    if (lower.contains('jos')) return 'Plateau';
    if (lower.contains('makurdi')) return 'Benue';
    if (lower.contains('yola') || lower.contains('jimeta')) return 'Adamawa';
    if (lower.contains('maiduguri')) return 'Borno';
    if (lower.contains('damaturu')) return 'Yobe';
    if (lower.contains('gusau')) return 'Zamfara';
    if (lower.contains('birnin kebbi')) return 'Kebbi';
    if (lower.contains('sokoto')) return 'Sokoto';
    if (lower.contains('dutse')) return 'Jigawa';
    if (lower.contains('katsina')) return 'Katsina';
    if (lower.contains('kaduna')) return 'Kaduna';
    if (lower.contains('kano')) return 'Kano';
    if (lower.contains('bauchi')) return 'Bauchi';
    if (lower.contains('gombe')) return 'Gombe';
    if (lower.contains('jalingo')) return 'Taraba';
    if (lower.contains('minna') || lower.contains('kontagora')) return 'Niger';
    if (lower.contains('abakaliki')) return 'Ebonyi';
    if (lower.contains('umuahia')) return 'Abia';
    if (lower.contains('yenagoa')) return 'Bayelsa';

    return '';
  }

  Future<String?> _getLocationFromGPS() async {
    try {
      final gpsCompleter = Completer<String?>();

      web.window.navigator.geolocation.getCurrentPosition(
        (web.GeolocationPosition position) {
          if (!gpsCompleter.isCompleted) {
            final lat = position.coords.latitude;
            final lng = position.coords.longitude;
            gpsCompleter.complete('$lat,$lng');
          }
        }.toJS,
        (web.GeolocationPositionError error) {
          if (!gpsCompleter.isCompleted) {
            gpsCompleter.complete(null);
          }
        }.toJS,
        web.PositionOptions(
          enableHighAccuracy: true,
          timeout: 4000,
          maximumAge: 30000,
        ),
      );

      final coords = await gpsCompleter.future
          .timeout(
            const Duration(seconds: 4),
            onTimeout: () => null,
          );

      if (coords == null) return null;

      final parts = coords.split(',');
      final lat = parts[0];
      final lng = parts[1];

      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json',
        ),
        headers: {'Accept-Language': 'en'},
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'] ?? {};
        final state = address['state'] ??
            address['region'] ??
            address['county'] ??
            address['city'] ??
            '';
        return state.isNotEmpty ? state : null;
      }
    } catch (e) {
      debugPrint('GPS error: $e');
    }
    return null;
  }

  Future<String?> _getLocationFromIP() async {
    try {
      final response = await http
          .get(Uri.parse('https://ipapi.co/json/'))
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final region = data['region'] ?? data['city'] ?? '';
        return region.isNotEmpty ? region : null;
      }
    } catch (e) {
      debugPrint('IP error: $e');
    }
    return null;
  }

  Future<void> _handleAutoDetection() async {
    setState(() {
      _isLoading = true;
      _loadingMessage = "DETECTING LOCATION...";
    });

    int secondsLeft = 4;
    final countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        secondsLeft--;
        if (!mounted) { timer.cancel(); return; }
        if (secondsLeft > 0) {
          setState(() => _loadingMessage = "DETECTING... ${secondsLeft}s");
        } else {
          timer.cancel();
        }
      },
    );

    try {
      final gpsFuture = _getLocationFromGPS();
      final ipFuture = _getLocationFromIP();

      String? detectedState;
      String source = '';

      final String? gpsRaw = await gpsFuture.timeout(
        const Duration(seconds: 4),
        onTimeout: () => null,
      );

      if (gpsRaw != null && gpsRaw.isNotEmpty) {
        final matched = _matchNigerianState(gpsRaw);
        if (matched.isNotEmpty) {
          detectedState = matched;
          source = 'GPS';
        }
      }

      if (detectedState == null) {
        final String? ipRaw = await ipFuture.timeout(
          const Duration(seconds: 2),
          onTimeout: () => null,
        );

        if (ipRaw != null && ipRaw.isNotEmpty) {
          final matched = _matchNigerianState(ipRaw);
          if (matched.isNotEmpty) {
            detectedState = matched;
            source = 'IP';
          }
        }
      }

      countdownTimer.cancel();
      if (!mounted) return;

      if (detectedState != null) {
        debugPrint('Location detected via $source: $detectedState');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location Detected: $detectedState"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        _showLocationConfirmation(detectedState);
      } else {
        _goToManualSelection(showMessage: true);
      }
    } catch (e) {
      countdownTimer.cancel();
      if (!mounted) return;
      _goToManualSelection(showMessage: true);
    } finally {
      countdownTimer.cancel();
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingMessage = "DETECTING LOCATION...";
        });
      }
    }
  }

  void _goToManualSelection({bool showMessage = false}) {
    if (showMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not detect location. Please select your state.",
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StateSelectionScreen()),
    );
  }

  void _showLocationConfirmation(String state) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Confirm Location"),
        content: Text(
          "We detected your location as \"$state\".\n\nIs this correct?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _goToManualSelection();
            },
            child: const Text("SELECT MANUALLY"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StateDetailScreen(stateName: state),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 700;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "SafeGuard Nigeria",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.white),
        ),
      ),
      drawer: _buildModernDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                _buildHeroSection(screenWidth),
                _buildHowItWorksSection(isLargeScreen),
                _buildSafetyBanner(),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(child: _buildDetectButton(screenWidth)),
          ),
        ],
      ),
    );
  }

  // --- Responsive Hero Section ---
  Widget _buildHeroSection(double screenWidth) {
    final verticalPadding = screenWidth > 600 ? 60.0 : 50.0;
    final horizontalPadding = screenWidth > 600 ? 40.0 : 25.0;
    final titleFontSize = screenWidth > 600 ? 28.0 : 24.0;
    final subtitleFontSize = screenWidth > 600 ? 16.0 : 14.0;
    final iconSize = screenWidth > 600 ? 100.0 : 90.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
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
        children: [
          Icon(Icons.health_and_safety, size: iconSize, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            "Nigeria Emergency Directory",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Instant access to help across all 36 states",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleFontSize,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // --- Responsive How It Works Section ---
  Widget _buildHowItWorksSection(bool isLargeScreen) {
    final cardPadding = isLargeScreen ? 24.0 : 18.0;
    final iconSize = isLargeScreen ? 40.0 : 32.0;
    final titleFontSize = isLargeScreen ? 16.0 : 14.0;
    final descFontSize = isLargeScreen ? 13.0 : 12.0;

    Widget card(IconData icon, String title, String description) {
      return Container(
        padding: EdgeInsets.all(cardPadding),
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
            Icon(icon, size: iconSize, color: Colors.red),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: descFontSize,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How SafeGuard Works",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          if (isLargeScreen)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: card(Icons.location_searching, "Detect Your State", "Automatically detect your current state or select manually.")),
                const SizedBox(width: 15),
                Expanded(child: card(Icons.phone, "Access Verified Contacts", "View official emergency contact numbers for your state instantly.")),
                const SizedBox(width: 15),
                Expanded(child: card(Icons.shield, "Stay Safe & Informed", "Follow safety instructions while waiting for assistance.")),
              ],
            )
          else
            Column(
              children: [
                card(Icons.location_searching, "Detect Your State", "Automatically detect your current state or select manually."),
                const SizedBox(height: 15),
                card(Icons.phone, "Access Verified Contacts", "View official emergency contact numbers for your state instantly."),
                const SizedBox(height: 15),
                card(Icons.shield, "Stay Safe & Informed", "Follow safety instructions while waiting for assistance."),
              ],
            ),
        ],
      ),
    );
  }

  // --- Safety Banner ---
  Widget _buildSafetyBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.white),
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

  // --- Detect Button (responsive width) ---
  Widget _buildDetectButton(double screenWidth) {
    final buttonWidth = (screenWidth * 0.8).clamp(280.0, 400.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: buttonWidth,
          height: 65,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _handleAutoDetection,
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
              _isLoading ? _loadingMessage : "AUTO-DETECT LOCATION",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              elevation: 0,
            ),
          ),
        ),
        if (_isLoading) ...[
          const SizedBox(height: 10),
          const Text(
            "Allow location access if prompted...",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ],
    );
  }

  // --- MODERN, RESPONSIVE DRAWER with consistent red gradient background ---
  Widget _buildModernDrawer() {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth > 600 ? 320.0 : screenWidth * 0.75;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: drawerWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB71C1C), Color(0xFFE53935)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with app name (no extra gradient, since background already has it)
            Container(
              height: 140,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "SafeGuard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Nigeria",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Drawer items with white text and icons
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.home,
                    label: "Home",
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    icon: Icons.map_outlined,
                    label: "Browse All States",
                    onTap: () {
                      Navigator.pop(context);
                      _goToManualSelection();
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.health_and_safety_outlined,
                    label: "Crisis Response Guide",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const InfographicsScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.message_outlined,
                    label: "Contact Us",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline,
                    label: "About Us",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                      );
                    },
                  ),
                  const Divider(color: Colors.white30),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "v1.0.0",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.white.withOpacity(0.1),
      splashColor: Colors.white.withOpacity(0.2),
    );
  }
}