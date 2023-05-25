import 'package:flutter/material.dart';
import 'package:blood_donations/constant/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? firstIcon;
  final Widget? suffixIcon;

  CustomAppBar({this.title, this.firstIcon, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: redColor,
      backgroundColor: blueColor,
      // leading: GestureDetector(
      //   onTap: () {
      //     Get.back();
      //   },
      //   child: firstIcon ?? null,
      // ),
      title: Text(title ?? ""),
      centerTitle: true,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 13),
          child: suffixIcon ?? Container(),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
