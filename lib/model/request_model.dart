// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  final String? name;
  final String? imgUrl;
  final String? userId;
  final String? bloodGroup;
  final String? requestedDate;
  final String? reason;
  final String? description;
  final String? needDate;
  final String? isAcceptedByName;
  final String? isAcceptedByImgUrl;
  final String? isAcceptedById;
  final String? otherBlood;
  final List<dynamic>? otherBloodList;
  final int? age;
  final String? gender;
  final String? phone;
  final String? address;
  final String? city;
  final String? requestType;
  RequestModel({
    this.name,
    this.imgUrl,
    this.userId,
    this.bloodGroup,
    this.requestedDate,
    this.reason,
    this.description,
    this.needDate,
    this.isAcceptedByName,
    this.isAcceptedByImgUrl,
    this.isAcceptedById,
    this.otherBlood,
    this.otherBloodList,
    this.age,
    this.gender,
    this.phone,
    this.address,
    this.city,
    this.requestType,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        name: json["name"] == null ? null : json["name"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        userId: json["userId"] == null ? null : json["userId"],
        bloodGroup: json["bloodGroup"] == null ? null : json["bloodGroup"],
        requestedDate: json["requestedDate"] == null ? null : json["requestedDate"],
        reason: json["reason"] == null ? null : json["reason"],
        description: json["description"] == null ? null : json["description"],
        needDate: json["needDate"] == null ? null : json["needDate"],
        isAcceptedByName: json["isAcceptedByName"] == null ? null : json["isAcceptedByName"],
        isAcceptedByImgUrl: json["isAcceptedByImgUrl"] == null ? null : json["isAcceptedByImgUrl"],
        isAcceptedById: json["isAcceptedById"] == null ? null : json["isAcceptedById"],
        otherBlood: json["otherBlood"] == null ? null : json["otherBlood"],
        otherBloodList:
            json["otherBloodList"] == null ? [] : List<dynamic>.from(json["otherBloodList"].map((x) => x)),
        age: json["age"] == null ? null : json["age"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        requestType: json["requestType"] == null ? null : json["requestType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "userId": userId == null ? null : userId,
        "bloodGroup": bloodGroup == null ? null : bloodGroup,
        "requestedDate": requestedDate == null ? null : requestedDate,
        "reason": reason == null ? null : reason,
        "description": description == null ? null : description,
        "needDate": needDate == null ? null : needDate,
        "isAcceptedByName": isAcceptedByName == null ? null : isAcceptedByName,
        "isAcceptedByImgUrl": isAcceptedByImgUrl == null ? null : isAcceptedByImgUrl,
        "isAcceptedById": isAcceptedById == null ? null : isAcceptedById,
        "otherBlood": otherBlood == null ? null : otherBlood,
        "otherBloodList": otherBloodList == null ? null : List<dynamic>.from(otherBloodList!.map((x) => x)),
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "requestType": requestType,
      };
}
