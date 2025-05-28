import 'package:user_appointment/business_logic/chat/chat_cubit.dart';
import 'package:user_appointment/business_logic/chat/chat_state.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/data/models/messagemodel.dart';
import 'package:user_appointment/link_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:user_appointment/presentation/screens/chats/chatpage.dart';

// ignore: must_be_immutable
class CardChatListScreen extends StatefulWidget {
  const CardChatListScreen({super.key});

  @override
  State<CardChatListScreen> createState() => _CardChatListScreenState();
}

class _CardChatListScreenState extends State<CardChatListScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().viewCardMessages();
    refresh();
    //context.read<ChatCubit>().refreshPage();
    super.initState();
  }

  void refresh() {
    //   context.read<ChatCubit>().refreshPage();
    setState(() {});
  }

  goToChatPage(MessageModel? listDoctorModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(listDoctorModel: listDoctorModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF6F4F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 3.0,

        title: Text(
          "Chats", //'Salonek',
          //style: TextStyle(color: Colors.brown, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatStateLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: state.listCardMessageModel.length,
              itemBuilder:
                  (context, index) => InkWell(
                    onTap: () {
                      goToChatPage(
                          state.listCardMessageModel[index]
                        // MessageModel.fromJson(
                        //   state.listCardMessageModel[index].toJson(),
                        // ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${AppLink.viewUserImage}/${state.listCardMessageModel[index].userImage!}",
                            ),
                            radius: 25,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.listCardMessageModel[index].userName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  state.listCardMessageModel[index].text!,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          if (state.listCardMessageModel[index].date != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Jiffy.parse(
                                    state.listCardMessageModel[index].date!,
                                  ).jm,
                                  style: smallStyle.copyWith(
                                    // ignore: deprecated_member_use
                                    color: MyColors.grey02,
                                    fontSize: 13.0,
                                  ),
                                ),
                                // if (chat.containsKey('unread'))
                                //   Container(
                                //     margin: EdgeInsets.only(top: 5),
                                //     padding: EdgeInsets.symmetric(
                                //       horizontal: 6,
                                //       vertical: 2,
                                //     ),
                                //     decoration: BoxDecoration(
                                //       color: Colors.redAccent,
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     child: Text(
                                //       '${chat['unread']}',
                                //       style: TextStyle(color: Colors.white, fontSize: 12),
                                //     ),
                                //   ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
            );
          } else if (state is ChatStateError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text("No Internet Connection .."));
          }
        },
      ),
    );
  }
}
