import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.password,
    this.number,
    this.city,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.imgUrl,
    this.createdat,
    this.province,
    this.currentUserId,
  });

  final String? currentUserId;
  final String? name;
  final String? email;
  final String? password;
  final String? number;
  final String? city;
  final String? address;
  final String? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  String? imgUrl;
  final String? createdat;
  final String? province;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"] == null ? null : json["name"],
        currentUserId: json["currentUserId"] == null ? null : json["currentUserId"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        number: json["number"] == null ? null : json["number"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["bloodGroup"] == null ? null : json["bloodGroup"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        createdat: json["createdat"] == null ? null : json["createdat"],
        province: json["province"] == null ? null : json["province"],
      );

  Map<String, dynamic> toJson() => {
        "currentUserId": currentUserId == null ? null : currentUserId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "number": number == null ? null : number,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "gender": gender == null ? null : gender,
        "bloodGroup": bloodGroup == null ? null : bloodGroup,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "createdat": createdat == null ? null : createdat,
        "province": province == null ? null : province,
      };
}
