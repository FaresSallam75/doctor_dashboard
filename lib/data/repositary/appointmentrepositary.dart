import 'package:user_appointment/data/web_services/crud.dart';
import 'package:user_appointment/link_api.dart';

class AppointmentRepository {
  final Crud crud;

  AppointmentRepository(this.crud);

  getAppointmentData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.getAppointment, data);
    return response.fold((l) => l, (r) => r);
  }

  Stream<dynamic> getAppointmentData2(Map data) async* {
    await for (final response in crud.getDataFromServerAsStream(
      AppLink.getAppointment,
      data,
    )) {
      yield response.fold((l) => l, (r) => r);
    }
  }

  getNextAppointmentData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.getNextAppointment,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  cancelAppointmentData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.cancelAppointment,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  userTokenData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.usertoken, data);
    return response.fold((l) => l, (r) => r);
  }

  viewUserPaymentData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewUserPayment, data);
    return response.fold((l) => l, (r) => r);
  }

  completeAppointmentData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.completeAppointment,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  approveAppointmentData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.approveAppointment,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }
}
