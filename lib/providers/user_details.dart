import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kodatel/model/user_model.dart';
import 'package:kodatel/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  List<Users> users = [];
  final SharedPreferences prefs;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  UserDetails(this.prefs);
  Future<void> getAllUsers() async {
    final fcmToken = await fcm.getToken();
    final tokenRef = FirebaseFirestore.instance
        .collection('user')
        .doc(prefs.getString('phone'))
        .collection('tokens')
        .doc(fcmToken);
    await tokenRef.set(
        TokenModel(token: fcmToken, createdAt: FieldValue.serverTimestamp())
            .toJson());
    FirebaseFirestore.instance.collection('user').get().then((value) {
      users.clear();
      for (var element in value.docs) {
        users.add(Users(
            lastSeen: element.get('lastSeen'),
            name: element.get('name'),
            phone: element.get('phone'),
            status: element.get('status'),
            photoUrl: element.get('profileUrl')));
      }
    });
  }

  String searchUser(String phone) {
    String userName = 'abc';
    FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        if (element.get('phone' == phone)) {
          userName = element.get('name');
          return;
        }
      }
    });
    return userName;
  }

  List<Users> getUsers() {
    return users;
  }
}
