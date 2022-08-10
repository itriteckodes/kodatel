import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kodatel/constant/firestore_constants.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String msg;
  String time;
  String msgType;

  MessageChat(
      {required this.idFrom,
      required this.idTo,
      required this.time,
      required this.timestamp,
      required this.msg,
      required this.msgType});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.time: time,
      FirestoreConstants.msg: msg,
      FirestoreConstants.msgType: msgType
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String time = doc.get(FirestoreConstants.time);
    String msg = doc.get(FirestoreConstants.msg);
    String msgType = doc.get(FirestoreConstants.msgType);

    return MessageChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        time: time,
        msg: msg,
        msgType: msgType);
  }
}
