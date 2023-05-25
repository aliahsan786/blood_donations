import 'dart:developer';

import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/screens/chat/chat_screen.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();

  getChatRoomId(String userID, String anotherUserID) {
    print("inside getChatRoomId a = $userID & b = $anotherUserID");
    var chatRoomId;
    if (userID.compareTo(anotherUserID) > 0) {
      chatRoomId = '$userID - $anotherUserID';
    } else {
      chatRoomId = '$anotherUserID - $userID';
    }
    log(" chat Rooom ID is $chatRoomId");
    return chatRoomId;
  }

  Future<void> createChatRoomandStartCOnversition(
      otherID, otherUserName) async {
    log("other ID $otherID");
    log("${authController.userModel.value.currentUserId ?? ""}");
    try {
      String chatRoomId = chatController.getChatRoomId(
          otherID, authController.userModel.value.currentUserId ?? "");

      log("Created chat Room ID: $chatRoomId");
      await ffstore
          .collection(chatCollection)
          .doc(chatRoomId)
          .get()
          .then((value) async {
        if (value.exists) {
          String id = value.data()!['otherID'];
          Get.to(() => ChatScreen(data: value.data(), id: id));
        } else {
          Map<String, dynamic> chatRoomMap = {
            "chatRoomId": chatRoomId,
            'otherID': otherID,
            'currentUserId': authController.userModel.value.currentUserId,
            'otherUserName': otherUserName,
            'currentUserName': authController.userModel.value.name,
            "users": [
              authController.userModel.value.currentUserId,
              otherID,
            ]
          };
          await ffstore
              .collection(chatCollection)
              .doc(chatRoomId)
              .set(chatRoomMap);
        }
      });
    } catch (e) {
      print('Something went wrong while creating chat room ${e.toString()}');
    }
  }
}
