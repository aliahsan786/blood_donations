import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/screens/auth/login_page.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/custom_date_form_field.dart';
import 'package:blood_donations/widgets/custom_drop_down_field.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text.dart';
import 'package:blood_donations/widgets/my_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authController.dateTimeController.value.text =
        DateFormat.yMMMd().format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: authController.signUpKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(flip: true),
                child: Container(
                  height: 200,
                  color: Colors.red[500],
                  // color: Colors.redAccent,
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height(context, 0.02)),
              pickProfileImage(context),
              SizedBox(height: height(context, 0.02)),
              MyTextField(
                controller: authController.nameController,
                validator: (value) =>
                    validationController.nameValidator(value!),
                hintText: "Name",
              ),
              MyTextField(
                controller: authController.emailController,
                validator: (value) =>
                    validationController.emailValidator(value!),
                hintText: "Email",
              ),
              MyTextField(
                controller: authController.passwordController,
                validator: (value) =>
                    validationController.passwordValidatopr(value!),
                hintText: "Password",
              ),
              MyTextField(
                controller: authController.numberController,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    validationController.PhoneNumberValidator(value!),
                hintText: "Number",
              ),
              MyTextField(
                keyboardType: TextInputType.url,
                controller: authController.cityController,
                validator: (value) =>
                    validationController.cityValidator(value!),
                hintText: "City",
              ),
              MyTextField(
                controller: authController.addressController,
                validator: (value) =>
                    validationController.addressValidator(value!),
                hintText: "Address",
              ),
              20.heightBox,
              MyDateFormField(
                controller: authController.dateTimeController.value,
                hintText: "Select Date Of Birth",
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    authController.dateTimeController.value.text =
                        DateFormat.yMMMd().format(pickedDate);
                    log("Select Date Of Birth ${authController.dateTimeController.value.text}");
                  } else {
                    //something here
                    return "Please Select Date Of Birth ";
                  }
                },
              ),
              const SizedBox(height: 12),
              MyDropDownFormField(
                list: genderList,
                initialValue: authController.selectedGender.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Gender",
                hintText: "a",
                onChange: (value) {},
              ),
              MyDropDownFormField(
                list: bloodGroupList,
                initialValue: authController.selectedBloodGroup.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Blood",
                hintText: "a",
                onChange: (value) {
                  authController.selectedBloodGroup.value = value;
                },
              ),
              const SizedBox(height: 30),
              MyButton(
                title: "Signup",
                onTap: () {
                  log("Sign Up Page");
                  authController.signUp();
                },
              ),
              const SizedBox(height: 22),
              MyText(
                text: "Already have a account SignIn",
                height: 2,
                align: TextAlign.right,
                weight: FontWeight.w700,
                alignment: Alignment.bottomRight,
                paddingRight: 25,
                onTap: () {
                  Get.offAll(const LoginPage());
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickProfileImage(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => imageController.pickImage(),
        child: Stack(
          children: [
            Container(
              height: 140,
              width: 140,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: redColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.16),
                    blurRadius: 6,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Obx(() {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: imageController.pickedImagePath.value == ""
                        ? Image.asset(
                            'assets/profile_avatar.png',
                            height: height(context, 1.0),
                            width: width(context, 1.0),
                            fit: BoxFit.cover,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              imageController.pickedImageFile!,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                  );
                }),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset('assets/add.png', height: 37.22),
            ),
          ],
        ),
      ),
    );
  }
}
