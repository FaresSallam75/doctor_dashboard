import 'dart:io';
import 'package:user_appointment/business_logic/auth/signup_state.dart';
import 'package:user_appointment/constants/handlingdata.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:user_appointment/constants/statusrequest.dart';
import 'package:user_appointment/data/repositary/authrepositary.dart';
import 'package:user_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/presentation/screens/auth/login.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepositary authRepositary;

  String? getDoctorImage;

  SignUpCubit(this.authRepositary) : super(const SignUpStateLoading()) {
    Future.sync(() async {
      await Future.delayed(const Duration(seconds: 3));
      emit(const SignUpStateLoaded(successMessage: ''));
    });
  }

  Future<void> signup(
    BuildContext context,
    String doctorName,
    String email,
    String password,
    String phone,
    String specialization,
    String experience,
    String specialty,
  ) async {
    try {
      // emit(const SignUpStateLoading());

      var response = await authRepositary.registerData({
        "name": doctorName,
        "email": email,
        "password": password,
        "phone": phone,
        "specialization": specialization,
        "experience": experience,
        "specialty": specialty,
      });
      print("📡 Response received: $response");

      StatusRequest statusRequest = handlingData(response);
      print("✅ Status after handling: $statusRequest");

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        emit(const SignUpStateLoaded(successMessage: "Signup successful!"));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        // Navigator.pushReplacementNamed(context, AppRotes.login);
      } else {
        emit(const SignUpStateError(errorMessage: "Signup failed. Try again."));
      }
    } catch (e) {
      emit(
        SignUpStateError(errorMessage: "An error occurred: ${e.toString()}"),
      );
    }
  }

  // getUserToken() {
  //   FirebaseMessaging.instance.getToken().then((value) {
  //     print("========================== Value Of Token $value");
  //     // ignore: unused_local_variable
  //     getCuurentToken = value!;
  //   });
  // }

  void doctorDetails(
    BuildContext context,
    String degree,
    String price,
    String days,
    String fromTime,
    String toTime,
    String location,
    String token,
  ) async {
    try {
      emit(const SignUpStateLoading());
      var response = await authRepositary.doctorDetailsData({
        "doctorId": myBox!.get("doctorId"),
        "degree": degree,
        "price": price,
        "days": days,
        "fromTime": fromTime,
        "toTime": toTime,
        "location": location,
        "token": token,
      });
      StatusRequest statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        emit(const SignUpStateLoaded(successMessage: "Doctor Details Added Successful!"));
        Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
      } else {
        emit(const SignUpStateError(errorMessage: "Data failed. Try again."));
      }
    } catch (e) {
      emit(
        SignUpStateError(errorMessage: "An error occurred: ${e.toString()}"),
      );
    }
  }

  updateCurrentDoctor(File imageFile) async {
    var response = await authRepositary.editCurrentDoctorData({
      "doctorId": myBox!.get("doctorId").toString(),
      "oldImage": getDoctorImage ?? myBox!.get("doctorImage").toString(),
    }, imageFile);

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        if (myBox!.containsKey("doctorImage")) {
          await myBox!.delete("doctorImage");
        }
        await myBox!.put("doctorImage", getDoctorImage);

        emit(
          const SignUpStateLoaded(
            successMessage: "Photo updated successfully!",
          ),
        );
      }
    } else {
      emit(const SignUpStateError(errorMessage: "Photo update failed."));
    }
  }

  getCurrentUser() async {
    //emit(const SignUpStateLoading());
    var response = await authRepositary.currentDoctorData({
      "doctorId": myBox!.get("doctorId").toString(),
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        // emit(const SignUpStateLoading());
        getDoctorImage = response['data']["doctor_image"];
        print("response =================${response['data']}");
        print("userId ======== ${response['data']["doctor_id"].toString()}");
        print("user_image ======== ${response['data']["doctor_image"]}");
        print("user_name ======== ${response['data']["doctor_name"]}");
      } else {
        emit(
          const SignUpStateError(
            errorMessage: "Failed to Get Current Doctor Data",
          ),
        );
      }
    }
  }
}
