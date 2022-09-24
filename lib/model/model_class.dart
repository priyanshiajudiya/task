// To parse this JSON data, do
//
//     final userModal = userModalFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<UserModal> userModalFromJson(String str) => List<UserModal>.from(json.decode(str).map((x) => UserModal.fromJson(x)));

String userModalToJson(List<UserModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModal {
  UserModal({
    this.uId,
    this.name,
    this.phone,
    this.userImage,
    this.email,
    this.person,
    this.dob

  });

  String? uId;
  String? name;
  String? phone;
  String? userImage;
  String? email;
  String? person;
  String? dob;

  factory UserModal.fromJson(Map  json) => UserModal(
    uId: json["uId"],
    name: json["name"],
    phone: json["phone"],
    userImage: json["userImage"],
    email: json["email"],
    person: json["person"],
    dob: json["dob"]
  );

  Map<String, dynamic> toJson() => {
    "uId": uId,
    "name": name,
    "phone": phone,
    "userImage": userImage,
    "email": email,
    "person" :person,
    "dob":dob
  };
}
//==========================================================================================================

class share_pref
{
  static SharedPreferences? pref;
}
//==============================================================================================================
/*


 */

class geturl
{
  final storageRef = FirebaseStorage.instance;
  String path = FirebaseAuth.instance.currentUser!.uid;
 ImagePicker? _picker;
  String? imageurl;
  Future pickPhoto() async {
    final XFile? image = await _picker!.pickImage(source: ImageSource.camera);

    File file = File(image!.path);
    if (image != null) {
      var snapshot =
      await storageRef.ref().child('images/${image.name}').putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();

        imageurl = downloadUrl;
      print(imageurl);
    }
  }
}
