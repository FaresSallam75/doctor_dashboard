// ignore_for_file: deprecated_member_use, must_be_immutable
import 'dart:io';
import 'package:user_appointment/business_logic/chat/chat_cubit.dart';
import 'package:user_appointment/business_logic/chat/chat_state.dart';
import 'package:user_appointment/constants/callservices.dart';
import 'package:user_appointment/constants/fileupload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/constants/notifications.dart';
import 'package:user_appointment/data/models/messagemodel.dart';
import 'package:user_appointment/main.dart';
import 'package:user_appointment/presentation/widgets/chats/buildinputdata.dart';
import 'package:user_appointment/presentation/widgets/chats/cupertino.dart';
import 'package:user_appointment/presentation/widgets/chats/customappbar.dart';
import 'package:user_appointment/presentation/widgets/chats/custommessagebubble.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatPage extends StatefulWidget {
  final MessageModel? listDoctorModel;
  const ChatPage({super.key, this.listDoctorModel});
  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController textController;
  late ScrollController scrollController;
  FocusNode focusNode = FocusNode();
  File? file;

  // NotificationTestPage notificationTestPage = NotificationTestPage();
  CallServices callServices = CallServices();

  @override
  void initState() {
    startOnInital(context, widget.listDoctorModel!.userId!);
    myRequestPermission();
    initialState();
    textController = TextEditingController();
    context.read<ChatCubit>().viewAllMessages(widget.listDoctorModel!.userId!);
    context.read<ChatCubit>().getUserToken(widget.listDoctorModel!.userId!);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void initialState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {}
    });
    scrollController = ScrollController();
    scrollController.addListener(() {});
  }

  makeAnimation() {
    if (scrollController.positions.isEmpty) {
      return;
    }
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  chooseImageGallery() async {
    file = await takePhotoWithGallery();
    print('file from gallery ================ $file');
    setState(() {});
  }

  chooseImageCamera() async {
    file = await takePhotoWithCamera();
    print('file from gallery ================ $file');
    setState(() {});
  }

  removeFile() {
    if (file != null) {
      file = null;
      print('file from remove ================ $file');
    } else {
      print('no file to remove');
    }
    setState(() {});
  }

  chooseImageOption() {
    showAttachmentOptions(
      context,
      chooseImageGallery,
      chooseImageCamera,
      removeFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<ChatCubit>(context); // Access the ChatCubit
    final theme = Theme.of(context); // Get theme data
    return Scaffold(
      backgroundColor: theme.colorScheme.surface, // Softer background
      appBar: customAppBar(
        "${widget.listDoctorModel!.userName}",
        theme,
        () {
          // Navigator.of(
          //   context,
          // ).push(MaterialPageRoute(builder: (context) => const Schedules()));
          Navigator.of(context).pop();
          context.read<ChatCubit>().refreshPage();
          // Navigator.of(context).pushNamed(AppRotes.chatListScreen);
        },

        () {
          callServices.onUserLogin(
            myBox!.get("doctorId").toString(),
            "Dr ${myBox!.get("doctorName")}",
          );
          ZegoUIKitPrebuiltCallInvitationService().send(
            resourceID: "faresZegoApp",
            //callID: "1",
            invitees: [
              ZegoCallUser(
                widget.listDoctorModel!.userId!,
                widget.listDoctorModel!.userName!,
              ),
            ],
            isVideoCall: false,
          );
        },
        () {
          callServices.onUserLogin(
            myBox!.get("doctorId").toString(),
            "Dr ${myBox!.get("doctorName")}",
          );
          ZegoUIKitPrebuiltCallInvitationService().send(
            resourceID: "faresZegoApp",
            //callID: "1",
            invitees: [
              ZegoCallUser(
                widget.listDoctorModel!.userId!,
                widget.listDoctorModel!.userName!,
              ),
            ],
            isVideoCall: true,
          );
        },
      ),
      body: Column(
        children: [
          // --- Message List ---
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatStateLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    reverse: true, // Show latest messages at the bottom
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 8.0,
                    ),
                    itemCount: state.listMessageModel.length,
                    itemBuilder: (context, index) {
                      return ContextMenuExample(
                        onPressed: () {},
                        child: MessageBubble(
                          messageModel: state.listMessageModel[index],
                        ),
                      );
                    },
                  );
                } else if (state is ChatStateError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is ChatStateNoInternet) {
                  return Center(
                    child: Text(
                      state.errorInternetMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text("No Messages Yet .."));
                }
              },
            ),
          ),

          Divider(height: 1.0, color: theme.dividerColor.withOpacity(0.5)),

          buildInputDataAres(
            theme,
            textController,
            () {
              // if (textController.text.trim().isEmpty) {
              //   return; // Don't send empty messages
              // }
              if (file != null) {
                context.read<ChatCubit>().sendMessages(
                  widget.listDoctorModel!.userId!,
                  textController.text.trim(),
                  file!, // Global variable to hold the selected image file
                );
              } else {
                if (textController.text.trim().isEmpty) {
                  return; // Don't send empty messages
                } else {
                  context.read<ChatCubit>().sendMessages(
                    widget.listDoctorModel!.userId!,
                    textController.text.trim(),
                    null, // Global variable to hold the selected image file
                  );
                }
              }
              sendFCMMessage(
                context,
                "Dr. ${myBox!.get("doctorName")}",
                textController.text.trim(),
                "fares",
                context.read<ChatCubit>().userToken,
                "chat",
              );
              file = null;
              textController.clear();
              makeAnimation();
            },
            () {
              chooseImageOption();
            },
            context,
          ),
        ],
      ),
    );
  }
}
