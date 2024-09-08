// import 'dart:async';

// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class InternetConnectivity {
//   final connectionChecker = InternetConnectionChecker();

//   StreamSubscription<InternetConnectionStatus>
//       listenToInternetConnectionStatus() {
//     return connectionChecker.onStatusChange.listen(
//       (InternetConnectionStatus status) {
//         if (status == InternetConnectionStatus.connected) {
//           print('Connected to the internet');
//         } else {
//           print('Disconnected from the internet');
//         }
//       },
//     );
//   }
// }
