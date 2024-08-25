import 'package:cloud_firestore/cloud_firestore.dart';

class Case {
  final String id;
  final String userId;
  final int mobileNumber;
  final DateTime date;
  final String state;
  final String district;
  final String court;
  final String advocateName;
  final String caseDescription;

  Case({
    required this.userId,
    required this.id,
    required this.mobileNumber,
    required this.date,
    required this.state,
    required this.district,
    required this.court,
    required this.advocateName,
    required this.caseDescription,
  });

  factory Case.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Case(
      userId: data?["userId"],
      id: snapshot.id,
      mobileNumber: data?['mobileNumber'],
      date: data?['date'],
      state: data?['state'],
      district: data?['district'],
      court: data?['court'],
      advocateName: data?['advocateName'],
      caseDescription: data?['caseDescription'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'mobileNumber': mobileNumber,
      'date': date,
      'state': state,
      'district': district,
      'court': court,
      'advocateName': advocateName,
      'caseDescription': caseDescription,
    };
  }
}
