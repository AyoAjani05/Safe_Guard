import 'package:flutter/material.dart';
import '../data/emergency_data.dart';
import 'package:url_launcher/url_launcher.dart';

class StateDetailScreen extends StatelessWidget {
  final String stateName;

  const StateDetailScreen({super.key, required this.stateName});

  // THE LAUNCHER LOGIC
  Future<void> _launch(BuildContext context, String phoneNumber) async {
    // Clean the number (remove spaces) and add the tel: prefix
    final String cleanNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri uri = Uri.parse('tel:$cleanNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback: If it's a desktop or dialer fails, show the number clearly
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dialing not supported on this device. Number: $phoneNumber'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
      debugPrint("Could not launch $uri");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logic: Filter the database for contacts belonging to this state
    final stateContacts = emergencyDatabase
        .where((contact) => contact.state == stateName || contact.state == "Nationwide")
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$stateName Directory'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: stateContacts.isEmpty
          ? const Center(child: Text("No contacts found for this state."))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: stateContacts.length,
              itemBuilder: (context, index) {
                final contact = stateContacts[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryColor(contact.category),
                      child: Icon(_getCategoryIcon(contact.category), color: Colors.white),
                    ),
                    title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(contact.phoneNumber),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
                      onPressed: () => _launch(context, contact.phoneNumber), 
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Helper functions for UI styling
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Police': return Colors.blue;
      case 'Fire': return Colors.orange;
      case 'Hospital': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Police': return Icons.local_police;
      case 'Fire': return Icons.fire_truck;
      case 'Hospital': return Icons.local_hospital;
      default: return Icons.contact_phone;
    }
  }
}