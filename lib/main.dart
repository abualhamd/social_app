import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/helpers/cache_helper.dart';
import 'package:social_app/modules/layout_module/cubit/social_states.dart';
import 'package:social_app/modules/layout_module/social_layout.dart';
import 'package:social_app/modules/login_module/login_screen.dart';
import 'package:social_app/shared/strings.dart';
import 'package:social_app/shared/themes_and_decorations.dart';
import 'bloc_observer.dart';
import 'modules/layout_module/cubit/social_cubit.dart';
import 'shared/constants.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await CacheHelper.init();

      MyConstants.uId = CacheHelper.getData(key: MyStrings.uId);

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
    create: (context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state){},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeLight,
            home: (MyConstants.uId != null)
                 ? SocialLayout()
                 : LoginScreen(),
          );
        }
      ),
    );
  }
}
