import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/layout_module/add_post/add_post_screen.dart';
import 'package:social_app/modules/layout_module/cubit/social_states.dart';
import 'package:social_app/modules/layout_module/users_screen.dart';
import 'package:social_app/shared/components.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/strings.dart';
import 'package:flutter/material.dart';
import '../chats_screen.dart';
import '../home_screen.dart';

enum Screens {
  home,
  chats,
  addPost,
  users,
}

class SocialCubit extends Cubit<SocialState> {
  SocialCubit._internal() : super(SocialInitState());

  static final _instance = SocialCubit._internal();
  factory SocialCubit() => _instance;

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void emailVerification() {
    emit(SocialVerificationLoadingState());
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      showToast(message: AppStrings.verificationMailSent);

      emit(SocialVerificationSuccessState());
    }).catchError((error) {
      showToast(message: error.toString());

      emit(SocialVerificationErrorState());
    });
  }

  void getUserData() {
    emit(SocialUserDataLoadingState());
    // print(MyConstants.uId);
    FirebaseFirestore.instance
        .collection(AppStrings.collectionUsers)
        .doc(MyConstants.uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());

      emit(SocialUserDataSuccessState());
    }).catchError((error) {
      emit(SocialUserDataErrorState());
    });
  }

  int bottomNavIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const AddPostScreen(),
    const UsersScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Create Post',
    'Users',
  ];

  void changeBottomNavIndex(int index) {
    if (index == Screens.addPost.index) {
      emit(SocialAddPostState());
    } else {
      bottomNavIndex = index;

      emit(SocialToggleBottomNavIndex());
    }
  }

  void updateProfileImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      emit(SocialUpdatingProfileImageState());

      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(value!.path).pathSegments.last}')
          .putFile(File(value.path))
          .then((p) {
        p.ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance
              .collection(AppStrings.collectionUsers)
              .doc(userModel!.uId)
              .update({
            'profileImage': value,
          }).then((value) {
            getUserData();
          });
        });
        emit(SocialProfileImageUpdateSuccess());
      });
    }).catchError((error) {
      showToast(message: error.toString());

      emit(SocialProfileImageUpdateError());
    });
  }

  void updateCoverImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      emit(SocialUpdatingCoverImageState());

      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(value!.path).pathSegments.last}')
          .putFile(File(value.path))
          .then((p) {
        p.ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance
              .collection(AppStrings.collectionUsers)
              .doc(userModel!.uId)
              .update({
            'coverImage': value,
          }).then((value) {
            getUserData();
          });
        });
        emit(SocialCoverImageUpdateSuccess());
      });
    }).catchError((error) {
      showToast(message: error.toString());

      emit(SocialCoverImageUpdateError());
    });
  }

  List<PostModel> posts = [];

  void getPosts() async {
    emit(SocialGetPostsDownloadingState());

    var response = await FirebaseFirestore.instance
        .collection(AppStrings.collectionPosts)
        .get();
    try {
      for (var post in response.docs) {
        var likes =
            await post.reference.collection(AppStrings.collectionLikes).get();

        posts.add(PostModel.fromJson(post.data(), post.id, likes.docs.length));
      }
      emit(SocialGetPostsSuccessState());
    } catch (error) {
      emit(SocialGetPostsErrorState());
    }
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection(AppStrings.collectionPosts)
        .doc(postId)
        .collection(AppStrings.collectionLikes)
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }
}
