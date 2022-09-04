part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitState extends ChatState {}

class ChatSendMessageSuccessState extends ChatState {}

class ChatSendMessageErrorState extends ChatState {}
