import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kodatel/constant/firestore_constants.dart';
import 'package:kodatel/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});

  String? getPref(String key) {
    return prefs.getString(key);
  }

  Future<String?> uploadToStorage(File file, String type) async {
    try {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String today = ('$millSeconds');
      Reference ref = FirebaseStorage.instance.ref("image").child(today);
      if (type == 'video') {
        ref = FirebaseStorage.instance.ref("video").child(today);
      }
      if (type == 'audio') {
        ref = FirebaseStorage.instance.ref("audio").child(today);
      }
      if (type == 'document') {
        ref = FirebaseStorage.instance.ref("document").child(today);
      }

      UploadTask uploadTask = ref.putFile(file);
      var dowurl = await (await uploadTask).ref.getDownloadURL();
      String url = dowurl.toString();

      return url;
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> gettMsgs(String chatOf) {
    return firebaseFirestore
        .collection('messages')
        .doc(chatOf)
        .collection('msg')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<String> resolveId(
    String chatOf,
    String chatWith,
  ) {
    return firebaseFirestore.collection('messages').get().then((value) {
      String id = chatOf + '&' + chatWith;
      for (var element in value.docs) {
        if (chatOf + '&' + chatWith == element.id) {
          id = element.id;
        } else if (chatWith + '&' + chatOf == element.id) {
          id = element.id;
        }
      }
      return id;
    });
  }

  void sendMessage(String content, String chatOf, String chatWith, String time,
      String msgType) async {
    await firebaseFirestore.collection('messages').get().then((value) {
      String id = chatOf + '&' + chatWith;
      for (var element in value.docs) {
        if (chatOf + '&' + chatWith == element.id) {
          id = element.id;
        } else if (chatWith + '&' + chatOf == element.id) {
          id = element.id;
        }
      }
      firebaseFirestore
          .collection(FirestoreConstants.pathMessageCollection)
          .doc(id)
          .set({'lastMsg': content, 'time': time});
      DocumentReference documentReference = firebaseFirestore
          .collection(FirestoreConstants.pathMessageCollection)
          .doc(id)
          .collection('msg')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      MessageChat messageChat = MessageChat(
        idFrom: chatOf,
        idTo: chatWith,
        time: time,
        msgType: msgType,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        msg: content,
      );

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          messageChat.toJson(),
        );
      });
    });
  }
}
