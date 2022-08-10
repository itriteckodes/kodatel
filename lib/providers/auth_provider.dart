import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant/firestore_constants.dart';
import 'package:kodatel/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final PhoneAuthProvider phoneAuthProvider;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;
  late Users? users;
  bool isLoading = false;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.phoneAuthProvider,
    required this.prefs,
    required this.firebaseFirestore,
  });
  void setUsers(Users users) {
    this.users = users;
    notifyListeners();
  }

  Users? getUsers() {
    return users;
  }

  void setIsloading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> isLoggedIn() async {
    User? user = firebaseAuth.currentUser;
    if (user != null &&
        prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn(
      String _verificationCode, String pin, String phone) async {
    isLoading = true;
    notifyListeners();

    bool isHAveAccount = await isHaveAccountAlready(phone);
    if (isHAveAccount == false) {
      final credentail = PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: pin);
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credentail);

      User? user = result.user;
      if (user != null) {
        isLoading = false;
        notifyListeners();

        return true;
      }
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<String?> uploadToStorage(File file) async {
    isLoading = true;

    notifyListeners();
    try {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String today = ('$millSeconds');

      Reference ref = FirebaseStorage.instance.ref("profile").child(today);

      UploadTask uploadTask = ref.putFile(file);

      var dowurl = await (await uploadTask).ref.getDownloadURL();
      String url = dowurl.toString();

      return url;
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<bool> createProfile(Map<String, String> data) async {
    final instance = FirebaseFirestore.instance;

    return instance
        .collection("user")
        .doc(data['phone'])
        .set(data)
        .then((value) {
      isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      log(error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void resetPassword(String pass) {
    final instance = FirebaseFirestore.instance;
    instance
        .collection('user')
        .doc(prefs.getString('phone'))
        .update({'password': pass});
    prefs.clear();
  }

  Future<bool> isHaveAccountAlready(String phone) {
    final instance = FirebaseFirestore.instance;
    return instance.collection('user').get().then((value) {
      for (var item in value.docs) {
        if (item.get('phone') == phone) {
          return true;
        }
      }
      return false;
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<bool> logIn(String phone, String pass) {
    isLoading = true;
    notifyListeners();
    return FirebaseFirestore.instance
        .collection('user')
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) {
      String password = value.docs.single['password'];
      if (password == pass) {
        prefs.setString(FirestoreConstants.name, value.docs.single['name']);
        prefs.setString(FirestoreConstants.status, value.docs.single['status']);
        prefs.setString(FirestoreConstants.phone, value.docs.single['phone']);
        prefs.setString(
            FirestoreConstants.profileUrl, value.docs.single['profileUrl']);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    }).catchError((error) {
      log(error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    prefs.clear();
    await firebaseAuth.signOut();
  }
}
