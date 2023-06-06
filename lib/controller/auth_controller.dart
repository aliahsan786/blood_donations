// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/model/user_model.dart';
import 'package:blood_donations/screens/home/donor_home_page.dart';
import 'package:blood_donations/screens/auth/login_page.dart';
import 'package:blood_donations/screens/home/receptor_home_page.dart';
import 'package:blood_donations/screens/splash/choice_page.dart';
import 'package:blood_donations/utils/share_preference_helper.dart';
import 'package:blood_donations/utils/show_loading.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<UserModel> userModel = UserModel().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController cityController =
      TextEditingController(text: 'Burewala');
  TextEditingController addressController = TextEditingController();

  Rx<TextEditingController> dateTimeController = TextEditingController().obs;
  Rx<TextEditingController> dateOfNeedController = TextEditingController().obs;

  //
  TextEditingController patientNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();

  TextEditingController addressCotroller = TextEditingController();

  TextEditingController reasonController = TextEditingController();

  TextEditingController emailSignInController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController profilePasswordController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpMoreInfoKey = GlobalKey<FormState>();
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  GlobalKey<FormState> changeNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPasswordKey = GlobalKey<FormState>();

  RxBool isObscureText = true.obs;

  double latitude = 0.0;
  double longitude = 0.0;

  RxString maleFemaleSelection = "".obs;
  String primaryImageUrl = '';

  RxBool isCodeSent = false.obs;
  RxBool isChangeCodeSent = false.obs;
  bool isPhoneNumberApproved = true;

  bool isSignUp = false;
  bool isPhoneLinked = false;
  bool isSignIn = false;

  bool isGoogleSigningUpForInitializingInDatabase = false;
  bool isGoogleSignUp = false;
  bool isGoogleSignIn = false;
  String? guid;
  String jointId = "";

  RxString loginUserType = "Consultant".obs;
  toogleSelectedUserType(value) {
    loginUserType.value = value;
  }

  bool? isBlocked;
  bool isAdminSignin = false;
  bool isVendorSignin = false;
  bool isAdmin = false;
  bool isVendor = false;
  bool isUser = false;
  RxString gettingLoginType = "".obs;

  RxString selectedGender = "Male".obs;
  RxString selectedBloodGroup = "A+".obs;
  RxString selectedRequestType = "Simple Request".obs;

  Rx<User?>? firebaseUser;
  @override
  Future<void> onReady() async {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    log('auth  current user is : \n ${auth.currentUser} \n ');
    await _setInitialScreen(auth.currentUser);
  }

  _setInitialScreen(User? user) async {
    log("INSIDE SET INITIAL SCREEN");
    // auth.signOut();

    gettingLoginType.value =
        (await SharedPreferenceHelper().getLoginType()) ?? "";
    log("log in type from SharedPreferenceHelper ${gettingLoginType.value}");
    isAdmin = await SharedPreferenceHelper().getIsAdmin() ?? false;
    isVendor = await SharedPreferenceHelper().getIsVendor() ?? false;
    isUser = await SharedPreferenceHelper().getIsUser() ?? false;

    log("Getting data from Shared Preference isADMIN $isAdmin ");
    log("Getting data from Shared Preference VENDOR  $isVendor $user");
    if (user == null) {
      bool isSignUp = await sharedPrefHelper.getIsSignUp() ?? false;
      bool isSignIn = await sharedPrefHelper.getIsSignIn() ?? false;
      bool isPhoneLinked = await sharedPrefHelper.getIsPhoneLinked() ?? false;

      print('...............................................................');

      Get.offAll(() => const ChoicePage());
    } else {
      print('/${user.uid}/');
      await ffstore.collection("Users").doc(user.uid).get().then((value) async {
        //
        //
        //     if (value['approve'] == false) {
        await _initializeUserModel(auth.currentUser!.uid);

        log("loginUserType.value in else on relaunch is: ${loginUserType.value}");
        if (gettingLoginType.value == "Consultant" && !isVendor && !isAdmin) {
          log("inside Consultant ");
          log(auth.currentUser!.uid);

          Get.offAll(() => const DonorHomePage());
        } else if (gettingLoginType.value == "Admin" || isAdmin) {
          log("inside Admin ");
          log(auth.currentUser!.uid);

          Get.offAll(() => const HomePage());
        } else {
          //something else
        }
        //   } else {
        ///     Get.offAll(const LoadingPage());
        //   }
      });
    }
  }

  Future<void> signUp() async {
    log("inside signUp");
    if (signUpKey.currentState?.validate() ?? false) {
      log("Inside signUp Function");
      try {
        showLoading();
        await imageController.uploadPhoto();
        await Future.delayed(const Duration(seconds: 1));

        // auth.verifyPhoneNumber(
        //     phoneNumber: '+923036657152',
        //     verificationCompleted: (value) {
        //       print(value);
        //     },
        //     verificationFailed: (value) {
        //       print(value);
        //     },
        //     codeSent: (message, code) {
        //       print(code);
        //     },
        //     codeAutoRetrievalTimeout: (value) {
        //       print(value);
        //     });
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        print('Ali');
        String userId = userCredential.user!.uid;
        userModel = UserModel(
          currentUserId: userId,
          name: nameController.text,
          email: emailController.text,
          number: numberController.text,
          address: addressController.text,
          bloodGroup: selectedBloodGroup.value,
          dateOfBirth: dateTimeController.value.text,
          city: cityController.text,
          imgUrl: imageController.imgUrl.value,
          gender: selectedGender.value,
          createdat: DateTime.now().millisecondsSinceEpoch.toString(),
          province: "",
          password: passwordController.text,
        ).obs;
        await ffstore
            .collection(userCollection)
            .doc(userId)
            .set(userModel.toJson());
        _initializeControllers();
        await _initializeUserModel(userId);
        _initializeControllers();

        await SharedPreferenceHelper().saveUserData(userModel);
        await sharedPrefHelper.saveIsSignUp(true);
        Get.back();
        Get.snackbar(
          "Success",
          "Account created successfully",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(() => LoginPage());
        clearTextFieldController();

        log("inside signup after calling phonesignup"
            "and going to page verify your number");
      } on FirebaseAuthException catch (e) {
        Get.back();
        showErrorSnackBar(e);
      }
    } else {}
  }

  Future<void> signIn() async {
    if (signInKey.currentState!.validate()) {
      signInKey.currentState?.save();
      log("validated Successfully");

      await SharedPreferenceHelper().saveLoginType(loginUserType.value);

      if (loginUserType.value == "Consultant") {
        try {
          showLoading();
          await ffstore
              .collection(userCollection)
              .where("email", isEqualTo: emailController.text.trim())
              .get()
              .then((qSnap) async {
            if (qSnap.docs.isNotEmpty) {
              try {
                isSignIn = true;
                UserCredential userCredential =
                    await auth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());

                await SharedPreferenceHelper().saveLoginType("Consultant");
                await SharedPreferenceHelper().saveIsAdmin(false);
                await SharedPreferenceHelper().saveIsVendor(false);
                await SharedPreferenceHelper().saveIsUser(false);
                await sharedPrefHelper.saveIsSignIn(true);
                await SharedPreferenceHelper().saveUserData(userModel);

                isAdmin = true;
                isAdminSignin = false;
                isUser = false;
                isVendor = false;

                String userId = userCredential.user!.uid;
                await _initializeUserModel(userId);
                await _initializeControllers();
                Get.back();
                Get.offAll(() => const DonorHomePage());

                clearTextFieldController();
              } on FirebaseAuthException catch (e) {
                dismissLoadingWidget();
                log(e.toString());
                showErrorSnackBar(e);
              }
            } else {
              dismissLoadingWidget();
              Get.defaultDialog(
                  title: "Sign In Failed",
                  middleText: "No record found."
                      "Please make sure that you have selected the correct user type and email.");
            }
          });
        } catch (e) {
          dismissLoadingWidget();
          log(e.toString());
        }
      } else if (loginUserType.value == "Admin") {
        try {
          showLoading();
          await ffstore
              .collection(userCollection)
              .where("email", isEqualTo: emailController.text.trim())
              .get()
              .then((qSnap) async {
            if (qSnap.docs.isNotEmpty) {
              try {
                UserCredential userCredential =
                    await auth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());

                await SharedPreferenceHelper().saveLoginType("Admin");
                await SharedPreferenceHelper().saveIsAdmin(true);
                await SharedPreferenceHelper().saveIsVendor(false);
                await SharedPreferenceHelper().saveIsUser(false);
                isSignIn = true;
                isAdmin = true;
                isAdminSignin = true;
                isUser = false;
                isVendor = false;

                await sharedPrefHelper.saveIsSignIn(true);
                String userId = userCredential.user!.uid;
                await _initializeUserModel(userId);
                await _initializeControllers();
                await SharedPreferenceHelper().saveUserData(userModel);
                Get.back();
                Get.offAll(() => const HomePage());

                clearTextFieldController();
              } on FirebaseAuthException catch (e) {
                dismissLoadingWidget();
                log(e.toString());
                showErrorSnackBar(e);
              }
            } else {
              dismissLoadingWidget();
              Get.defaultDialog(
                  title: "Sign In Failed",
                  middleText: "No record found."
                      "Please make sure that you have selected the correct user type and email.");
            }
          });
        } catch (e) {
          dismissLoadingWidget();
          log(e.toString());
        }
      } else {
        log("No type ");
      }
    } else {
      log("Not Validated");
    }
  }

  //+InitializeModel
  _initializeUserModel(String userId) async {
    print('object.....................................................');
    log("id is is INITIALIZING MODELS : $userId");
    ffstore
        .collection(userCollection)
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((event) async {
      userModel.value = UserModel.fromJson(event.data() ?? {});
      await sharedPrefHelper.saveUserData(userModel);
    });
    userModel.value = await ffstore
        .collection(userCollection)
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => UserModel.fromJson(value.data() ?? {}));
  }

