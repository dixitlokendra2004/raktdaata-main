import 'package:cloud_firestore/cloud_firestore.dart';

class Donor {
  final String name;
  final String email;
  final String mobileNumber;
  final String bloodGroup;
  final DateTime bloodDonationDate;
  final String city;

  Donor({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.bloodGroup,
    required this.bloodDonationDate,
    required this.city,
  });

  factory Donor.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Donor(
      name: doc['name'] ?? '',
      email: doc['email'] ?? '',
      mobileNumber: doc['mobileNumber'] ?? '',
      bloodGroup: doc['bloodGroup'] ?? '',
      bloodDonationDate: (doc['bloodDonationDate'] as Timestamp).toDate(),
      city: doc['city'] ?? '',
    );
  }
}
