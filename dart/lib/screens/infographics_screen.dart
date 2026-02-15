import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfographicsScreen extends StatelessWidget {
  const InfographicsScreen({super.key});

  // Helper to handle external links and phone calls
  void _launch(String url) async {
    final Uri uri = Uri.parse(url);
    
    // It tells the browser: Leave this website and find the Phone App.
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // If it's a desktop with no calling app, show a snackbar with the number
      // so the user can at least see it.
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        title: const Text('Crisis Response Guide', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. NATIONAL HOTLINE HERO SECTION
            _buildDetailedHero(),

            // 2. EMERGENCY TRIAGE (Helping users decide urgency)
            _buildSectionHeader("Emergency Triage Guide"),
            _buildTriageSection(),

            const SizedBox(height: 20),

            // 3. STANDARD OPERATING PROCEDURES (SOP)
            _buildSectionHeader("Reporting Protocol (SOP)"),
            _buildDetailedProtocol(),

            const SizedBox(height: 20),

            // 4. MEDICAL ACTION GRID (First Aid)
            _buildSectionHeader("Immediate Life-Saving Actions"),
            _buildMedicalActionGrid(),

            const SizedBox(height: 20),

            // 5. DATA INSIGHTS
            _buildDataInsights(),

            const SizedBox(height: 20),

            // 6. FREQUENTLY ASKED QUESTIONS
            _buildSectionHeader("Frequently Asked Questions"),
            _buildDetailedFAQ(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: HERO ---
  Widget _buildDetailedHero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFB71C1C),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text("FEDERAL REPUBLIC OF NIGERIA", 
            style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 12),
          const Text("112 / 199", 
            style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
          const Text("National Emergency Communications Centres", 
            style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _heroQuickButton(Icons.phone, "Call 112", "tel:112"),
              const SizedBox(width: 15),
              _heroQuickButton(Icons.message, "Text Help", "sms:112"),
            ],
          ),
        ],
      ),
    );
  }

  // --- SECTION 2: TRIAGE ---
  Widget _buildTriageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            _triageRow(Colors.red, "RED: Critical", "Life-threatening. (No breathing, heavy bleeding, unconscious)"),
            const Divider(),
            _triageRow(Colors.orange, "YELLOW: Urgent", "Serious but stable. (Fractures, severe pain, deep cuts)"),
            const Divider(),
            _triageRow(Colors.green, "GREEN: Non-Urgent", "Minor injuries. (Mild fever, small scrapes, sprains)"),
          ],
        ),
      ),
    );
  }

  // --- SECTION 3: PROTOCOL (SOP) ---
  Widget _buildDetailedProtocol() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _protocolStep("1", "Check Safety", "Ensure the scene is safe for you before approaching the victim."),
          const Divider(height: 30),
          _protocolStep("2", "State Location", "Identify your State and the nearest landmark immediately."),
          const Divider(height: 30),
          _protocolStep("3", "Be Specific", "Describe the situation clearly (e.g., 'Two-car collision with injuries')."),
          const Divider(height: 30),
          _protocolStep("4", "Follow Guidance", "Stay on the line for dispatcher instructions until help arrives."),
        ],
      ),
    );
  }

  // --- SECTION 4: MEDICAL GRID ---
  Widget _buildMedicalActionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
        children: [
          _medicalCard("CARDIAC ARREST", "Perform CPR: 30 compressions followed by 2 breaths.", Icons.favorite, Colors.red[50]!),
          _medicalCard("CHOKING", "Give 5 back blows followed by 5 abdominal thrusts.", Icons.air, Colors.blue[50]!),
          _medicalCard("SEIZURES", "Protect the head. Do not place anything in their mouth.", Icons.bolt, Colors.amber[50]!),
          _medicalCard("HEAVY BLEEDING", "Apply direct pressure with a clean cloth immediately.", Icons.warning, Colors.green[50]!),
        ],
      ),
    );
  }

  // --- SECTION 5: DATA INSIGHTS ---
  Widget _buildDataInsights() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF263238), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const Text("NIGERIA EMERGENCY SYSTEM STATS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem("36", "States Active"),
              _statItem("24/7", "Response"),
              _statItem("112", "NCC Nodes"),
            ],
          ),
        ],
      ),
    );
  }

  // --- SECTION 6: FAQ ---
  Widget _buildDetailedFAQ() {
    return Column(
      children: [
        _faqTile("Does 112 work without airtime?", "Yes. 112 is a toll-free number and works even with zero balance."),
        _faqTile("Can I report anonymously?", "Yes, but providing your details helps responders verify the emergency."),
        _faqTile("Is 199 different from 112?", "Both connect to the National Emergency Centre, but 112 is the primary global standard."),
      ],
    );
  }

  // --- REUSABLE WIDGET HELPERS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Align(alignment: Alignment.centerLeft, 
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)))),
    );
  }

  Widget _heroQuickButton(IconData icon, String label, String url) {
    return ElevatedButton.icon(
      onPressed: () => _launch(url),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFB71C1C),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _triageRow(Color color, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, color: color, size: 14),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            ],
          ))
        ],
      ),
    );
  }

  Widget _protocolStep(String step, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 12, backgroundColor: const Color(0xFFD32F2F),
          child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
        const SizedBox(width: 16),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        )),
      ],
    );
  }

  Widget _medicalCard(String title, String desc, IconData icon, Color bg) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color.fromRGBO(0, 0, 0, 0.867), size: 28),
          const SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 5),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, height: 1)),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _faqTile(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        children: [Padding(padding: const EdgeInsets.all(16), child: Text(answer, style: const TextStyle(fontSize: 13, color: Colors.black54)))],
      ),
    );
  }
}