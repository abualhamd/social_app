import 'package:flutter/material.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';
import 'package:social_app/shared/colors.dart';
import 'package:social_app/shared/strings.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    final Size size = MediaQuery.of(context).size;

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
          title: Text(cubit.titles[Screens.addPost.index]),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  MyStrings.post,
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.width / 20, horizontal: size.width / 25),
          child: Column(
            children: [
              // SizedBox(height: size.width/25),
              Row(
                children: [
                  CircleAvatar(
                    foregroundImage:
                        NetworkImage(cubit.userModel!.profileImage!),
                  ),
                  SizedBox(width: size.width / 40),
                  Text(
                    cubit.userModel!.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: MyStrings.postHelperText,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.postImage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.getPostImage();
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
                            style: TextStyle(color: MyColors.defaultColor),
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
                            style: TextStyle(color: MyColors.defaultColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
