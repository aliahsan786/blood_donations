import 'dart:developer';

import 'package:blood_donations/availableDoner/AvailableDoner.dart';
import 'package:blood_donations/screens/plasma/all_plasma_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/screens/drawer/receptor_drawer_page.dart';
import 'package:blood_donations/screens/request/add_blood_request.dart';
import 'package:blood_donations/screens/request/my_request.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/utils/show_custom_flushbar.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ReceptorDrawer(),
      backgroundColor: whiteColor,
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height(context, 0.02)),
          // BoxPart(context, "Plasma", "assets/032-blood bag.svg", true, () {
          //   Get.to(() => AllPlasmaButton());
          // }),
          BoxPart(context, "Request For Blood ", "assets/request.png", false,
              () {
            if (user == null) {
              showMsg(context, "Please login first for Blood request");
            } else {
              Get.to(() => AddBloodRequest());
            }
          }),
          BoxPart(context, "My Request", "assets/request.png", false, () {
            log("${auth.currentUser}");
            if (user == null) {
              showMsg(context, "Please login first to check your request");
            } else {
              Get.to(() => MyRequest());
            }
          }),
          BoxPart(context, "Available Doner", "assets/032-blood bag.svg", true,
              () {
            Get.to(() => AvailableDoner());
          }),
        ],
      ),
    );
  }

  Widget BoxPart(BuildContext context, String title, String path, bool isSvg,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                isSvg == true
                    ? SvgPicture.asset(path, height: 80, width: 80)
                    : Image.asset(path),
                const SizedBox(width: 12),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
