import 'package:user_appointment/constants/statusrequest.dart';
import 'package:equatable/equatable.dart';
import 'package:user_appointment/data/models/appointmentmodel.dart';

class AppointmentState extends Equatable {
  final StatusRequest statusRequest;
  const AppointmentState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

// Loading State
class AppointmentStateLoading extends AppointmentState {
  const AppointmentStateLoading() : super(statusRequest: StatusRequest.loading);
}

// Success State
class AppointmentStateLoaded extends AppointmentState {
  final List<AppointmentModel> listAppointmentsModel;

  const AppointmentStateLoaded({required this.listAppointmentsModel ,

  })
    : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [listAppointmentsModel, statusRequest];
}

// Error State
class AppointmentStateError extends AppointmentState {
  final String errorMessage;
  const AppointmentStateError({required this.errorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [errorMessage, statusRequest];
}

// internet state error
class InternetStateError extends AppointmentState {
  final String internetErrorMessage;
  const InternetStateError({required this.internetErrorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [internetErrorMessage, statusRequest];
}
