import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/add_post/add_post_screen.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';
import 'package:social_app/modules/layout_module/cubit/social_states.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/strings.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO experiment with removing the BlocConsumer from her
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);

        return BuildLayout(
          condition: (cubit.userModel != null),
          widget: (!FirebaseAuth.instance.currentUser!.emailVerified)
              ? Container(
                  color: Colors.amber.withOpacity(.7),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(MyStrings.verifyText),
                      TextButton(
                          onPressed: () {
                            cubit.emailVerification();
                          },
                          child: const Text('verify')),
                    ],
                  ),
                )
              : cubit.screens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
