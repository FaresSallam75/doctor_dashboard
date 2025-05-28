import 'dart:io';

import 'package:user_appointment/data/web_services/crud.dart';
import 'package:user_appointment/link_api.dart';

class ChatRepositary {
  final Crud crud;
  const ChatRepositary(this.crud);

  viewAllMessagesData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewAllMessages, data);
    return response.fold((l) => l, (r) => r);
  }

  // streamAllMessagesData(Map data) async {
  //   var response = await crud.streamData(AppLink.viewAllMessages, data);
  //   return response.fold((l) => l, (r) => r);
  // }

  viewCardMessagesData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewCardMessages, data);
    return response.fold((l) => l, (r) => r);
  }

  userTokenData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.usertoken, data);
    return response.fold((l) => l, (r) => r);
  }

  sendMessageData(Map data, [File? file]) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    if (file == null) {
      response = await crud.getDataFromServer(AppLink.sendMessages, data);
    } else {
      response = await crud.postRequestWithFile(
        AppLink.sendMessages,
        data,
        file,
      );
    }
    return response.fold((l) => l, (r) => r);
  }
}
