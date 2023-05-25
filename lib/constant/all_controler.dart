import 'package:blood_donations/controller/auth_controller.dart';
import 'package:blood_donations/controller/chat_controller.dart';
import 'package:blood_donations/controller/image_controller.dart';
import 'package:blood_donations/controller/profile_controller.dart';
import 'package:blood_donations/controller/validation_controller.dart';
import 'package:blood_donations/utils/share_preference_helper.dart';

AuthController authController = AuthController.instance;
ValidationController validationController = ValidationController.instance;
ImageController imageController = ImageController.instance;
ProfileController profileController = ProfileController.instance;
SharedPreferenceHelper sharedPrefHelper = SharedPreferenceHelper.instance;
ChatController chatController = ChatController.instance;
