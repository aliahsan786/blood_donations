import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/style.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';

import '../../constant/constant.dart';
import 'chat_screen.dart';

class ChatHead extends StatefulWidget {
  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHead> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Chats"),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: ffstore
                    .collection(chatCollection)
                    .where('users',
                        arrayContains:
                            authController.userModel.value.currentUserId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          String name = snapshot.data!.docs[index]['otherID'] !=
                                  auth.currentUser!.uid
                              ? snapshot.data!.docs[index]['otherUserName']
                              : snapshot.data!.docs[index]['currentUserName'];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                onTap: () {
                                  //other id
                                  String id = snapshot.data!.docs[index]
                                              ['currentUserId'] ==
                                          auth.currentUser!.uid
                                      ? snapshot.data!.docs[index]['otherID']
                                      : snapshot.data!.docs[index]
                                          ['currentUserId'];
                                  Get.to(() => ChatScreen(id: id));
                                },
                                title: Text("$name"),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      log("in else of hasData done and: ${snapshot.connectionState} and"
                          " snapshot.hasData: ${snapshot.hasData}");
                      return SizedBox();
                    }
                  } else {
                    log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadMessage extends StatefulWidget {
  const ReadMessage({
    this.img,
    this.chatRoomId,
    this.name,
    this.message,
    this.time,
  });

  final img;
  final chatRoomId;
  final name;
  final message;
  final time;

  @override
  _ReadMessageState createState() => _ReadMessageState();
}

class _ReadMessageState extends State<ReadMessage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // var chatRoomMap;
        // chatRoomMap = await chatController.getAChatRoomInfo(widget.chatRoomId);
        // Get.to(() => ChatScreen(docs: chatRoomMap), transition: Transition.leftToRight);
      },
      child: Card(
        margin: EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.8,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Text("")),
                      ),
                    ],
                  ),
                  title: Container(
                      width: Get.width * 0.30,
                      child: Text(
                        widget.name,
                        style: BlackSmallStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                  trailing: Text(
                    DateTime.now()
                                .difference(DateTime.fromMillisecondsSinceEpoch(
                                    widget.time))
                                .inMinutes <
                            60
                        ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inMinutes} m ago"
                        : DateTime.now()
                                    .difference(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            widget.time))
                                    .inHours <
                                24
                            ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inHours} hrs ago"
                            : "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inDays} days ago",
                    style: TextStyle(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
