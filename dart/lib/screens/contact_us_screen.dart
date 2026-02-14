import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  // Helper function to launch email/web
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.support_agent, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "Found a wrong number?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Help us keep the directory accurate. If you notice an outdated number or want to suggest a new agency, reach out to us.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            // Contact Options
            _contactCard(
              icon: Icons.email,
              title: "Email Us",
              subtitle: "e_link_group_2_project@gmail.com",
              color: Colors.blue,
              onTap: () => _launchURL('mailto:e_link_group_2_project@gmail.com?subject=E-Link App Feedback'),
            ),
            
            _contactCard(
              icon: Icons.code,
              title: "View Source Code",
              subtitle: "GitHub Repository",
              color: Colors.black,
              onTap: () => _launchURL('https://www.google.com/search?q=go+and+write+your+own+code&sca_esv=bf53f4a5ff9fe53b&ei=aU19ac6FEPKChbIPsqbdYQ&ved=0ahUKEwiO3s2zw7SSAxVyQUEAHTJTNwwQ4dUDCBE&uact=5&oq=go+and+write+your+own+code&gs_lp=Egxnd3Mtd2l6LXNlcnAiGmdvIGFuZCB3cml0ZSB5b3VyIG93biBjb2RlMgUQIRifBTIFECEYnwVIlmdQAFi4VnAHeACQAQGYAYAEoAHLPKoBDDAuMy4yNy4xLjAuMbgBA8gBAPgBAZgCJqAC8jqoAgrCAhYQABiABBhDGLQCGOcGGIoFGOoC2AEBwgIWEC4YgAQYQxi0AhjnBhiKBRjqAtgBAcICChAAGIAEGEMYigXCAgsQABiABBixAxiDAcICERAuGIAEGLEDGNEDGIMBGMcBwgIIEAAYgAQYsQPCAg4QABiABBixAxiDARiKBcICDhAuGIAEGLEDGIMBGIoFwgIWEC4YgAQYsQMY0QMYQxiDARjHARiKBcICEBAAGIAEGLEDGEMYgwEYigXCAg0QABiABBixAxhDGIoFwgIFEAAYgATCAgUQLhiABMICCxAAGIAEGLEDGIoFwgIIEC4YgAQYsQPCAgoQLhiABBhDGIoFwgINEC4YgAQYsQMYQxiKBcICEBAuGIAEGNEDGEMYxwEYigXCAgQQABgDwgIJEAAYgAQYChgLwgIJEC4YgAQYChgLwgIGEAAYFhgewgIIEAAYFhgKGB7CAgsQABiABBiGAxiKBcICBRAAGO8FwgIIEAAYCBgNGB7CAggQABiiBBiJBcICBRAhGKABwgIIEAAYgAQYogSYAwvxBfI8ubxJV4NyugYECAEYB5IHCDcuMS4yOC4yoAf46QGyBwgwLjEuMjguMrgHtTrCBwgwLjQuMjkuNcgH4gGACAA&sclient=gws-wiz-serp'),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}