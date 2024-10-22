import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/models/user_collection_model.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  late final FirebaseAuth auth;

  late FirebaseFirestore db;

  final LocalDatabase localDB = LocalDatabase();

  Stream<User?> authStateStream() async* {
    await for (User? user in FirebaseAuth.instance.authStateChanges()) {
      if (user != null) {
        final userDetails = await getUserDetails(user.uid);

        if (userDetails != null) {
          await localDB.saveUserData(
            userId: user.uid,
            email: userDetails.email,
            name: userDetails.name,
            phoneNumber: userDetails.phoneNumber,
            upiID: userDetails.upiID,
          );
          yield user;
        }
      } else {
        yield null;
      }
    }
  }

  UserController() {
    auth = FirebaseAuth.instanceFor(
      app: FirebaseConfig.firebaseConfig.value!,
    );
    db = FirebaseFirestore.instance;
  }

  Future<UserCredential?> signupWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        throw "The account already exists for that email.";
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }

  Future<UserCredential> signinWithEmailPassword(
      {required String email, required String password}) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        throw "Wrong password provided for that user.";
      } else {
        throw "An error occurred, please try again later.";
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateDeviceToken(String email) async {
    try {
      final deviceToken = await FirebaseConfig().accessDeviceToken();

      final user =
          await db.collection("users").where("email", isEqualTo: email).get();

      if (user.docs.isNotEmpty) {
        await db.collection("users").doc(user.docs.first.id).update({
          "deviceToken": deviceToken,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> saveUserDetails({
    required String name,
    required String userUID,
    required int phoneNumber,
    required String email,
    required String theUPIID,
  }) async {
    try {
      final deviceToken = await FirebaseConfig().accessDeviceToken();

      final user = <String, dynamic>{
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "UPIID": theUPIID,
        "userUID": userUID,
        "deviceToken": deviceToken,
      };

      return await db.collection("users").add(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPostedUserDeviceToken(String userUID) async {
    try {
      final user = await db
          .collection("users")
          .where("userUID", isEqualTo: userUID)
          .get();

      if (user.docs.isNotEmpty) {
        return user.docs.first.data()["deviceToken"];
      }
    } catch (e) {
      rethrow;
    }
    return "";
  }

  Future<UserCollection?> getUserDetails(String userUID) async {
    try {
      final user = await db
          .collection("users")
          .where("userUID", isEqualTo: userUID)
          .get();

      if (user.docs.isNotEmpty) {
        return UserCollection.fromMap(user.docs.first.data());
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> editUserDetails(String name, String email, String upiID) async {
    try {
      final user = await db
          .collection("users")
          .where("userUID", isEqualTo: localDB.getUserId())
          .get();

      if (user.docs.isNotEmpty) {
        await db.collection("users").doc(user.docs.first.id).update({
          "name": name,
          "email": email,
          "UPIID": upiID,
        });
      }

      localDB.saveUserData(
        userId: localDB.getUserId()!,
        email: email,
        name: name,
        phoneNumber: localDB.getPhoneNumber()!,
        upiID: upiID,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    localDB.clearUserData();
    await auth.signOut();
  }

  Future<void> resetPassword(String email) {
    try {
      return auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
