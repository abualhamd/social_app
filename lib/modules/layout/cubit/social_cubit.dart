import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/layout/add_post/add_post_screen.dart';
import 'package:social_app/modules/layout/cubit/social_states.dart';
import 'package:social_app/modules/layout/users_screen.dart';
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
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

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
    firestoreInstance
        .collection(AppStrings.collectionUsers)
        .doc(Constants.uId)
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
          firestoreInstance
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
          firestoreInstance
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

  Stream<QuerySnapshot<Map<String, dynamic>>> postsStream() {
    return FirebaseFirestore.instance
        .collection(AppStrings.collectionPosts)
        .orderBy('date')
        .snapshots();
  }

  Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>? streamPosts;

  void getPostsFromStream(
      {required AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot}) {
    try {
      streamPosts = snapshot.data?.docs.reversed;
      posts = [];
      for (var post
          in streamPosts ?? <QueryDocumentSnapshot<Map<String, dynamic>>>[]) {
        List<String> likes = [];
        post.reference
            .collection(AppStrings.collectionLikes)
            .get()
            .then((value) {
          for (var like in value.docs) {
            likes.add(like.id);
          }
          // emit(state)
        });

        posts.add(PostModel.fromJson(post.data(), post.id, likes));
      }
      emit(SocialGetPostsStreamSuccessState());
    } catch (error) {
      emit(SocialGetPostsStreamErrorState());
    }
  }

  void likePost({required PostModel postModel}) {
    var likeRef = firestoreInstance
        .collection(AppStrings.collectionPosts)
        .doc(postModel.postId)
        .collection(AppStrings.collectionLikes)
        .doc(userModel!.uId);

    if (!postModel.likes.contains(Constants.uId)) {
      likeRef.set({'like': true}).then((value) {
        emit(SocialLikePostSuccessState());
      }).catchError((error) {
        emit(SocialLikePostErrorState());
      });
    } else {
      likeRef.delete().then((value) {
        emit(SocialRemoveLikeSuccessState());
      }).catchError((error) {
        emit(SocialRemoveLikeErrorState());
      });
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLikesStream(
      {required PostModel postModel}) {
    return firestoreInstance
        .collection(AppStrings.collectionPosts)
        .doc(postModel.postId)
        .collection(AppStrings.collectionLikes)
        .snapshots();
  }

  List<UserModel> allUsers = [];
  void getAllUsers() async {
    allUsers = [];
    emit(SocialGetUsersDownloadingState());

    try {
      final response =
          await firestoreInstance.collection(AppStrings.collectionUsers).get();

      for (var user in response.docs) {
        var data = user.data();
        if (data['uId'] != userModel!.uId) {
          allUsers.add(UserModel.fromJson(data));
        }
      }
      emit(SocialGetUsersSuccessState());
    } catch (e) {
      emit(SocialGetUsersErrorState());
    }
  }
}
