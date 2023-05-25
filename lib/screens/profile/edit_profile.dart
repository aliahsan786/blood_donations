import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/custom_date_form_field.dart';
import 'package:blood_donations/widgets/custom_drop_down_field.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    initializingController();
    super.initState();
  }

  initializingController() {
    profileController.nameController.text =
        authController.userModel.value.name!;

    profileController.emailController.text =
        authController.userModel.value.email!;
    profileController.numberController.text =
        authController.userModel.value.number!;
    profileController.cityController.text =
        authController.userModel.value.city!;
    profileController.addressController.text =
        authController.userModel.value.address!;
    profileController.dateTimeController.value.text =
        authController.userModel.value.dateOfBirth!;
  }

  @override
  Widget build(BuildContext context) {
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
                      "Edit Profile",
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
                controller: profileController.nameController,
                validator: (value) =>
                    validationController.nameValidator(value!),
                hintText: "Name",
              ),
              MyTextField(
                controller: profileController.numberController,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    validationController.passwordValidatopr(value!),
                hintText: "Number",
              ),
              MyTextField(
                controller: profileController.cityController,
                validator: (value) =>
                    validationController.nameValidator(value!),
                hintText: "City",
              ),
              MyTextField(
                controller: profileController.addressController,
                validator: (value) =>
                    validationController.nameValidator(value!),
                hintText: "Address",
              ),
              MyDateFormField(
                controller: profileController.dateTimeController.value,
                hintText: "Select Date Of Birth",
                // initialDateTime: DateTime.parse(profileController.dateTimeController.value.text),
              ),
              SizedBox(height: 12),
              MyDropDownFormField(
                list: genderList,
                initialValue: profileController.selectedGender.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Gender",
                hintText: "a",
                onChange: (value) {
                  authController.selectedGender.value = value;
                },
              ),
              MyDropDownFormField(
                list: bloodGroupList,
                initialValue: profileController.selectedBloodGroup.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Blood",
                hintText: "a",
                onChange: (value) {
                  authController.selectedBloodGroup.value = value;
                },
              ),
              const SizedBox(height: 30),
              MyButton(
                title: "Update",
                onTap: () {
                  profileController.updateUserProfile();
                },
              ),
              SizedBox(height: 22),
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
        onTap: () => imageController.pickImageEditProfile(),

        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) {
        //     return Container(
        //       height: 180,
        //       decoration: const BoxDecoration(color: whiteColor),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           ListTile(
        //             onTap: () {},
        //             // => controller.pickImage(
        //             //   context,
        //             //   ImageSource.camera,
        //             // ),
        //             leading: Image.asset(
        //               "assets/camera.png",
        //               color: Colors.grey,
        //               height: 35,
        //             ),
        //             title: MyText(
        //               text: 'Camera',
        //               size: 20,
        //               color: greyColor,
        //             ),
        //           ),
        //           ListTile(
        //             onTap: () {},
        //             // => controller.pickImage(
        //             //   context,
        //             //   ImageSource.gallery,
        //             // ),
        //             leading: Image.asset(
        //               "assets/gallery.png",
        //               height: 35,
        //               color: greyColor,
        //             ),
        //             title: MyText(
        //               text: 'Gallery',
        //               size: 20,
        //               color: greyColor,
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        //   isScrollControlled: true,
        // );
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
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
                    borderRadius: BorderRadius.circular(200),
                    child: imageController.pickedImagePathForEdit.value == ""
                        ? authController.userModel.value.imgUrl != "" &&
                                imageController.pickedImagePathForEdit.value ==
                                    ""
                            ? Image.network(
                                authController.userModel.value.imgUrl!,
                                height: height(context, 1.0),
                                width: width(context, 1.0),
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace,
                                ) =>
                                    const Text(' '),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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
                              )
                            : Image.asset(
                                'assets/profile_avatar.png',
                                height: height(context, 1.0),
                                width: width(context, 1.0),
                                fit: BoxFit.cover,
                              )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              imageController.pickedImageFileForEdit!,
                              fit: BoxFit.fill,
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
