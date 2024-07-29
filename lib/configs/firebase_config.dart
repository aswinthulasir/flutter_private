import 'package:court_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signals/signals.dart';

class FirebaseConfig {
  static Signal<FirebaseApp?> firebaseConfig = signal<FirebaseApp?>(null);

  Future<FirebaseApp> initialiseFirebase() async {
    final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebase;
  }
}
