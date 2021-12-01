import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/textstyles.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';
import 'package:readingbook/pages/profile/your_posts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel userModel;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    userModel = await AuthRepo.getUser();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryBG,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: kToolbarHeight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  userModel != null ? userModel.name : "",
                  style: TextStyles.pageHeading,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userModel != null ? userModel.email : "",
                      style: TextStyles.subText,
                    ),
                    Text(
                      userModel != null ? userModel.area : "",
                      style: TextStyles.subText,
                    ),
                    Text(
                      userModel != null ? userModel.college : "",
                      style: TextStyles.subText,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          size: 15,
                          color: ColorConstant.highlighterPink,
                        ),
                        SizedBox(width: 6),
                        Text(
                          userModel != null ? userModel.phone : "",
                          style: TextStyle(
                            color: ColorConstant.highlighterPink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: userModel != null && userModel.photo != null
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userModel.photo),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundColor: ColorConstant.yellow,
                      ),
              ),
              divider(),
              Text('Account', style: TextStyles.actionTitleBlack),
              item(title: 'Edit Profile', icon: Icons.star_border_rounded, func: () {}),
              item(
                  title: 'Your Posts',
                  icon: Icons.feedback_outlined,
                  func: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => YourPosts(userId: userModel.id, ids: userModel.posts)));
                  }),
              divider(),
              Text('Settings', style: TextStyles.actionTitleBlack),
              item(title: 'Rate and Review', icon: Icons.star_border_rounded, func: () {}),
              item(title: 'Send Feedback', icon: Icons.feedback_outlined, func: () {}),
              item(title: 'Log out', icon: Icons.logout_rounded, func: () => AuthRepo.logout(context)),
              item(title: 'About', icon: Icons.info_outline_rounded, func: () {}),
            ],
          ),
        ),
      ),
    );
  }

  ListTile item({title, IconData icon, func}) {
    return ListTile(
      onTap: func,
      dense: true,
      horizontalTitleGap: -8,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        size: 20,
        color: ColorConstant.white.withOpacity(0.8),
      ),
      title: Text(
        title,
        style: TextStyles.highlighterTwo,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: ColorConstant.white.withOpacity(0.4),
      ),
    );
  }

  Divider divider() {
    return Divider(
      height: 35,
      color: ColorConstant.white.withOpacity(0.4),
    );
  }
}
