import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/helpers/cache_helper.dart';
import 'package:social_app/modules/layout/social_layout.dart';
import 'package:social_app/modules/login_module/login_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/strings.dart';
import 'package:social_app/shared/themes_and_decorations.dart';
import 'bloc_observer.dart';
import 'modules/layout/cubit/social_cubit.dart';
import 'modules/layout/cubit/social_states.dart';
import 'shared/constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
  showToast(message: 'onBackgroundMessage');
}

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await CacheHelper.init();

      Constants.uId = CacheHelper.getData(key: AppStrings.uId);

      var token = await FirebaseMessaging.instance.getToken();
      print('token: $token');

      FirebaseMessaging.onMessage.listen((event) {
        // print('message');
        // print(event.toString());
        // print(event.data.toString());
        showToast(message: 'onMessage');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        showToast(message: 'onMessageOpenedApp');
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeLight,
            home: (Constants.uId != null) ? SocialLayout() : LoginScreen(),
          );
        },
      ),
    );
  }
}
