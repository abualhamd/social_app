import 'package:flutter/material.dart';
import 'package:social_app/modules/layout_module/cubit/social_cubit.dart';
import 'package:social_app/modules/layout_module/cubit/social_states.dart';
import 'package:social_app/shared/colors.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SocialCubit cubit = SocialCubit.get(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text('settings'),
        ),
        body: Column(
          children: [
            if(cubit.state is SocialUpdatingState)
              const LinearProgressIndicator(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: size.width / 2.5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: size.width / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/caravan-desert-background-arab-people-camels-silhouettes-sands-caravan-with-camel-camelcade-silhouette-travel-sand-desert-illustration_1284-51614.jpg?w=740&t=st=1659112666~exp=1659113266~hmac=0f462c0598d9172ed2b5d3e032c1d1a2954904fd1f43cc649dc6e3c4801f9043'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: size.width / 9,
                      child: CircleAvatar(
                        radius: size.width / 10,
                        foregroundImage:
                        // (cubit.userModel!.profileImage != null)
                        //     ?
                        NetworkImage(cubit.userModel!.profileImage!),
                        // : NetworkImage(MyConstants.initProfileImage),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.updateProfileImage();
                      },
                      child: CircleAvatar(
                        child: Icon(
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
              padding: EdgeInsets.symmetric(horizontal: size.width / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (img != null)
                  // Image.file(img!, width: 160, height: 160,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width / 50),
                    child: Text(
                      'Random User',
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
                    padding: EdgeInsets.symmetric(vertical: size.width / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: size.width / 50,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: size.width / 50,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: size.width / 50,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: size.width / 50,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
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
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                MyColors.defaultColor,
                              ) //MyColors.defaultColor,
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: size.width / 80),
                            child: Text(
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
                          color: MyColors.defaultColor,
                          size: size.width / 17,
                        ),
                      ),
                      // IconButton(onPressed:(){}, icon: ,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return BlocConsumer<SocialCubit, SocialState>(
    //   listener: (context, state){},
    //   builder: (context, state) {
    //
    //   }
    // );
  }
}
