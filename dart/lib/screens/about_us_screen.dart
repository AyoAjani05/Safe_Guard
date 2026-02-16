import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Soft background color for better contrast
      backgroundColor: const Color(0xFFFBFBFB), 
      appBar: AppBar(
        title: const Text('About SafeGuard Nigeria', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFD32F2F), // A more professional red
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header spacing
            const SizedBox(height: 24),
            
            // Vision Section
            _buildModernSection(
              context,
              title: "The Vision",
              body: "A Nigeria where no one has to panic because they don't know who to call.",
              icon: Icons.remove_red_eye_rounded,
            ),

            // Mission Section
            _buildModernSection(
              context,
              title: "The Mission",
              body: "Using simple technology to connect people in trouble with the right help, instantly.",
              icon: Icons.auto_awesome_rounded,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Divider(color: Color(0xFFEEEEEE), thickness: 1),
            ),

            const Text(
              "Meet The Team",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D)),
            ),

            const SizedBox(height: 20),

            // Team Grid using a clean Wrap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildTeamMember("Ajani Ayooluwa Emmanuel", "Lead Developer"),
                  _buildTeamMember("Ajayi David Ebenezer", "UI/UX Designer"),
                  _buildTeamMember("Adekunle Tobiloba Hepzibah", "Requirements Analyst"),
                  _buildTeamMember("Adekunle Peter Oluwadarasimi", "Quality Assurance"),
                  _buildTeamMember("Adeyemo Blessing Motunrayo", "Deployment Engineering"),
                  _buildTeamMember("Ajayi Ayomide Oluwatimilehin", "Documentation"),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSection(BuildContext context, {required String title, required String body, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Very soft shadow for a "premium" feel
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFFD32F2F), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: const TextStyle(fontSize: 15, color: Color(0xFF616161), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Container(
      width: 160,
      height: 200, 
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFF5F5F5),
            child: const Icon(Icons.person_rounded, color: Color(0xFF9E9E9E), size: 30),
          ),
          const SizedBox(height: 12),
          
          Text(
            name,
            textAlign: TextAlign.center, 
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF212121)),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ],
      ),
    );
  }
}