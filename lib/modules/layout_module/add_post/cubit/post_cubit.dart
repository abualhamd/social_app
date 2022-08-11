import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/strings.dart';
import '../../../../models/post_model.dart';
import '../../../../shared/constants.dart';
import 'post_states.dart';

class PostCubit extends SocialCubit {
  PostCubit() : super(PostInitState());

  static PostCubit get(context) => BlocProvider.of(context);

  File? postImage;

  void getPostImage() {
    emit(PostImageGetState());

    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      // Uri.file(value!.path).pathSegments.last;
      postImage = File(value!.path);

      emit(PostImageSuccessState());
    }).catchError((error) {
      emit(PostImageErrorState());
    });
  }

  void cancelImage() {
    postImage = null;
    emit(PostImageCancelState());
  }

  TextEditingController textController = TextEditingController();
  String? _imageUrl;

  void uploadPostToFireStore(String name) {
    FirebaseFirestore.instance
        .collection(MyStrings
            .collectionPosts) //.doc(MyConstants.uId).collection()//${MyConstants.uId}/TODO modify the path
        .add(
          PostModel(
                  name: name,
                  date: DateTime.now().toString(),
                  uId: MyConstants.uId!,
                  text: textController.text,
                  postImage: _imageUrl)
              .toMap(),
        )
        .then((value) {
      _imageUrl = null;

      emit(PostCreateSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(PostCreateErrorState());
    });
  }

  void createPost({required String name}) {
    //if (postImage != null)
    if (textController.text.isEmpty) {
      showToast(message: 'post can\'t be empty ');
    } else {
      emit(PostCreateLoadingState());

      uploadPostToFireStore(name);
    }
  }

  void createPostWithImage({required String name}) {
    emit(PostCreateLoadingState());

    emit(PostImageUploadingState());
    FirebaseStorage.instance
        .ref()
        .child('postsImages/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p) {
      p.ref.getDownloadURL().then((value) {
        _imageUrl = value;

        emit(PostImageUploadingSuccessState());
      }).then((value) {
        uploadPostToFireStore(name);
      });
    }).catchError((error) {
      emit(PostImageUploadingErrorState());
    });
  }
}
