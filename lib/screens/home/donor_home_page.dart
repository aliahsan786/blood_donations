import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/screens/drawer/donor_drawer.dart';
import 'package:blood_donations/screens/plasma/all_plasma_button.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';

class DonorHomePage extends StatelessWidget {
  const DonorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DonorDrawer(),
      backgroundColor: whiteColor,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: height(context, 0.02)),
          BoxPart(context, "Blood", "assets/032-blood bag.svg", true, () {
            Get.to(() => AllPlasmaButton());
          }),
          // BoxPart(context, "Request For Plasma", "assets/request.png", false, () {
          //   if (user == null) {
          //     showMsg(context, "Please login first for plasma request");
          //   } else {
          //     Get.to(() => AddBloodRequest());
          //   }
          // }),
          // BoxPart(context, "My Request", "assets/request.png", false, () {
          //   log("${auth.currentUser}");
          //   if (user == null) {
          //     showMsg(context, "Please login first to check your request");
          //   } else {
          //     Get.to(() => MyRequest());
          //   }
          // }),
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
