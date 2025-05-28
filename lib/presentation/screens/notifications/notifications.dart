// import 'package:user_appointment/constants/notifications.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class NotificationTestPage extends StatefulWidget {
//   const NotificationTestPage({super.key});
//
//   @override
//   State<NotificationTestPage> createState() => NotificationTestPageState();
// }
//
// class NotificationTestPageState extends State<NotificationTestPage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   @override
//   void initState() {
//     startOnInital();
//     myRequestPermission();
//     super.initState();
//   }
//
//   void _handleSignOut(BuildContext context) async {
//     try {
//       FirebaseAuth.instance.signOut();
//       await _googleSignIn.signOut();
//       // After sign out, navigate to the login or home screen
//       // Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //         builder: (context) =>
//       //             const Login())); // Replace '/login' with your desired route
//     } catch (error) {
//       print("Error signing out: $error");
//     }
//   }
//
//   startOnInital() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // RemoteNotification? notification = message.notification;
//       //  AndroidNotification? android = message.notification?.android;
//       if (message.notification != null) {
//         print("======================================= onForgroundMessage ");
//         print("${message.notification!.title} ");
//         print("${message.notification!.body} ");
//         print(message.data);
//         print("======================================= onForgroundMessage");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("${message.notification!.body}")),
//         );
//         print("======================================= ");
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (message.data["type"] == "test") {
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (context) => const AddPost(),
//         //   ),
//         // );
//         print("title ============ ${message.notification!.title!}");
//         print("body ===========  ${message.notification!.title!}");
//       }
//     });
//   }
//
//   myRequestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notification Test Page"),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           color: Colors.lightBlue[200],
//           fontWeight: FontWeight.w800,
//           fontSize: 28,
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.only(left: 160),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // sendFCMMessage(context);
//               },
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(Colors.lightBlue[100]),
//                 foregroundColor: const WidgetStatePropertyAll(Colors.white),
//               ),
//               child: const Text("Send"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _handleSignOut(context);
//               },
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(Colors.lightBlue[100]),
//                 foregroundColor: const WidgetStatePropertyAll(Colors.white),
//               ),
//               child: const Text("Log Out"),
//             ),
//             MaterialButton(
//               color: Colors.red.shade900,
//               textColor: Colors.white,
//               onPressed: () {
//                 FirebaseMessaging.instance.subscribeToTopic('fares');
//               },
//               child: const Text("subscribeToTopic"),
//             ),
//             MaterialButton(
//               color: Colors.red.shade900,
//               textColor: Colors.white,
//               onPressed: () {
//                 FirebaseMessaging.instance.unsubscribeFromTopic('fares');
//               },
//               child: const Text("unsubscribeToTopic"),
//             ),
//             MaterialButton(
//               color: Colors.red.shade900,
//               textColor: Colors.white,
//               onPressed: () {
//                 sendFCMMessage(
//                   context,
//                   "hello",
//                   "This notifiactions from your flutter app",
//                   "fares",
//                   "",
//                 );
//               },
//               child: const Text("Send Message toics"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
