import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'post_states.dart';

class PostCubit extends Cubit<PostState>{
  PostCubit(): super(PostInitState());

  static PostCubit get(context) => BlocProvider.of(context);

  File? postImage;

  void getPostImage(){
    emit(PostImageGetState());

    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      // Uri.file(value!.path).pathSegments.last;
      postImage = File(value!.path);

      emit(PostImageSuccessState());
    }).catchError((error){

      emit(PostImageErrorState());
    });
  }

  void cancelImage(){
    postImage = null;
    emit(PostImageCancelState());
  }

}