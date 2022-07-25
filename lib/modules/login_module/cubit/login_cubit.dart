import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/components.dart';
import '../cubit/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  LoginCubit.fromRegister(state) : super(state);

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  IconData visibilityIcon = Icons.visibility_outlined;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final validator = (value) {
    if (value == null || value.isEmpty) {
      return 'field can\'t be empty';
    }
    return null;
  };

  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    if (!passwordVisibility) {
      visibilityIcon = Icons.visibility_off_outlined;
    } else {
      visibilityIcon = Icons.visibility_outlined;
    }

    emit(LoginToggleVisibilityState());
  }

  void userLogin() {
    emit(LoginInitState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text).then((value) {
          print(value.user!.uid);
          emit(LoginSuccessState());
    }).catchError((error){

      showToast(message: error.toString());
      emit(LoginErrorState());
    });
  }
}
