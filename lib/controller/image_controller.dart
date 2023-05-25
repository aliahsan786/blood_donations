import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/utils/show_loading.dart';

class ImageController extends GetxController {
  static ImageController instance = Get.find();

  RxString pickedImagePath = "".obs;
  File? pickedImageFile;
  RxString imgUrl = "".obs;

  //
  Future<void> pickImage() async {
    try {
      XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) {
        pickedImageFile = File(img.path);
        pickedImagePath.value = img.path;
        Get.back();
      } else {
        log("Please pick a image ");
      }
    } on PlatformException catch (e) {
      showCustomSnackBar(title: "Error", message: "$e");
    }
  }

  RxDouble uploadProgress = 0.0.obs;

  Future uploadPhoto() async {
    try {
      showLoading();
      Reference ref =
          storageReference.child('ProfileImage/${DateTime.now().toString()}');
      await ref.putFile(pickedImageFile!);
      await ref.getDownloadURL().then((value) {
        log('Profile Image URL $value');
        imgUrl.value = value;
      });
      dismissLoadingWidget();
    } catch (e) {
      dismissLoadingWidget();
      log("Exception $e");
    }
  }

  //+Updaing Profile
  String? primaryImageUrlForEditProfile;
  File? pickedImageFileForEdit;
  RxString pickedImagePathForEdit = "".obs;

  Future<void> pickImageEditProfile() async {
    try {
      XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) {
        pickedImageFileForEdit = File(img.path);
        pickedImagePathForEdit.value = img.path;
        uploadEditProfileImage();
      } else {
        log("Please pick a image ");
      }
    } on PlatformException catch (e) {
      showCustomSnackBar(title: "Error", message: "$e");
    }
  }

  uploadEditProfileImage() async {
    print('after popping the circular progress page.');

    Reference ref = storageReference
        .child('profileImages')
        .child('${authController.userModel.value.email}.png');
    RxDouble uploadPercentageValue = 0.0.obs;
    try {
      final uploadTask = ref.putFile(pickedImageFileForEdit!);
      Get.back();
      Get.defaultDialog(
        title: "Updating image...",
        barrierDismissible: false,
        content: Obx(() {
          return Text(
            "${(uploadPercentageValue.value).toInt()} %",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
      );
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            uploadPercentageValue.value = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $uploadPercentageValue% complete.");
            break;
          case TaskState.paused:
            log("Upload is paused.");
            break;
          case TaskState.canceled:
            log("Upload was canceled");
            break;
          case TaskState.error:
            log("error in uploading image to storage on preview screen is: "
                "${TaskState.error.toString()}");
            break;
          case TaskState.success:
            primaryImageUrlForEditProfile =
                await taskSnapshot.ref.getDownloadURL();
            if (pickedImageFileForEdit != null &&
                (primaryImageUrlForEditProfile != null ||
                    primaryImageUrlForEditProfile != "")) {
              ffstore
                  .collection("Users")
                  .doc((auth.currentUser?.uid ?? ""))
                  .update(
                {
                  "imgUrl": primaryImageUrlForEditProfile,
                },
              );
              authController.userModel.value.imgUrl =
                  primaryImageUrlForEditProfile;
              Get.back();
              showCustomSnackBar(
                  title: "Success", message: "Image was uploaded successfully");
            }
            break;
        }
      });
    } catch (e) {
      log("Error is $e");
    }
  }
}
