import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../modules/layout_module/cubit/social_cubit.dart';
import '../modules/layout_module/settings_screen.dart';
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
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),),);
            }, icon: Icon(Icons.menu_outlined)),
          ],
        ),
        body: ConditionalBuilder(
          condition: condition,
          builder: (context) => widget,
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottomNavIndex(index);
          },
          currentIndex: cubit.bottomNavIndex,
          items:  const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'chats'),
            BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined), label: 'app post'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'users'),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//home_screen components

Widget postBuilder(BuildContext context) {
  final Size size = MediaQuery.of(context).size;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width / 50),
    child: Card(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyConstants.postRadius),
      ),
      elevation: 30,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width/15,
                  foregroundImage: AssetImage('lib/assets/cool.jpg'),
                ),
                SizedBox(
                  width: size.width / 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Abu-Alhamd'),
                    SizedBox(height: size.width/150,),
                    Text(
                      'January, 21, 2022 at 11:00 pm',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined)),
              ],
            ),
            SizedBox(
              height: size.width / 50,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.width / 20),
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Text(
                        '#software',
                        style: TextStyle(color: MyColors.defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Text(
                        '#software',
                        style: TextStyle(color: MyColors.defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Text(
                        '#software',
                        style: TextStyle(color: MyColors.defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Text(
                        '#software',
                        style: TextStyle(color: MyColors.defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Text(
                        '#software',
                        style: TextStyle(color: MyColors.defaultColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Image.network(
                  'https://img.freepik.com/premium-psd/3d-penguin-using-lifebuoy_541652-330.jpg?w=740'),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.heart_broken_outlined)),
                Text('20'),
                Spacer(),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.mode_comment_outlined)),
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
                onTap: (){},
                child: Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(
                          'https://img.freepik.com/free-psd/3d-rendering-swimming-googles-travel-icon_23-2149389105.jpg?w=740&t=st=1659010583~exp=1659011183~hmac=f6d1dd3daf8294dca0ac0f2196d20b817ad6185f872cfd43973f935dfcdb205d'),
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
