// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';

class ValidationController extends GetxController {
  static ValidationController instance = Get.find();

  String? emailValidator(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? noValidation(String value) {
    log("${value}");
  }

  String? nameValidator(String value) {
    // !RegExp(r'^[a-z A-Z]+$').hasMatch(value)
    //  RegExp rex = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    if (value.isEmpty) {
      return "Please enter a name";
    }
    // else if (value.contains(RegExp(r'[0-9]'))) {
    //   return "Please enter a name";
    // }
    return null;
  }

  String? cityValidator(String value) {
    if (value.isEmpty) {
      return "Please enter a city";
    }

    return null;
  }

  String? lastNameValidator(String value) {
    if (value.isEmpty) {
      return "Please enter a name";
    }

    return null;
  }

  String? addressValidator(String value) {
    if (value.trim().isEmpty || value.trim() == "") {
      return "Please enter a address";
    }
    return null;
  }

  String? reasonValidator(String value) {
    if (value.trim().isEmpty || value.trim() == "") {
      return "Please enter a reason";
    }
    return null;
  }

  passwordValidatopr(String pass) {
    if (pass.trim().isEmpty) {
      print('Password is Required');
      return 'Password is Required';
    } else if (pass.trim().length < 6) {
      print('Password must have at least 6 elements');
      return 'Password must have at least 6 elements';
    }

    return null;
  }

  String passwordEqualityCheck = "";

  confirmPasswordValidator(String confirmPassword) {
    passwordEqualityCheck = authController.passwordController.text;
    if (confirmPassword.isEmpty) {
      return 'Confirming your password is Required';
    } else {
      if (confirmPassword == passwordEqualityCheck) {
        print(
            "passwordEqualityCheck in MATCHING null else is $passwordEqualityCheck");
        return null;
      } else {
        print(
            "passwordEqualityCheck in null NOT MATCHING else is $passwordEqualityCheck "
            "and password is $confirmPassword");
        return "Password Mismatch! Both Passwords should be same.";
      }
    }
  }

  phoneValidator(String phone) {
    if (phone.trim().isEmpty) {
      print('phone is Required');
      return 'Phone number is required';
    } else if (!phone.trim().startsWith("+")) {
      return 'Adding a + followed by country code is required';
    }
    return null;
  }
  //

  String? PhoneNumberValidator(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    // if (value.length != 13) {
    //   return 'No Format should be +923001122333';
    // }
    // if (!RegExp(r'(^(?:[+92]+92)?[0-9]{10}$)').hasMatch(value)) {
    //   return "Invalid Format!";
    // }
    return null;
  }

  RelationShipStatus(String relation) {
    if (relation == null) {
      print("selected Gender from Top variable is: ");
      print("selected Gender from internal value is: $relation");
      return 'Selecting a RelationShip status is Required';
    } else if (relation == "Current relationship status") {
      return 'Selecting a RelationShip status is Required';
    }

    return null;
  }

  static String? name(String val) {
    final regExp = RegExp(r"^[a-zA-Z]+(([' -][a-zA-Z ])?[a-zA-Z]*)*$");
    if (!regExp.hasMatch(val)) {
      return '* Please enter a valid name';
    }
    return null;
  }
}
