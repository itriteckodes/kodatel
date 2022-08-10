import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';

final kApiUrl = defaultTargetPlatform == TargetPlatform.android
    ? 'http://10.0.2.2:4242'
    : 'http://localhost:4242';

const backgroundColor = Color.fromARGB(255, 46, 104, 133);
const foregroundColor = Colors.white;
const widgetColor = Color.fromARGB(60, 175, 175, 175);
const fontSize = 15.0;
const black = Colors.black;
const bold = FontWeight.bold;
const kBackgoundColor = Color(0xFF091C40);
const kSecondaryColor = Color(0xFF606060);
const kRedColor = Color(0xFFFF1E46);
const padding = 10.0;
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String encryptText(String plainText) {
  final key = enc.Key.fromLength(64);
  final iv = enc.IV.fromLength(8);
  final encrypter = enc.Encrypter(enc.Salsa20(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

String decryptText(final encrypted) {
  final key = enc.Key.fromLength(64);
  final iv = enc.IV.fromLength(8);
  final encrypter = enc.Encrypter(enc.Salsa20(key));
  final decrypted = encrypter.decrypt64(encrypted, iv: iv);
  return (decrypted);
}
