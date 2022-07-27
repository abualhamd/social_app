import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../modules/layout_module/cubit/social_cubit.dart';

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
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined)),
            IconButton(onPressed: (){}, icon: Icon(Icons.menu_outlined)),
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
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'users'),
            // BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'settings'),
          ],
        ),
      ),
    );
  }
}
