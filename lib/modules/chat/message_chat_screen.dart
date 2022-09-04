import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/modules/chat/cubit/chat_cubit.dart';
import 'package:social_app/shared/colors.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/strings.dart';
import '../../models/user_model.dart';
import '../../shared/components.dart';

class MessageChatScreen extends StatelessWidget {
  const MessageChatScreen({required this.recieverUserModel, super.key});

  final UserModel recieverUserModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ChatCubit(recieverUserModel: recieverUserModel),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatSendMessageSuccessState) {
            BlocProvider.of<ChatCubit>(context).textController.clear();
          }
        },
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: CircleAvatar(
                  radius: width / 14,
                  foregroundImage:
                      NetworkImage(recieverUserModel.profileImage!),
                ),
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 20,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: cubit.getMessageStream(),
                          builder: (context, snapshot) {
                            final messages =
                                snapshot.data?.docs.reversed.toList();
                            return ListView.builder(
                              reverse: true,
                              itemBuilder: (context, index) {
                                final message = messages![index].data();
                                return BubbleMessageBuilder(
                                    isMe: message['senderId'] == Constants.uId,
                                    text: message['text']);
                              },
                              itemCount: messages?.length ?? 0,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: width / 50),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 40),
                        child: TextField(
                          controller: cubit.textController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              child: const Icon(
                                Icons.send_outlined,
                              ),
                              onTap: () {
                                cubit.sendMessageToAllParticipants();
                              },
                            ),
                            suffixIconColor: AppColors.defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
