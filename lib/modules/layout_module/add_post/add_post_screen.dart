import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/layout_module/add_post/cubit/post_states.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';
import 'package:social_app/shared/colors.dart';
import 'package:social_app/shared/strings.dart';
import 'cubit/post_cubit.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit socialCubit = SocialCubit.get(context);
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => PostCubit(),
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, postState) {},
        builder: (context, postState) {
          PostCubit postCubit = PostCubit.get(context);

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(socialCubit.titles[Screens.addPost.index]),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      MyStrings.post,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.width / 20, horizontal: size.width / 25),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(height: size.width/25),
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                  socialCubit.userModel!.profileImage!),
                            ),
                            SizedBox(width: size.width / 40),
                            Text(
                              socialCubit.userModel!.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: MyStrings.postHelperText,
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                        //TODO fix the image problem
                        if (postCubit.postImage != null)
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                height: size.width/2.1,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(postCubit.postImage!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){postCubit.cancelImage();}, icon: Icon(Icons.cancel_outlined, color: Colors.white,)),
                            ],
                          ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(vertical: size.width/20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          postCubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 60),
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                color: MyColors.defaultColor,
                              ),
                            ),
                            const Text(
                              'add photo',
                              style:
                              TextStyle(color: MyColors.defaultColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.tag_outlined,
                              color: MyColors.defaultColor,
                            ),
                            Text(
                              'tags',
                              style:
                              TextStyle(color: MyColors.defaultColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
