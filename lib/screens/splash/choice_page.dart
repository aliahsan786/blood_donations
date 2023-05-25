import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/screens/auth/login_page.dart';

import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text.dart';
import 'package:velocity_x/velocity_x.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: "Blood Donation System",
              fontFamily: "Roboto",
              color: Colors.blue,
              weight: FontWeight.bold,
              size: 25,
            ),
            20.heightBox,
            SizedBox(height: height(context, 0.03)),
            MyButton(
              title: ("User Login"),
              onTap: () {
                Get.to(() => const LoginPage());
              },
            ),
            // SizedBox(height: height(context, 0.03)),
            // MyButton(
            //   title: ("Guest Mode"),
            //   onTap: () {
            //     Get.to(() => const HomePage());
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
