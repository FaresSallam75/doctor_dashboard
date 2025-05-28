import 'dart:io';

import 'package:user_appointment/data/web_services/crud.dart';
import 'package:user_appointment/link_api.dart';

class AuthRepositary {
  final Crud crud;

  AuthRepositary(this.crud);

  registerData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.register, data);
    return response.fold((l) => l, (r) => r);
  }

  loginData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.login, data);
    return response.fold((l) => l, (r) => r);
  }

  doctorDetailsData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.doctorDetails, data);
    return response.fold((l) => l, (r) => r);
  }

  viewDoctorDetailsData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.viewDoctorDetails,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  currentDoctorData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.currentDoctor, data);
    return response.fold((l) => l, (r) => r);
  }

  editCurrentDoctorData(Map data, [File? file]) async {
    var response = await crud.postRequestWithFile(
      AppLink.editCurrentDoctor,
      data,
      file!,
    );
    return response.fold((l) => l, (r) => r);
  }

  checkEmailData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.checkEmail, data);
    return response.fold((l) => l, (r) => r);
  }

  resetPasswordData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.resetPassword, data);
    return response.fold((l) => l, (r) => r);
  }
}
