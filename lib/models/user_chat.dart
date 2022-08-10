import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kodatel/constant/firestore_constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;

  UserChat(
      {required this.id,
      required this.photoUrl,
      required this.nickname,
      required this.aboutMe});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.name: nickname,
      FirestoreConstants.status: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    try {
      aboutMe = doc.get(FirestoreConstants.status);
    } catch (e) {
      log(e.toString());
    }
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {
      log(e.toString());
    }
    try {
      nickname = doc.get(FirestoreConstants.name);
    } catch (e) {
      log(e.toString());
    }
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
    );
  }
}