//+_initializeControllers
  _initializeControllers() async {
    log("initialize controllers called");
    firstNameController.text = userModel.value.name!;
    emailController.text = userModel.value.email!;
    phoneController.text = userModel.value.number!;
    homeAddressController.text = userModel.value.address!;
  }

  //+Get other UserModel
  // Future<DriverModel> getADriverModel(String uId) async {
  //   log("fetched uid is: ${uId}");
  //   return await ffstore.collection(driverCollection).doc(uId).get().then((value) {
  //     Map<String, dynamic>? userMap = value.data();
  //     DriverModel driverModel = DriverModel.fromJson(userMap ?? {});
  //     log("fetched model is: ${passengerModel}");
  //     return driverModel;
  //   });
  // }

  //+forgotPassword
  // forgotPassword() async {
  //   if (forgotPasswordKey.currentState?.validate() ?? false) {
  //     forgotPasswordKey.currentState!.save();
  //
  //     try {
  //       showLoading();
  //       await Future.delayed(Duration(seconds: 1));
  //       await auth.sendPasswordResetEmail(email: forgotPasswordController.text.trim());
  //       dismissLoadingWidget();
  //       showCustomSnackBar(
  //         title: "Success",
  //         message: "Password Reset Email has been sent. Please also check your spam folder!",
  //         seconds: 3,
  //       );
  //       Get.offAll(()=>SignIn());
  //     } on FirebaseAuthException catch (e) {
  //       dismissLoadingWidget();
  //       if (e.code == 'user-not-found') {
  //         print('No user found for that email.');
  //         Get.defaultDialog(
  //           title: 'Alert !',
  //           middleText: 'No user found for that email',
  //           textConfirm: 'Ok',
  //           confirmTextColor: Colors.blue,
  //           buttonColor: Colors.white,
  //           barrierDismissible: false,
  //           onConfirm: () {
  //             Get.back();
  //           },
  //         );
  //       } else if (e.code == "invalid-email") {
  //         Get.defaultDialog(
  //           title: 'Alert !',
  //           middleText: 'Please enter a valid email address',
  //           textConfirm: 'Ok',
  //           confirmTextColor: Colors.blue,
  //           buttonColor: Colors.white,
  //           barrierDismissible: false,
  //           onConfirm: () {
  //             Get.back();
  //           },
  //         );
  //       }
  //     }
  //   } else {
  //     Get.defaultDialog(
  //       title: "Validation Error!",
  //       middleText: "Please fill in the fields correctly.",
  //       textConfirm: "Ok",
  //       onConfirm: () {
  //         Get.back();
  //       },
  //       confirmTextColor: Colors.white,
  //       buttonColor: Colors.blueAccent,
  //     );
  //   }
  // }

  //+signOut
  signOut() async {
    isSignUp = false;
    sharedPrefHelper.saveIsSignUp(false);
    isGoogleSignIn = await sharedPrefHelper.getIsGoogle() ?? false;
    log("isGoogleSignIn in signout: $isGoogleSignIn");
    // if (isGoogleSignIn) {
    //   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    //   _googleSignIn.signOut();
    //   sharedPrefHelper.logOut();
    //   clearTextFieldController();
    // }
    await sharedPrefHelper.logOut();
    auth.signOut();
    // passengerModel = PassengerModel().obs;
    clearControllers();
    clearTextFieldController();
    // Get.offAll(() => LoginPage());
    Get.offAll(() => const ChoicePage());
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailSignInController.dispose();
    phoneController.dispose();
    otpController.dispose();
    passwordController.dispose();
    passwordSignInController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    homeAddressController.dispose();
    newEmailController.dispose();
    // newPhoneController.dispose();
    profilePasswordController.dispose();
  }

  clearControllers() {
    isSignIn = false;
    isSignUp = false;
    isPhoneLinked = false;
    isGoogleSignIn = false;
    isGoogleSignUp = false;
    // sharedPrefHelper.saveIsPhoneLinked(false);
  }

  clearTextFieldController() {
    emailController.clear();
    emailSignInController.clear();
    // phoneController.clear();
    passwordController.clear();
    passwordSignInController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    homeAddressController.clear();
    otpController.clear();
    newEmailController.clear();
    // newPhoneController.clear();
    profilePasswordController.clear();
  }

  changeUserEmail() async {
    try {
      showLoading();
      AuthCredential credential = EmailAuthProvider.credential(
          email: userModel.value.email ?? "",
          password: passwordController.text);

      UserCredential? userCredential =
          await auth.currentUser?.reauthenticateWithCredential(credential);
      log("${userCredential!.credential}");

      await auth.currentUser
          ?.updateEmail(authController.emailController.text.trim());

      await ffstore
          .collection(userCollection)
          .doc(authController.userModel.value.currentUserId)
          .update({
        "email": auth.currentUser?.email,
      });
      dismissLoadingWidget();
    } on FirebaseAuthException catch (e) {
      Get.back();
      log("error after idToken: $e");
      log("e.code: ${e.code}");
      showErrorSnackBar(e);
    }
  }

  changeUserPassword() async {
    try {
      showLoading();
      AuthCredential credential = EmailAuthProvider.credential(
          email: userModel.value.email ?? "",
          password: passwordController.text);

      UserCredential? userCredential =
          await auth.currentUser?.reauthenticateWithCredential(credential);
      log("${userCredential!.credential}");

      await auth.currentUser
          ?.updatePassword(authController.newPasswordController.text.trim());

      await ffstore
          .collection(userCollection)
          .doc(authController.userModel.value.currentUserId)
          .update({"password": newPasswordController.text});
      dismissLoadingWidget();
    } on FirebaseAuthException catch (e) {
      Get.back();
      log("error after idToken: $e");
      log("e.code: ${e.code}");
      showErrorSnackBar(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  initializedControllerForProfile() {
    firstNameController.text = userModel.value.name!;
    emailController.text = userModel.value.email!;
    phoneController.text = userModel.value.number!;
    homeAddressController.text = userModel.value.address!;
  }
}
