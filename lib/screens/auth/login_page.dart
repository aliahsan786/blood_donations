import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/screens/auth/signup_page.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text.dart';
import 'package:blood_donations/widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: authController.signInKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(flip: true),
                child: Container(
                  height: 250,
                  color: blueColor,
                  // color: Colors.redAccent,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height(context, 0.05)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Obx(() {
                          return Radio(
                            activeColor: Colors.blue,
                            value: 'Consultant',
                            groupValue: authController.loginUserType.value,
                            onChanged: (value) {
                              authController.toogleSelectedUserType(value);
                              log('authController selected user is: ${authController.loginUserType.value} and value is: $value');
                            },
                          );
                        }),
                        MyText(
                          maxlines: 2,
                          overFlow: TextOverflow.ellipsis,
                          // text: 'Donor consultant',
                          text: 'Donor',
                          size: 13,
                          color: kGreyColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Obx(() {
                          return Radio(
                            activeColor: Colors.blue,
                            value: 'Admin',
                            groupValue: authController.loginUserType.value,
                            onChanged: (value) {
                              authController.toogleSelectedUserType(value);
                              log('authController selected user is: ${authController.loginUserType.value} and value is: $value');
                            },
                          );
                        }),
                        MyText(
                          maxlines: 2,
                          overFlow: TextOverflow.ellipsis,
                          // text: 'Receptor admin',
                          text: 'Receptor',
                          size: 13,
                          color: kGreyColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height(context, 0.05)),
              MyTextField(
                controller: authController.emailController,
                validator: (value) =>
                    validationController.emailValidator(value!),
                hintText: "Email",
              ),
              SizedBox(height: 30),
              Obx(() {
                return MyTextField(
                  isObSecure: authController.isObscureText.value,
                  controller: authController.passwordController,
                  validator: (value) =>
                      validationController.passwordValidatopr(value!),
                  hintText: "Password",
                  // widget: GestureDetector(
                  //   onTap: () {
                  //     log("Pressed");
                  //     log("${authController.isObscureText.value}");
                  //     authController.isObscureText.value = false;
                  //     log("${authController.isObscureText.value}");
                  //     authController.isObscureText.value != authController.isObscureText.value;
                  //   },
                  //   child: Icon(Icons.visibility),
                  // ),
                );
              }),
              SizedBox(height: 50),
              MyButton(
                title: "Signin",
                onTap: () {
                  log("button clicked");
                  authController.signIn();
                  // showLoading();
                },
              ),
              SizedBox(height: 22),
              MyText(
                text: "Don't have a account Signup",
                height: 2,
                align: TextAlign.right,
                weight: FontWeight.w700,
                alignment: Alignment.bottomRight,
                paddingRight: 16,
                onTap: () {
                  Get.offAll(SignUpPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
