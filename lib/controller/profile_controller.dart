import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/utils/show_loading.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();

  Rx<TextEditingController> dateTimeController = TextEditingController().obs;

  RxString selectedGender = "Male".obs;
  RxString selectedBloodGroup = "A+".obs;

  updateUserProfile() async {
    showLoading();
    await ffstore.collection(userCollection).doc(auth.currentUser!.uid).update({
      'name': nameController.text,
      'number': numberController.text,
      'address': addressController.text,
      'city': cityController.text,
      'dateOfBirth': dateTimeController.value.text,
      'gender': selectedGender.value,
      'bloodGroup': selectedBloodGroup.value,
    });

    dismissLoadingWidget();

    showCustomSnackBar(
      title: "Success",
      message: "Profile Update Successfully",
      seconds: 3,
    );
  }
}
