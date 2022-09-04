import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';
import '../../../shared/colors.dart';
import '../../../shared/strings.dart';
import '../../login_module/cubit/login_cubit.dart';
import 'register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends LoginCubit {
  RegisterCubit() : super.fromRegister(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void userRegister() {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      userCreate(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          uId: value.user!.uid);
      //TODO fix_error of showToast
      showToast(
          message: AppStrings.signInSuccessMessage, color: AppColors.greenAlert);
      //TODO CacheHelper.setData(key: MyStrings.uId, value: value.user!.uid);

      emit(RegisterSuccessState());
    }).catchError((error) {
      showToast(message: error.toString());
      emit(RegisterErrorState());
    });
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    emit(RegisterCreateUserLoadingState());
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection(AppStrings.collectionUsers)
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      showToast(message: error.toString());
      emit(RegisterCreateUserErrorState());
    });
  }
}
