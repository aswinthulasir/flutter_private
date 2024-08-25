import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/models/case_model.dart';

class CaseController {
  final db = FirebaseFirestore.instance;

  Future<String> postCase({
    required String userId,
    required int mobileNumber,
    required DateTime date,
    required String state,
    required String district,
    required String court,
    required String advocateName,
    required String caseDescription,
  }) async {
    // Post case to the database
    try {
      final caseToBePosted = <String, dynamic>{
        "userId": userId,
        'mobileNumber': mobileNumber,
        'date': date,
        'state': state,
        'district': district,
        'court': court,
        'advocateName': advocateName,
        'caseDescription': caseDescription,
      };

      final response = await db.collection("cases").add(caseToBePosted);

      return response.id;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Case>> getCases({
    required String state,
    required String district,
    required String date,
  }) async {
    // Get cases from the database
    try {
      final response = await db
          .collection("cases")
          .where("state", isEqualTo: state)
          .where("district", isEqualTo: district)
          .where("date", isEqualTo: date)
          .get();

      final result =
          response.docs.map((doc) => Case.fromFirestore(doc, null)).toList();
      return result;
    } catch (err) {
      rethrow;
    }
  }
}
