import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/layout/cubit/social_cubit.dart';
import 'package:social_app/shared/strings.dart';
import '../../shared/components.dart';

// TODO add cached_internet_image

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SocialCubit cubit = SocialCubit.get(context);
    return ConditionalBuilder(
      // TODO add something to display the fallback till data has been fitched
      condition:
          true, //cubit.streamPosts !=null, //cubit.posts.isNotEmpty, cubit.posts.isNotEmpty
      builder: (context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    // TODO upload image and text to firebase
                    'enjoy your summer',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.width / 30,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: cubit.postsStream(),
                builder: (context, snapshot) {
                  cubit.getPostsFromStream(snapshot: snapshot);
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          PostBuilder(postModel: cubit.posts[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: size.width / 40,
                          ),
                      itemCount: cubit.posts.length);
                }),
          ],
        ),
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}
