import 'package:social_app/shared/strings.dart';

class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;
  String? coverImage;
  String? profileImage;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    this.profileImage,
    this.coverImage,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json[MyStrings.isEmailVerified];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      MyStrings.isEmailVerified: isEmailVerified,
      'coverImage': coverImage,
      'profileImage': profileImage,
    };
  }
}
