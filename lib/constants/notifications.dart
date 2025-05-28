import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:user_appointment/business_logic/chat/chat_cubit.dart';
import 'package:user_appointment/main.dart';
import 'package:user_appointment/presentation/screens/chats/chatpage.dart';
import 'package:user_appointment/presentation/screens/notifications/localnotify.dart';

//late final String currentFCMToken;

Future<String> getAccessToken() async {
  // Your client ID and client secret obtained from Google Cloud Console
  final serviceAccountJson = {
    "type": "service_account",
    "project_id": "doctorappointment-f0d02",
    "private_key_id": "6f64fa046a2d42ce8e17533090b9190228157a9e",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYXzX8G/1p7RwD\nRlNOLnP05ZYmntqBOEXkU/dSivrhcI72BxvNM2BsyqNQcm5GmwmpWui9LHZ3BEkf\nyNuVTie4dk6La6JGpuCpazEqDW0ch725FLHfZdMo24y5cWdD2LE5fj8nsiW3SY4+\npCyAAXWoVlP2E6zOMw6Tavhv0VQeEZyihN0Dem34H/uA3oBD+5OGQkadmxjacs/S\nJ5C6WITRrhVOQ9JGlmHE6GUDO5hDx/s7nlJALd2yb22/Pw6ppPFzgBMRyRtKDU89\n3qfA1VhNJHTJGYChRFywm/JvSyjOPEUB6pQg/S60uZ1fRA8m9rxRdXCdpUwl1fTF\nP/7t+e8LAgMBAAECggEAD4Se2GK3X9rcn/7BDDTR7W6WaK+D/GYRRCxDA36RB3Wx\nsZ/OtorVdq76i/5jecBfbwaJrn6BQCTJF7oalu2jQPeXjz5yg/SJ6+c1Vh2Q77dp\nXJiddu2FYGNfxSEmDbRbdEoFv5K2oaCVoo6Q06aSZ4cHPQgK8OMlSGE8FRNCGF+1\nkkuy7Lb+5/r3YTgWFuWYUSBFSMngdo55dQoQ+L/kVRA+iLLIyDE3biQH5pCEV2+Y\nbWuRYMveif75EwII1jB3DEg9Tx1Jy88RKY766TxsboPBhSzpi6C7WrPfRtToC6Bl\nyuTkpD76WREPS9ZdfWeZRvyhY6EC+FTNUK4xfSl5NQKBgQDJEWGUguE0HoA5lMmr\nmcNX2ZrxFxcwsN8/BRYE0Yx5hcozbaorH4AeHFZGo2rmETakexGkVmUyyzqJ09sp\nr6eSGWKucyhUyL4Hc5HGW+Obz0tdQqQUuauDPkAZSbcoI+kU7uf6WBbvxNhwdnTH\ndUc+54X9uiWVsz0gO7oXTE+AVwKBgQDCAAzHk1aFqNdqd0Doaxl7wc2Tz8RaSkHZ\nlDnC4QkQTbCeAq9/MA/khkhv7rDE6qKuOFAf6Mbyq58rTHtHGVo9Zf5q/f5sIx1/\nMGo0Nqf+FLW/Gb6EfRgN4WM7eyQWbjSt9pAXOB/GTx5Rheyqo7Ok+UCJLp7uB6wU\nKzBUFevGbQKBgA0hjXXddkepFkasaN9EE3XRSEUmdOVBJ9M9ycpWxQ3KpwHkz5Ax\nZnSQ9TF3yqtrxF3Ji8VnvwQqMZB+vXljd1YbQk6SRrgCxCZIbeS+a4bpasqUZ5LS\n7ViM4DLGlaeRcM9lKtE2n4jZGil+EvJTvmtlQ2LmnT3BjuRkAiszWJ3RAoGAVgyJ\nnphWv1BlxD6DFtQyaHdNBSwZ7uaTELwzZqJET+v11BBi4WpjEj0RsjxQQffFEru9\npnmsjQTcw+rXn3C6WxN7Zt+kUzi8I6dI5EH9/7AV8V6s571Ixxda2Y5EMoLNcQA1\nZ2coiOCdFRHvKL0VuK4qFu8L5Y6XoBaMCC/09X0CgYEAoOa2YE/dzGJdRZRFo9tz\npGb3R36n9Vtd3NlbJhgeUL2zqZBgInTMzWgi6ajPDoLX3ZspnzWN+R9hebkJwPLi\nfAcfK6g0g2mwEfSFKGiOJkrIqOk4D9dyOrU9XTp5MamO1djmsldDTPhkP7KlyyHB\nk+n/6yb2pDbjhNY+kfe7kyg=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-fbsvc@doctorappointment-f0d02.iam.gserviceaccount.com",
    "client_id": "107984052432579997614",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40doctorappointment-f0d02.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
    //Your serviceAccoucnt Json Data
  };

  List<String> scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/firebase.database",
    "https://www.googleapis.com/auth/firebase.messaging",
  ];

  http.Client client = await auth.clientViaServiceAccount(
    auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
    scopes,
  );

  // Obtain the access token
  auth.AccessCredentials credentials = await auth
      .obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );

  print("access: ==================== ${credentials.accessToken.data} ");

  print("idToken: =================== ${credentials.idToken} ");
  print("refreshToken: ==================== ${credentials.refreshToken} ");

  client.close();
  // Return the access token
  return credentials.accessToken.data;
}

