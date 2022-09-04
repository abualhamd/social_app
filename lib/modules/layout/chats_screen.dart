import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/layout/cubit/social_cubit.dart';
import 'package:social_app/modules/layout/cubit/social_states.dart';
import 'package:social_app/modules/chat/message_chat_screen.dart';

import '../../models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);

    return ConditionalBuilder(
        condition: cubit.allUsers.isNotEmpty,
        fallback: ((context) =>
            const Center(child: CircularProgressIndicator())),
        builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  ChatHead(userModel: cubit.allUsers[index]),
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey,
              ),
              itemCount: cubit.allUsers.length,
            ));
  }
}

class ChatHead extends StatelessWidget {
  final UserModel userModel;
  const ChatHead({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MessageChatScreen(recieverUserModel: userModel),
          ),
        );
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 20)
                .copyWith(bottom: width / 40),
        child: Row(
          children: [
            CircleAvatar(
              radius: width / 10,
              // TODO
              foregroundImage: NetworkImage(userModel.profileImage ?? ''),
            ),
            SizedBox(
              width: width / 25,
            ),
            Text(
              userModel.name,
              style: TextStyle(fontSize: width / 22),
            ),
          ],
        ),
      ),
    );
  }
}
