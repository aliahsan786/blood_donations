import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/constant/style.dart';
import 'package:blood_donations/model/request_model.dart';
import 'package:blood_donations/widgets/my_text_field.dart';

class ChatScreen extends StatefulWidget {
  final RequestModel? requestModel;
  final Map<String, dynamic>? data;
  final String? id;

  const ChatScreen({super.key, this.requestModel, this.data, this.id});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageC = TextEditingController();
  String? chatRoomId;
  @override
  void initState() {
    chatRoomId = chatController.getChatRoomId(
        widget.id!, authController.userModel.value.currentUserId ?? "");
    log("Iniate State Created ID : $chatRoomId");
    super.initState();
  }

  SendMessage() async {
    if (messageC.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'sender_id': authController.userModel.value.currentUserId,
        'sender_name': authController.userModel.value.name,
        'text': messageC.text,
        'time': DateTime.now(),
      };
      messageC.clear();
      await ffstore
          .collection(chatCollection)
          .doc(chatRoomId)
          .collection(messageCollection)
          .add(messageMap);
    } else {
      log("nothing send ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ffstore
                  .collection(requestCollection)
                  .where('currentUserId', isEqualTo: widget.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    log("snapshot hasData and length :  ${snapshot.data!.docs.length}");
                    if (snapshot.data!.docs.isNotEmpty) {
                      return Center(
                        child: Text(
                          snapshot.data!.docs[0]['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }
                  } else {
                    log("in else of hasData done on home and: ${snapshot.connectionState} and"
                        " snapshot.hasData: ${snapshot.hasData}");
                    return const Center(
                        child: Text('No Recommendations For Now'));
                  }
                } else {
                  log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream:
                  ffstore.collection(userCollection).doc(widget.id).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Center(
                      child: Text(
                        snapshot.data!['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    log("in else of hasData done on home and: ${snapshot.connectionState} and"
                        " snapshot.hasData: ${snapshot.hasData}");
                    return const Center(
                        child: Text('No Recommendations For Now'));
                  }
                } else {
                  log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
            const SizedBox(width: 25),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream:
                  ffstore.collection(userCollection).doc(widget.id).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Center(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "${(snapshot.data!['imgUrl'] != null && snapshot.data!['imgUrl'] != "") ? snapshot.data!['imgUrl'] : "https://media.istockphoto.com/id/1209654046/vector/user-avatar-profile-icon-black-vector-illustration.jpg?s=612x612&w=0&k=20&c=EOYXACjtZmZQ5IsZ0UUp1iNmZ9q2xl1BD1VvN6tZ2UI="}",
                            fit: BoxFit.cover,
                            height: 35,
                            width: 35,
                            errorBuilder: (
                              BuildContext context,
                              Object exception,
                              StackTrace? stackTrace,
                            ) {
                              return const Text(' ');
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    log("in else of hasData done on home and: ${snapshot.connectionState} and"
                        " snapshot.hasData: ${snapshot.hasData}");
                    return const Center(
                        child: Text('No Recommendations For Now'));
                  }
                } else {
                  log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: ffstore
                .collection(chatCollection)
                .doc(chatRoomId)
                .collection(messageCollection)
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              } else if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("No Chats Available"),
                    ],
                  ),
                );
              }

              List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool sendByMe =
                        authController.userModel.value.currentUserId ==
                            snapshot.data!.docs[index]["sender_id"];
                    log(" send by me : $sendByMe");
                    return MessageBubble(
                      messages: messages,
                      index: index,
                      isSendByMe: sendByMe,
                    );
                    // return Container();
                  },
                ),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  hintText: "Write Something",
                  controller: messageC,
                  autoFocus: true,
                ),
              ),
              IconButton(
                // onPressed: SendMessage,
                onPressed: () {
                  SendMessage();
                },
                icon: const Icon(Icons.send, size: 40),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;
  final int index;
  final bool isSendByMe;

  MessageBubble(
      {required this.messages, required this.index, required this.isSendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.2),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSendByMe
                      ? [
                          Colors.purple,
                          Colors.deepPurple,
                        ]
                      : [
                          // const Color(0xFF2e2e2e),
                          // const Color(0xFF2e2e2e),
                          const Color(0xFFf5f6fa),
                          const Color(0xFFf5f6fa),
                        ],
                ),
                borderRadius: isSendByMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      )),
            child: Column(
              crossAxisAlignment: isSendByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  messages[index].get('text'),
                  style: isSendByMe
                      ? messageBubbleTextStyleMe
                      : messageBubbleTextStyleOther,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Container(
            padding: isSendByMe
                ? const EdgeInsets.symmetric(horizontal: 10)
                : const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              DateFormat("hh:mm a")
                  .format(messages[index].get('time').toDate()),
              style: messageBubbleTextStyleMe.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
