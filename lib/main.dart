import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:user_appointment/approutes.dart';
import 'package:user_appointment/business_logic/appointments/appointment_cubit.dart';
import 'package:user_appointment/business_logic/auth/login_cubit.dart';
import 'package:user_appointment/business_logic/auth/signup_cubit.dart';
import 'package:user_appointment/business_logic/chat/chat_cubit.dart';
import 'package:user_appointment/data/repositary/appointmentrepositary.dart';
import 'package:user_appointment/data/repositary/authrepositary.dart';
import 'package:user_appointment/data/repositary/chat_repositary.dart';
import 'package:user_appointment/data/web_services/crud.dart';
import 'package:user_appointment/firebase_options.dart';
import 'package:user_appointment/presentation/screens/notifications/localnotify.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Box? myBox;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<Box> initBoxHive(boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    print("Box is not open");
    Hive.init((await getApplicationDocumentsDirectory()).path);
  } else {
    print("Box is already open");
  }
  return Hive.openBox(boxName);
}

intialZego() {
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
      ZegoUIKitSignalingPlugin(),
    ]);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print("==================================== onBackgroundMessage");
    print("${message.notification!.title} ");
    print("${message.notification!.body} ");
    print("aditional data ===========================");
    print(message.data);
    print("==================================== onBackgroundMessage");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  myBox = await initBoxHive("fares");
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  intialZego();
  PaymobPayment.instance.initialize(
    apiKey:
        "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aUxDSndjbTltYVd4bFgzQnJJam8yT1RBMk56VjkuX3lZTklHVGkwVXBLTmVzdjh0Q0dxc0ZlTmVkNnJobGFid2RoUXlJNFFuMlBUZ2k1Q3VyaGFxbmt2SGlrbXo1enBzaUdxYmhiU0pDU3VCTzA4bGxpcFE=",
    integrationID: 3364826,
    iFrameID: 728907,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(AuthRepositary(Crud())),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(AuthRepositary(Crud())),
        ),
        BlocProvider<AppointmentCubit>(
          create: (context) => AppointmentCubit(AppointmentRepository(Crud())),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(ChatRepositary(Crud())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: routes,
    );
  }
}
