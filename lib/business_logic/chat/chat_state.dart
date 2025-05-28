import 'package:equatable/equatable.dart';
import 'package:user_appointment/data/models/messagemodel.dart';

class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object> get props => [];
}

class ChatStateLoading extends ChatState {
  const ChatStateLoading();
  @override
  List<Object> get props => [];
}

class ChatStateLoaded extends ChatState {
  final List<MessageModel> listMessageModel;
  final List<MessageModel> listCardMessageModel;
  const ChatStateLoaded({
    required this.listMessageModel,
    required this.listCardMessageModel,
  });
  @override
  List<Object> get props => [listMessageModel, listCardMessageModel];
}

class ChatStateError extends ChatState {
  final String errorMessage;
  const ChatStateError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ChatStateNoInternet extends ChatState {
  final String errorInternetMessage;
  const ChatStateNoInternet({required this.errorInternetMessage});
  @override
  List<Object> get props => [errorInternetMessage];
}
