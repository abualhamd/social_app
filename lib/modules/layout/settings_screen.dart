import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/layout/cubit/social_cubit.dart';
import 'package:social_app/modules/layout/cubit/social_states.dart';
import 'package:social_app/shared/colors.dart';
import 'package:social_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SocialCubit cubit = SocialCubit.get(context);
    //TODO complete adding edit to the rest of the profile

    return ConditionalBuilder(
        condition: cubit.userModel != null,
        builder: (context) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text('settings'),
                ),
                body: Column(
                  children: [
                    if (cubit.state is SocialUpdatingState)
                      const LinearProgressIndicator(),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: size.width / 2.4,
                          child: Align(
                            alignment: Alignment.topCenter,
                            //coverImage
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: size.width / 3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        (cubit.userModel!.coverImage!
                                                .isNotEmpty)
                                            ? cubit.userModel!.coverImage!
                                            : Constants.initCoverImage,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(size.width / 50),
                                  child: InkWell(
                                    onTap: () {
                                      cubit.updateCoverImage();
                                    },
                                    child: CircleAvatar(
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      radius: size.width / 24,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //profileImage
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: size.width / 9,
                              child: CircleAvatar(
                                radius: size.width / 10,
                                foregroundImage: NetworkImage(
                                    (cubit.userModel!.profileImage!.isNotEmpty)
                                        ? cubit.userModel!.profileImage!
                                        : Constants.initProfileImage),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.updateProfileImage();
                              },
                              child: CircleAvatar(
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                                radius: size.width / 27,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width / 50),
                            child: Text(
                              cubit.userModel!.name,
                              // 'Random User',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(
                            'write your bio',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          // SizedBox(
                          //   height: size.width / 20,
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width / 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: size.width / 50,
                                    ),
                                    Text(
                                      'Posts',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: size.width / 50,
                                    ),
                                    Text(
                                      'Photos',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: size.width / 50,
                                    ),
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: size.width / 50,
                                    ),
                                    Text(
                                      'Followers',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                    AppColors.defaultColor,
                                  ) //MyColors.defaultColor,
                                      ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width / 80),
                                    child: const Text(
                                      'Add Photos',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width / 20,
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.defaultColor,
                                  size: size.width / 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        fallback: (context) => const CircularProgressIndicator());
  }
}
