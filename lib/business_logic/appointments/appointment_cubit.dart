import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/appointments/appointment_state.dart';
import 'package:user_appointment/constants/handlingdata.dart';
import 'package:user_appointment/constants/statusrequest.dart';
import 'package:user_appointment/data/models/appointmentmodel.dart';
import 'package:user_appointment/data/repositary/appointmentrepositary.dart';
import 'package:user_appointment/main.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository appointmentRepository;
  late String userToken;
  List<AppointmentModel> listAppointments = [];
  List listUserPayment = [];

  AppointmentCubit(this.appointmentRepository)
    : super(const AppointmentStateLoading());

  Future<List<AppointmentModel>> getAppointments() async {
    var response = await appointmentRepository.getAppointmentData({
      "doctorId": myBox!.get("doctorId").toString(),
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List data = response['data'];
        listAppointments =
            data.map((e) => AppointmentModel.fromJson(e)).toList();
        emit(AppointmentStateLoaded(listAppointmentsModel: listAppointments));
      } else {
        emit(
          const AppointmentStateError(
            errorMessage: "No Appointments Today ...",
          ),
        );
      }
    } else {
      emit(
        const AppointmentStateError(errorMessage: "Status request error! ..."),
      );
    }
    return listAppointments;
  }

  List<AppointmentModel> getAppointments2() {
    appointmentRepository
        .getAppointmentData2({"doctorId": myBox!.get("doctorId").toString()})
        .listen((response) {
          StatusRequest statusRequest = handlingData(response);
          if (statusRequest == StatusRequest.success) {
            if (response['status'] == "success") {
              List data = response['data'];
              listAppointments =
                  data.map((e) => AppointmentModel.fromJson(e)).toList();
              print(
                "listAppointments ================================= $listAppointments",
              );
              emit(
                AppointmentStateLoaded(listAppointmentsModel: listAppointments),
              );
            } else {
              emit(
                const AppointmentStateError(
                  errorMessage: "No Appointments Today ...",
                ),
              );
            }
          } else {
            emit(
              const AppointmentStateError(
                errorMessage: "Status request error! ...",
              ),
            );
          }
        });
    // refresh();
    return listAppointments;
  }

  refresh() {
    // emit(AppointmentStateLoading());
    Timer.periodic(const Duration(minutes: 5), (_) => getAppointments2());
    // await Timer.periodic(const Duration(minutes: 1), (_) => emit(AppointmentStateLoading()));
  }

  Future<String> getUserToken(String userId) async {
    var response = await appointmentRepository.userTokenData({
      "userId": userId,
    });
    if (response['status'] == 'success') {
      userToken = response['data']['token'];
    }
    return userToken;
  }

  // Stream<List<AppointmentModel>> getAppointmentsStream() {
  //   final controller = StreamController<List<AppointmentModel>>();
  //   Future<void> fetchAndEmit() async {
  //     try {
  //       var response = await appointmentRepository.getAppointmentData({
  //         "doctorId": myBox!.get("doctorId").toString(),
  //       });
  //       StatusRequest statusRequest = handlingData(response);
  //       if (statusRequest == StatusRequest.success) {
  //         if (response['status'] == "success") {
  //           List data = (response['data']);
  //           listAppointments =
  //               data
  //                   .map(
  //                     (e) =>
  //                         AppointmentModel.fromJson(e as Map<String, dynamic>),
  //                   )
  //                   .toList();

  //           print("============================================= ");
  //           print("$listAppointments");
  //           print("============================================= ");

  //           if (!controller.isClosed) controller.add(listAppointments);
  //         } else {
  //           emit(
  //             const AppointmentStateError(
  //               errorMessage: "something went wrong ...",
  //             ),
  //           );
  //           print("something went wrong ... =============================== ");
  //           listAppointments = [];
  //           if (!controller.isClosed) controller.add([]);
  //         }
  //       } else {
  //         final error = StateError(
  //           "Status request error! (handlingData status: $statusRequest)",
  //         );
  //         emit(
  //           const AppointmentStateError(
  //             errorMessage: "something went wrong ...",
  //           ),
  //         );
  //         if (!controller.isClosed) controller.addError(error);
  //       }
  //     } catch (e, stackTrace) {
  //       print("Error fetching appointments: $e");
  //       if (!controller.isClosed) controller.addError(e, stackTrace);
  //     } finally {
  //       if (!controller.isClosed) {
  //         controller.close();
  //       }
  //     }
  //   }

  //   fetchAndEmit();
  //   return controller.stream;
  // }

  cancelAppointment(String userId) async {
    var response = await appointmentRepository.cancelAppointmentData({
      "doctorId": myBox!.get("doctorId").toString(),
      "userId": userId,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(AppointmentStateLoading());
        getAppointments();
      } else {
        emit(
          const AppointmentStateError(
            errorMessage: "No Appointments Today ...",
          ),
        );
      }
    } else {
      emit(
        const AppointmentStateError(errorMessage: "Status request error! ..."),
      );
    }
  }

  completeAppointment(String userId) async {
    var response = await appointmentRepository.completeAppointmentData({
      "doctorId": myBox!.get("doctorId").toString(),
      "userId": userId,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(AppointmentStateLoading());
        getAppointments();
      } else {
        emit(
          const AppointmentStateError(
            errorMessage: "No Appointments Today ...",
          ),
        );
      }
    } else {
      emit(
        const AppointmentStateError(errorMessage: "Status request error! ..."),
      );
    }
  }

  approveAppointment(String userId) async {
    var response = await appointmentRepository.approveAppointmentData({
      "doctorId": myBox!.get("doctorId").toString(),
      "userId": userId,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(AppointmentStateLoading());
        getAppointments();
      } else {
        emit(
          const AppointmentStateError(
            errorMessage: "No Appointments Today ...",
          ),
        );
      }
    } else {
      emit(
        const AppointmentStateError(errorMessage: "Status request error! ..."),
      );
    }
  }

  viewUserPayments() async {
    var response = await appointmentRepository.viewUserPaymentData({
      "doctorId": myBox!.get("doctorId").toString(),
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List data = response['data'];
        listUserPayment = [data];
        print(
          "listUserPayment ================================ $listUserPayment",
        );
      } else {
        emit(
          const AppointmentStateError(
            errorMessage: "No Appointments Today ...",
          ),
        );
      }
    } else {
      emit(
        const AppointmentStateError(errorMessage: "Status request error! ..."),
      );
    }
  }
}
