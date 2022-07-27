import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/helpers/cache_helper.dart';
import 'package:social_app/modules/layout_module/cubit/social_states.dart';
import 'package:social_app/modules/layout_module/settings.dart';
import 'package:social_app/modules/layout_module/users.dart';
import '../../../models/user_model.dart';
import '../../../shared/strings.dart';
import 'package:flutter/material.dart';

import '../chats.dart';
import '../home.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() :super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void emailVerification() {
    emit(SocialVerificationLoadingState());
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      //TODO showToast(message: message)
      print("verfication email is sent");

      emit(SocialVerificationSuccessState());
    }).catchError((error) {
      emit(SocialVerificationErrorState());
    });
  }

  void getUserData() {
    emit(SocialUserDataLoadingState());

    FirebaseFirestore.instance.collection(MyStrings.collectionName).doc(
        CacheHelper.getData(key: MyStrings.uId).toString()).get().then((value) {

          userModel = UserModel.fromJson(value.data());

          emit(SocialUserDataSuccessState());
    }).catchError((error){


      emit(SocialUserDataErrorState());
    });
  }

  int bottomNavIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavIndex(int index){
    bottomNavIndex = index;
    emit(SocialToggleBottomNavIndex());
  }
}

