import 'dart:io';

import 'package:user_appointment/business_logic/chat/chat_state.dart';
import 'package:user_appointment/data/models/messagemodel.dart';
import 'package:user_appointment/data/repositary/chat_repositary.dart';
import 'package:user_appointment/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositary chatRepositary;
  List<MessageModel> listMessageModel = [];
  List<MessageModel> listCardMessageModel = [];
  //File? file;
  late String userToken;
  ChatCubit(this.chatRepositary) : super(const ChatStateLoading());

  viewAllMessages(String reciever) async {
    listMessageModel.clear();
    var response = await chatRepositary.viewAllMessagesData({
      "sender": myBox!.get("doctorId").toString(),
      "receiver": reciever,
    });

    if (response['status'] == 'success') {
      listMessageModel =
          response['data']
              .map<MessageModel>((e) => MessageModel.fromJson(e))
              .toList()
              .cast<MessageModel>();

      print("listMessageModel ====================== $listMessageModel");
      emit(
        ChatStateLoaded(
          listMessageModel: listMessageModel,
          listCardMessageModel: [],
        ),
      );
    } else if (response['status'] == 'failure') {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    } else {
      emit(
        const ChatStateNoInternet(
          errorInternetMessage: "No Internet Connection ..",
        ),
      );
    }
  }

  viewCardMessages() async {
    listCardMessageModel.clear();
    var response = await chatRepositary.viewCardMessagesData({
      "doctorId": myBox!.get("doctorId").toString(),
      // "receiver": reciever,
    });

    if (response['status'] == 'success') {
      listCardMessageModel =
          response['data']
              .map<MessageModel>((e) => MessageModel.fromJson(e))
              .toList()
              .cast<MessageModel>();

      print("listMessageModel ====================== $listCardMessageModel");
      emit(
        ChatStateLoaded(
          listMessageModel: [],
          listCardMessageModel: listCardMessageModel,
        ),
      );
    } else if (response['status'] == 'failure') {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    } else {
      emit(
        const ChatStateNoInternet(
          errorInternetMessage: "No Internet Connection ..",
        ),
      );
    }
  }

  Future<String> getUserToken(String userId) async {
    listCardMessageModel.clear();
    var response = await chatRepositary.userTokenData({"userId": userId});
    if (response['status'] == 'success') {
      userToken = response['data']['token'];
    } else {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    }
    return userToken;
  }

  sendMessages(String reciever, String message, File? file) async {
    //  statusRequest = StatusRequest.loading;
    // update();
    Map dataMessage = {
      "sender": myBox!.get("doctorId").toString(),
      "receiver": reciever,
      "message": message,
    };
    var response = await chatRepositary.sendMessageData(
      dataMessage,
      // ignore: prefer_if_null_operators
      file,
    );

    if (response['status'] == "success") {
      //emit(const ChatStateLoading());
      viewAllMessages(reciever);
    } else {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    }
  }

  refreshPage() {
    emit(const ChatStateLoading());
    viewCardMessages();
  }
}
