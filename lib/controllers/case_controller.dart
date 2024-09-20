import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/models/case_model.dart';

import 'package:http/http.dart' as http;

class CaseController {
  final db = FirebaseFirestore.instance;

  final _baseUrl = "https://court-notifications-backend.onrender.com";

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

  Future<void> editCase({
    required String caseId,
    required int mobileNumber,
    required DateTime date,
    required String state,
    required String district,
    required String court,
    required String advocateName,
    required String caseDescription,
  }) async {
    try {
      final caseToBeEdited = <String, dynamic>{
        'mobileNumber': mobileNumber,
        'date': date,
        'state': state,
        'district': district,
        'court': court,
        'advocateName': advocateName,
        'caseDescription': caseDescription,
      };

      await db.collection("cases").doc(caseId).update(caseToBeEdited);
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Case>> getCases({
    String? state,
    String? district,
    String? date,
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

  Future<List<Case>> getPostedCases(String userid) {
    try {
      final response = db
          .collection("cases")
          .where("userId", isEqualTo: userid)
          .get()
          .then((value) {
        return value.docs.map((doc) => Case.fromFirestore(doc, null)).toList();
      });

      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Case>> getTakenCases(String userid) async {
    try {
      final response = await db
          .collection("taken-cases")
          .where("takenUserId", isEqualTo: userid)
          .get();

      final result = await Future.wait(response.docs.map((doc) async {
        final caseId = doc.data()["caseId"] as String;
        final caseData = await db.collection("cases").doc(caseId).get();
        return Case.fromFirestore(caseData, null);
      }));

      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> takeCase(String caseId, String takenUserId,
      String courtComplexName, String postedDeviceToken) async {
    try {
      final isExists = await db
          .collection("taken-cases")
          .where("caseId", isEqualTo: caseId)
          .where("takenUserId", isEqualTo: takenUserId)
          .get();

      if (isExists.docs.isNotEmpty) {
        throw "Case already taken";
      } else {
        await db.collection("taken-cases").add({
          "takenUserId": takenUserId,
          "caseId": caseId,
        });

        var url = Uri.https(_baseUrl, 'takenCaseNotification');
        var response = await http.post(url, body: {
          "advocate_name": UserController.currentUserSignal.value!.name,
          "court_complex": courtComplexName,
          "deviceToken": postedDeviceToken
        });
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> removeTakenCase(
      String caseId, String userId, String courtComplexName, String postedUserId) async {
    try {
      final response = await db
          .collection("taken-cases")
          .where("caseId", isEqualTo: caseId)
          .where("takenUserId", isEqualTo: userId)
          .get();

      final docId = response.docs.first.id;
      await db.collection("taken-cases").doc(docId).delete();

      final postedDeviceToken =
          await UserController().getPostedUserDeviceToken(postedUserId);

      var url = Uri.https(_baseUrl, 'takenCaseNotification');
      var res = await http.post(url, body: {
        "advocate_name": userId,
        "court_complex": courtComplexName,
        "deviceToken": postedDeviceToken
      });
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteCase(String caseId) async {
    try {
      await db.collection("cases").doc(caseId).delete();
    } catch (err) {
      rethrow;
    }
  }
}
