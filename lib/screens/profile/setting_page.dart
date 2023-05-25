import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text_field.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Setting"),
      body: Column(
        children: [
          SizedBox(height: height(context, 0.03)),
          Tiles(
            title: "Change Email",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      title: Text("Change Email"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: height(context, 0.02)),
                          MyTextField(
                            controller: authController.emailController,
                            hintText: "Enter new email",
                          ),
                          MyTextField(
                            controller: authController.passwordController,
                            isObSecure: true,
                            hintText: "Enter Password",
                          ),
                          SizedBox(height: height(context, 0.02)),
                          MyButton(
                              title: "Change Email",
                              onTap: () {
                                Get.back();
                                authController.changeUserEmail();
                              }),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          Tiles(
            title: "Change Password",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      title: Text("Change Password"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: height(context, 0.02)),
                          MyTextField(
                            controller: authController.passwordController,
                            hintText: "Current Password",
                          ),
                          MyTextField(
                            controller: authController.newPasswordController,
                            isObSecure: true,
                            hintText: "Enter New Password",
                          ),
                          SizedBox(height: height(context, 0.02)),
                          MyButton(
                              title: "Change Password",
                              onTap: () {
                                Get.back();
                                authController.changeUserPassword();
                              }),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          Tiles(
              title: "Delete Account",
              onTap: () {
                log("Delete Account");
                Get.defaultDialog(
                  title: "Beware!",
                  middleText: "Are u sure you want to delete your account",
                  textConfirm: "Yes",
                  confirmTextColor: Colors.red,
                  textCancel: "No",
                  cancelTextColor: Colors.blue,
                  buttonColor: Colors.white,
                  onConfirm: () async {},
                );
              }),
        ],
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const Tiles({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withOpacity(0.22),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
