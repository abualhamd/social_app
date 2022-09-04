class MessageModel {
  late final String senderId;
  late final String recieverId;
  late final String text;
  late final String createdAt;

  MessageModel(
      {required this.senderId,
      required this.recieverId,
      required this.text,
      required this.createdAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    text = json['text'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'createdAt': createdAt,
    };
  }
}
