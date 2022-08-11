import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';

import '../../shared/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SocialCubit cubit = SocialCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.posts != null,
      builder: (context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: size.height / 3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/cool.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'enjoy your summer',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.width/30,),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => postBuilder(context: context, postModel: cubit.posts![index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: size.width / 40,
                ),
                itemCount: cubit.posts!.length),
          ],
        ),
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}
