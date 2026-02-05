class Contact {
  final String name;
  final String phoneNumber;
  final String category;
  final String state;

  Contact({
    required this.name, 
    required this.phoneNumber, 
    required this.category, 
    required this.state
  });

  // This converts the JSON Map into a Contact object
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      category: json['category'],
      state: json['state'],
    );
  }
}