import 'package:user_appointment/constants/statusrequest.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final StatusRequest statusRequest;
  const LoginState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

// Loading State
class LoginStateLoading extends LoginState {
  const LoginStateLoading() : super(statusRequest: StatusRequest.loading);
}

// Success State
class LoginStateLoaded extends LoginState {
  final String successMessage;
  const LoginStateLoaded({required this.successMessage})
    : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [successMessage, statusRequest];
}

// Error State
class LoginStateError extends LoginState {
  final String errorMessage;
  const LoginStateError({required this.errorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [errorMessage, statusRequest];
}

// internet state error
class InternetStateError extends LoginState {
  final String internetErrorMessage;
  const InternetStateError({required this.internetErrorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [internetErrorMessage, statusRequest];
}
