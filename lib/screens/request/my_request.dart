import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/model/request_model.dart';
import 'package:blood_donations/screens/request/edit_my_request.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/my_button.dart';

class MyRequest extends StatelessWidget {
  const MyRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CustomAppBar(title: "My Request"),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ffstore
            .collection(requestCollection)
            .where('userId',
                isEqualTo: authController.userModel.value.currentUserId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                    RequestModel requestModel = RequestModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);
                    return RequestPart(
                      requestModel: requestModel,
                      id: snapshot.data!.docs[index].id,
                    );
                  },
                );
              } else {
                return Center(
                  child: const Text(
                    'No Recommendations For Now',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            } else {
              log("in else of hasData done on home and: ${snapshot.connectionState} and"
                  " snapshot.hasData: ${snapshot.hasData}");
              return Center(child: const Text('No Recommendations For Now'));
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
  final RequestModel requestModel;
  final String id;
  const RequestPart({Key? key, required this.requestModel, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 5),
          ListTile(
            leading: Hero(
              tag: 'profilePicHero',
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  (requestModel.imgUrl != null && requestModel.imgUrl != "")
                      ? "${requestModel.imgUrl}"
                      : imagePlaceHolder,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "${requestModel.name}",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Tiles(
            icon: Icons.bloodtype,
            title: "Blood  ${requestModel.bloodGroup}",
          ),
          Tiles(
            icon: FontAwesomeIcons.grav,
            title: "${requestModel.gender}",
          ),
          Tiles(
            icon: FontAwesomeIcons.locationDot,
            title: "${requestModel.address}",
          ),
          Tiles(
            icon: FontAwesomeIcons.phone,
            title: "${requestModel.phone}",
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: MySmallButton(
                    txt: "Edit",
                    onPressed: () {
                      Get.to(() =>
                          EditMyRequest(requestModel: requestModel, id: id));
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: MySmallButton(
                    txt: "Delete",
                    onPressed: () async {
                      await ffstore
                          .collection(requestCollection)
                          .doc(id)
                          .delete();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
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
