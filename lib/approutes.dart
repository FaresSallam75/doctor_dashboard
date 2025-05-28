// ignore_for_file: body_might_complete_normally_nullable

import 'package:user_appointment/main.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:flutter/material.dart';
import 'package:user_appointment/presentation/screens/auth/checkemail.dart';
import 'package:user_appointment/presentation/screens/auth/details.dart';
import 'package:user_appointment/presentation/screens/auth/forgetpassword.dart' show ForgetPassword;
import 'package:user_appointment/presentation/screens/auth/login.dart';
import 'package:user_appointment/presentation/screens/auth/register.dart';
import 'package:user_appointment/presentation/screens/chats/cardmessages.dart';
import 'package:user_appointment/presentation/screens/chats/chatpage.dart';
import 'package:user_appointment/presentation/screens/schedules.dart';
import 'package:user_appointment/presentation/widgets/home/customnavigationbarItems.dart';
import 'package:user_appointment/welcome.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRotes.welcomeScreen: (context) => myBox!.isEmpty ? const WelcomeScreen() : const Home(),
  AppRotes.login: (context) => const Login(),
  AppRotes.signup: (context) => const Register(),
  AppRotes.checkEmail: (context) => const CheckEmail(),
  AppRotes.forgetPassword: (context) => const ForgetPassword(),
  AppRotes.details: (context) => Details(),
  AppRotes.homePage: (context) => const Home(),
  AppRotes.chatPage: (context) => const ChatPage(),
  AppRotes.cardChatListScreen: (context) => const CardChatListScreen(),
  AppRotes.schedules: (context) => const Schedules(),

};
