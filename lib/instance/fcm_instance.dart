import 'package:flutter/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile/modules/account/account_provider.dart';

var fcm = FCMInstance();

class FCMInstance {
  static final FCMInstance _singleton = FCMInstance._internal();

  factory FCMInstance() {
    return _singleton;
  }

  FCMInstance._internal();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  var token = "";

  void initialize() {
    requestPermission().then((val) {}).onError((error, stackTrace) {});
  }

  Future requestPermission() async {
    _firebaseMessaging.requestPermission();
    String? deviceToken = await _firebaseMessaging.getToken();
    this.token = (deviceToken != null) ? deviceToken : "";
  }

  void loginSuccess() {
    AccountProvider().updateToken(this.token, () {}, (error) {});
  }
}
