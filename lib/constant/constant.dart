import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore ffstore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
Reference storageReference = FirebaseStorage.instance.ref();

String userCollection = "Users";
String requestCollection = "Request";
String chatCollection = "Chats";
String messageCollection = "Messages";

User? user = FirebaseAuth.instance.currentUser;
String imagePlaceHolder =
    "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png";
List<String> genderList = [
  "Male",
  "Female",
];

List<String> bloodGroupList = [
  "A+",
  "B+",
  "O+",
  "A-",
  "B-",
  "O-",
  "AB+",
  "AB-",
];

List<String> requestType = [
  "Simple Request",
  "Emergency Request",
];
