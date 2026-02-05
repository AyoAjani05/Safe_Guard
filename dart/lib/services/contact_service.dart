import '../models/contact.dart'; 
import 'dart:convert'; // Required for json.decode
import 'package:flutter/services.dart'; // Required for rootBundle

Future<List<Contact>> loadEmergencyData() async {
  // 1. Load the file as a string
  final String response = await rootBundle.loadString('assets/data/emergency.json');
  
  // 2. Decode the string into a JSON Map
  final data = await json.decode(response);

  // 3. Map the list items into Contact objects
  List<Contact> contacts = (data['emergency_contacts'] as List)
      .map((item) => Contact.fromJson(item))
      .toList();

  return contacts;
}
