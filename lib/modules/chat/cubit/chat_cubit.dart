import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/user_model.dart';

import '../../../models/message_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/strings.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.recieverUserModel}) : super(ChatInitState());

  final UserModel recieverUserModel;

  static ChatCubit get(context) => BlocProvider.of(context);

  TextEditingController textController = TextEditingController();

  void _sendMessage(
      {required String createdAt, required String chatParticipant}) {
    FirebaseFirestore.instance
        .collection(AppStrings.collectionUsers)
        .doc(chatParticipant)
        .collection(AppStrings.collectionChats)
        .doc((recieverUserModel.uId != chatParticipant)
            ? recieverUserModel.uId
            : Constants.uId)
        .collection(AppStrings.collectionMessages)
        .add(MessageModel(
          senderId: Constants.uId!,
          recieverId: recieverUserModel.uId,
          text: textController.text,
          createdAt: createdAt,
        ).toMap());
  }

  void sendMessageToAllParticipants() {
    try {
      final createdAt = DateTime.now().toString();

      _sendMessage(createdAt: createdAt, chatParticipant: Constants.uId!);
      _sendMessage(
          createdAt: createdAt, chatParticipant: recieverUserModel.uId);

      emit(ChatSendMessageSuccessState());
    } catch (error) {
      emit(ChatSendMessageErrorState());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream() {
    return FirebaseFirestore.instance
        .collection(AppStrings.collectionUsers)
        .doc(Constants.uId)
        .collection(AppStrings.collectionChats)
        .doc(recieverUserModel.uId)
        .collection(AppStrings.collectionMessages)
        .orderBy('createdAt')
        .snapshots();
  }
}
