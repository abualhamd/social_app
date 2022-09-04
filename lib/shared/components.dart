import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/models/post_model.dart';
import '../modules/layout/cubit/social_cubit.dart';
import '../modules/layout/settings_screen.dart';
import 'colors.dart';
import 'constants.dart';

void showToast({required String message, Color color = Colors.red}) async {
  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class BuildLayout extends StatelessWidget {
  final bool condition;
  final Widget widget;

  const BuildLayout({super.key, required this.condition, required this.widget});

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(cubit.titles[cubit.bottomNavIndex]),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.menu_outlined)),
          ],
        ),
        body: ConditionalBuilder(
          condition: condition,
          builder: (context) => widget,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            cubit.changeBottomNavIndex(index);
          },
          currentIndex: cubit.bottomNavIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'chats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add_outlined), label: 'add post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'users'),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//home_screen components

class PostBuilder extends StatelessWidget {
  final PostModel postModel;

  const PostBuilder({required this.postModel, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 50),
      child: Card(
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.postRadius),
        ),
        elevation: 30,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 0, top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: size.width / 15,
                    foregroundImage: NetworkImage(SocialCubit.get(context)
                            .userModel!
                            .profileImage ??
                        Constants
                            .initProfileImage), //AssetImage('lib/assets/cool.jpg'),
                  ),
                  SizedBox(
                    width: size.width / 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(postModel.name),
                      SizedBox(
                        height: size.width / 150,
                      ),
                      Text(
                        postModel.date,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_outlined)),
                ],
              ),
              SizedBox(
                height: size.width / 20,
              ),
              Text(
                postModel.text!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 15,
              ),
              // Wrap(
              //   children: [
              //     InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              //         child: Text(
              //           '#software',
              //           style: TextStyle(color: MyColors.defaultColor),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              //         child: Text(
              //           '#software',
              //           style: TextStyle(color: MyColors.defaultColor),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              //         child: Text(
              //           '#software',
              //           style: TextStyle(color: MyColors.defaultColor),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              //         child: Text(
              //           '#software',
              //           style: TextStyle(color: MyColors.defaultColor),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              //         child: Text(
              //           '#software',
              //           style: TextStyle(color: MyColors.defaultColor),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              if (postModel.postImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(postModel.postImage!),
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.heart_broken_outlined)),
                  Text(postModel.likes.toString()),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mode_comment_outlined)),
                  Text('8 comments'),
                ],
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.width / 40,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                            SocialCubit.get(context).userModel?.profileImage ??
                                ''),
                      ),
                      SizedBox(
                        width: size.width / 40,
                      ),
                      Text(
                        'write a comment',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
// message_chat_screen
class BubbleMessageBuilder extends StatelessWidget {
  const BubbleMessageBuilder({required this.text, required this.isMe, Key? key})
      : super(key: key);

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double messageEdgeRadius = width / 20;
    final curvedRadius = Radius.circular(messageEdgeRadius);
    const nonCurvedRadius = Radius.circular(0);

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 30, vertical: width / 45),
          child: Material(
            elevation: 2,
            color: isMe ? AppColors.defaultColor : AppColors.othersMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? curvedRadius : nonCurvedRadius,
              topRight: isMe ? nonCurvedRadius : curvedRadius,
              bottomLeft: curvedRadius,
              bottomRight: curvedRadius,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: width / 45),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: width / 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