Future<void> sendFCMMessage(
  context,
  String title,
  String messageBody,
  String topics,
  String targetToken,
  String type,
) async {
  final String serverKey = await getAccessToken(); // Your FCM server key
  const String fcmEndpoint =
      'https://fcm.googleapis.com/v1/projects/doctorappointment-f0d02/messages:send';
  //currentFCMToken = (await FirebaseMessaging.instance.getToken())!;
  // print("fcmkey :========================= $currentFCMToken");
  final Map<String, dynamic> message = {
    'message': {
      "topic": topics,
      //'token': currentFCMToken, // Token of the device you want to send the message to
      'notification': {
        'body': messageBody, //'This is an FCM notification message From App',
        'title': title, //'FCM Message',
      },
      'data': {
        'current_user_fcm_token': //currentFCMToken,
            targetToken, // Include the current user's FCM token in data payload
        "type": type, //"chat",
        "doctorId": myBox!.get("doctorId").toString(),
      },
    },
  };
  print(
    "type(current page) :========================= ${message['message']['data']['type']}",
  );

  final http.Response response = await http.post(
    Uri.parse(fcmEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    },
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('FCM message sent successfully ============================= ');
    //  Navigator.push(context, MaterialPageRoute(builder: (_) => Test()));
  } else {
    print('Failed to send FCM message: ${response.statusCode}');
  }
  print("serverKey ===================================== ");
  print("serverKey === $serverKey ");
}

startOnInital(context, String userId) {
  NotificationService notificationService = NotificationService();
  FlutterRingtonePlayer flutterRingtonePlayer = FlutterRingtonePlayer();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // RemoteNotification? notification = message.notification;
    //  AndroidNotification? android = message.notification?.android;

    //  if (message.notification != null) {

    flutterRingtonePlayer.playNotification();
    if (message.data['type'] == "chat") {
      BlocProvider.of<ChatCubit>(context).viewAllMessages(userId);
      // notificationService.showNotification(
      //   id: 0,
      //   title: message.notification!.title!,
      //   body: message.notification!.body!,
      //   payload: message.data["type"],
      // );
    }
    // else if (message.data['type'] == "appointment") {
    //   notificationService.showNotification(
    //     id: 0,
    //     title: message.notification!.title!,
    //     body: message.notification!.body!,
    //     payload: message.data["type"],
    //   );
    // }
    //  }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ChatPage()));
  });
}

myRequestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
