class PostModel {
  //TODO perhaps remove late
  late String name;
  late final String date;
  late final String uId;
  late final String postId;
  int likes = 0;
  String? text;
  String? postImage;
  // tags

  PostModel(
      {required this.name,
      required this.date,
      required this.uId,
      this.text,
      this.postImage});

  PostModel.fromJson(Map<String, dynamic> json, this.postId, this.likes) {
    name = json['name'];
    date = json['date'];
    uId = json['uId'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'uId': uId,
      'text': text,
      'postImage': postImage,
    };
  }
}
