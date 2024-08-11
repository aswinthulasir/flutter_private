import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_project/configs/firebase_config.dart';
import 'package:court_project/models/user_collection_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

class UserController {
  late final FirebaseAuth _auth;

  late FirebaseFirestore db;
  static final Signal<User?> userSignal = signal<User?>(null);
  static final Signal<UserCollection?> currentUserSignal =
      signal<UserCollection?>(null);

  UserController() {
    _auth = FirebaseAuth.instanceFor(
      app: FirebaseConfig.firebaseConfig.value!,
    );
    db = FirebaseFirestore.instance;
  }

  void listenToUserChanges() async {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        userSignal.value = null;
        currentUserSignal.value = null;
      } else {
        print('User is signed in!');

        userSignal.value = user;
        final userDetails = await getUserDetails(user.uid);
        currentUserSignal.value = userDetails;
      }
    });
  }

  Future<UserCredential?> signupWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
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

  Future<void> signinWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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

  Future<void> saveUserDetails({
    required String name,
    required String userUID,
    required int phoneNumber,
    required String email,
    required String theUPIID,
  }) async {
    try {
      final user = <String, dynamic>{
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "UPIID": theUPIID,
        "userUID": userUID,
      };

      await db.collection("users").add(user).then((value) {
        print("User added with ID: ${value.id}");
      });
    } catch (e) {
      rethrow;
    }
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

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
