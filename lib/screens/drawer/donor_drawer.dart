import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/screens/chat/chat_head.dart';
import 'package:blood_donations/screens/plasma/a_negative.dart';
import 'package:blood_donations/screens/plasma/a_positive.dart';
import 'package:blood_donations/screens/plasma/ab_negative.dart';
import 'package:blood_donations/screens/plasma/ab_positive.dart';
import 'package:blood_donations/screens/plasma/b_negative.dart';
import 'package:blood_donations/screens/plasma/b_positive.dart';
import 'package:blood_donations/screens/plasma/o_negative.dart';
import 'package:blood_donations/screens/plasma/o_positive.dart';
import 'package:blood_donations/screens/profile/profile.dart';
import 'package:blood_donations/screens/profile/setting_page.dart';
import 'package:blood_donations/utils/height_width.dart';

class DonorDrawer extends StatefulWidget {
  const DonorDrawer({Key? key}) : super(key: key);

  @override
  _DonorDrawerState createState() => _DonorDrawerState();
}

class _DonorDrawerState extends State<DonorDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: blueColor),
                margin: EdgeInsets.zero,
                accountName: Obx(() {
                  return Text(authController.userModel.value.name != null
                      ? "${authController.userModel.value.name}"
                      : "");
                }),
                accountEmail: Obx(() {
                  return Text(authController.userModel.value.email != null
                      ? "${authController.userModel.value.email}"
                      : "");
                }),
                currentAccountPicture: Hero(
                  tag: 'profilePicHero',
                  child: Obx(() {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        (authController.userModel.value.imgUrl != null &&
                                authController.userModel.value.imgUrl != "")
                            ? "${authController.userModel.value.imgUrl}"
                            : imagePlaceHolder,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          BuildContext context,
                          Object exception,
                          StackTrace? stackTrace,
                        ) =>
                            const Text(' '),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: CircularProgressIndicator(
                                  color: kTertiaryColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: height(context, 0.01)),
                  DrawerTile(
                    icon: Icons.person,
                    title: "Profile",
                    onTap: () {
                      Get.to(() => ProfileScreen());
                    },
                  ),
                  DrawerTile(
                    icon: Icons.settings,
                    title: "Setting",
                    onTap: () {
                      Get.to(() => SettingPage());
                    },
                  ),
                  DrawerTile(
                    icon: Icons.settings,
                    title: "Chats",
                    onTap: () {
                      Get.to(() => ChatHead());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 5),
                    child: Divider(thickness: 1, color: Colors.red),
                  ),
                  DrawerTileHeading(
                    leadingTitle: "A+",
                    title: "Positive",
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => APositive());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "A-",
                    title: "Negative",
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => ANegative());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "B+",
                    title: "Positive",
                    onTap: () {
                      Get.to(() => BPositive());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "B-",
                    title: "Negative",
                    onTap: () {
                      Get.to(() => BNegative());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "AB+",
                    title: "Positive",
                    onTap: () {
                      Get.to(() => ABPositive());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "AB-",
                    title: "Negative",
                    onTap: () {
                      Get.to(() => ABNegative());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "O+",
                    title: "Positive",
                    onTap: () {
                      Get.to(() => OPositive());
                    },
                  ),
                  DrawerTileHeading(
                    leadingTitle: "O-",
                    title: "Negative",
                    onTap: () {
                      Get.to(() => ONegative());
                    },
                  ),
                  DrawerTile(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () => authController.signOut(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final IconData? icon;

  DrawerTile({
    this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title ?? ""),
      leading: Icon(icon ?? Icons.person),
      onTap: onTap ?? () {},
    );
  }
}

class DrawerTileHeading extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final String? leadingTitle;

  DrawerTileHeading({
    this.title,
    required this.leadingTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title ?? "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          leadingTitle ?? "",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      onTap: onTap ?? () {},
    );
  }
}
