import 'package:get/get.dart';
import 'package:blood_donations/controller/auth_controller.dart';
import 'package:blood_donations/controller/chat_controller.dart';
import 'package:blood_donations/controller/image_controller.dart';
import 'package:blood_donations/controller/profile_controller.dart';
import 'package:blood_donations/controller/validation_controller.dart';

Future<void> init() async {
  print('0');
  Get.put(AuthController());
  print('1');
  Get.put(ValidationController());
  Get.put(ImageController());
  Get.put(ProfileController());
  Get.put(ChatController());
}

class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
