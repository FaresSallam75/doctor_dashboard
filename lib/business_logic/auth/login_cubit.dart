import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/login_state.dart';
import 'package:user_appointment/constants/handlingdata.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:user_appointment/constants/showalertdialog.dart';
import 'package:user_appointment/constants/statusrequest.dart';
import 'package:user_appointment/data/repositary/authrepositary.dart';
import 'package:user_appointment/main.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepositary authRepositary;
  String? token;
  String? doctorId;

  LoginCubit(this.authRepositary) : super(const LoginStateLoading()) {
    Future.sync(() async {
      await Future.delayed(const Duration(seconds: 3));
      emit(const LoginStateLoaded(successMessage: ''));
    });
  }

  getUserToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print("========================== Value Of Token $value");
      // ignore: unused_local_variable
      token = value!;
    });
  }

  login(BuildContext context, String email, String password) async {
    // emit(const LoginStateLoading());
    var response = await authRepositary.loginData({
      "email": email,
      "password": password,
    });

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        print("success =================================== ");
        myBox!.put("doctorId", response['data']['doctor_id'].toString());
        myBox!.put("doctorName", response['data']['doctor_name']);
        myBox!.put("doctorEmail", response['data']['doctor_email']);
        myBox!.put(
          "doctorPassword",
          response['data']['doctor_password'].toString(),
        );
        myBox!.put("doctorPhone", response['data']['doctor_phone']).toString();
        myBox!.put("doctorImage", response['data']['doctor_image'].toString());
        myBox!.put(
          "specialization",
          response['data']['specialization'].toString(),
        );
        myBox!.put("experience", response['data']['experience'].toString());
        myBox!.put("category_id", response['data']['category_id'].toString());
        print("================================== ");

        print("${myBox!.get("doctorId")}");
        print("${myBox!.get("doctorName")}");
        print("${myBox!.get("doctorEmail")}");
        print("${myBox!.get("doctorPassword")}");
        print("${myBox!.get("doctorPhone")}");
        print("${myBox!.get("doctorImage")}");
        print("${myBox!.get("specialization")}");
        print("${myBox!.get("experience")}");
        print("${myBox!.get("category_id")}");
        print("================================== ");

        emit(const LoginStateLoaded(successMessage: "Login successful!"));
        // await getUserToken();
        FirebaseMessaging.instance.subscribeToTopic('fares');

        await Navigator.of(context).pushReplacementNamed(
          AppRotes.details,
          // arguments: {
          //   "token": token.toString(),
          //   "doctorId": doctorId.toString(),
          // },
        );
      } else {
        showAlertDialog(
          context,
          "Alert",
          "Email Or Password Not Correct ....",
          () {
            Navigator.of(context).pop();
          },
          () {
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  checkEmail(BuildContext context, String email) async {
    var response = await authRepositary.checkEmailData({"email": email});
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(const LoginStateLoaded(successMessage: "Success"));

        Navigator.pushReplacementNamed(
          context,
          AppRotes.forgetPassword,
          arguments: {"email": email},
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email Not Found  ❌")));
      }
    }
  }

  resetPassword(BuildContext context, String email, String password) async {
    var response = await authRepositary.resetPasswordData({
      "email": email,
      "password": password,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        print("Password Changed Successfully .");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Password does't Match ❌")));
      }
    }
  }

  Future<String?> viewDoctorDeatils() async {
    var response = await authRepositary.viewDoctorDetailsData({
      "doctorId": myBox!.get("doctorId").toString(),
    });
    if (response['status'] == 'success') {
      doctorId = response['data']['doctor_id'].toString();
      print("doctorId ======================== $doctorId");
      emit(LoginStateLoaded(successMessage: "Details Data Get successfully ."));
    } else {
      print("No Details Data For this Account .");
      // emit(LoginStateError(errorMessage: "No Details Data For this Account ."));
    }
    return doctorId;
  }

  // Future<String?> getDoctorId() async {
  //   doctorId = myBox!.get("doctorId").toString();
  //   print("doctorId ======================== $doctorId");
  //   return doctorId;
  // }
}
