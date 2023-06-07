import 'dart:developer';

import 'package:blood_donations/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/model/request_model.dart';
import 'package:blood_donations/screens/plasma/view_image.dart';
import 'package:blood_donations/utils/show_loading.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class BPositive extends StatelessWidget {
  const BPositive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CustomAppBar(title: "Donate Blood"),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ffstore
            .collection(userCollection)
            .where('bloodGroup', isEqualTo: 'B+')
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
              if (snapshot.data!.docs.length > 0) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    UserModel requestModel = UserModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);
                    return RequestPart(
                      requestModel: requestModel,
                      //////     isEmergency: isEmergency,
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No Recommendations For Now',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            } else {
              log("in else of hasData done on home and: ${snapshot.connectionState} and"
                  " snapshot.hasData: ${snapshot.hasData}");
              return const Center(child: Text('No Recommendations For Now'));
            }
          } else {
            log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }
}

class RequestPart extends StatelessWidget {
  final UserModel? requestModel;
  final bool? isEmergency;
  const RequestPart({Key? key, this.requestModel, this.isEmergency})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          ListTile(
            leading: Hero(
              tag: 'profilePicHero',
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  (requestModel?.imgUrl != null && requestModel?.imgUrl != "")
                      ? "${requestModel?.imgUrl}"
                      : imagePlaceHolder,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "${requestModel?.name}",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Tiles(
            icon: Icons.bloodtype,
            title: "Blood Group ${requestModel?.bloodGroup}",
          ),
          Tiles(
            icon: FontAwesomeIcons.grav,
            title: "${requestModel?.gender}",
          ),
          Tiles(
            icon: FontAwesomeIcons.locationDot,
            title: "${requestModel?.address}",
          ),
          Tiles(
            icon: FontAwesomeIcons.phone,
            title: "${requestModel?.number}",
          ),
          10.heightBox,
          // isEmergency == true
          //     ? Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: Row(
          //           children: [
          //             Expanded(
          //               child: MyText(
          //                 text: "Emergency Case",
          //                 size: 15,
          //                 weight: FontWeight.bold,
          //               ),
          //             ),
          //             const SizedBox(width: 5),
          //             Expanded(
          //               child: MySmallButton(
          //                 txt: "View Image",
          //                 onPressed: () async {
          //                   Get.to(() => ViewImage(path: requestModel?.imgUrl));
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     : MyText(
          //         text: "Simple Case",
          //         size: 15,
          //         weight: FontWeight.bold,
          //       ),
          20.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: MySmallButton(
                    txt: "Chat",
                    onPressed: () {
                      if (requestModel?.currentUserId !=
                          authController.userModel.value.currentUserId) {
                        chatController.createChatRoomandStartCOnversition(
                            requestModel?.currentUserId!, requestModel?.name!);
                      } else {
                        showCustomSnackBar(
                            title: "Alert", message: "You cannot msg ");
                      }
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: MySmallButton(
                    txt: "Call",
                    onPressed: () async {
                      if (requestModel?.number != "" &&
                          requestModel?.number != null) {
                        String url = 'tel:${requestModel?.number}';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launch(url);
                        } else {
                          print('can not  launch url Number Not Available ');
                        }
                      } else {
                        showCustomSnackBar(
                          title: 'Sorry',
                          message: "Driver contact number not available",
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget? widget;
  final Color? color;

  const Tiles({Key? key, this.title, this.icon, this.widget, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      leading: Icon(
        icon,
        color: color ?? Colors.red,
        size: 18,
      ),
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
