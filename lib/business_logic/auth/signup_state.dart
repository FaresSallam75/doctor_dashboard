import 'package:user_appointment/constants/statusrequest.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  final StatusRequest statusRequest;
  const SignUpState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

// Loading State
class SignUpStateLoading extends SignUpState {
  const SignUpStateLoading() : super(statusRequest: StatusRequest.loading);
}

// Success State
class SignUpStateLoaded extends SignUpState {
  final String successMessage;

  const SignUpStateLoaded({required this.successMessage})
    : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [successMessage, statusRequest];
}

// Error State
class SignUpStateError extends SignUpState {
  final String errorMessage;
  const SignUpStateError({required this.errorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [errorMessage, statusRequest];
}

// internet state error
class InternetStateError extends SignUpState {
  final String internetErrorMessage;
  const InternetStateError({required this.internetErrorMessage})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [internetErrorMessage, statusRequest];
}
