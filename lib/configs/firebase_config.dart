import 'package:court_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:signals/signals.dart';

class FirebaseConfig {
  static Signal<FirebaseApp?> firebaseConfig = signal<FirebaseApp?>(null);

  Future<FirebaseApp> initialiseFirebase() async {
    final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebase;
  }

  Future<String?> accessDeviceToken() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      final token = await FirebaseMessaging.instance.getToken();

      return token;
    }
    return null;
  }
}
