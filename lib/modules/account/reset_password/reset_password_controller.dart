import 'dart:convert'; // for the utf8.encode method

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/modules/account/account_provider.dart';

enum ResetPasswordState {
  none, // Trạng thái vừa mởi, Call api lấy mã xác thực
  autheCodeCorrect, //Trạng thái nhập mã xác nhận đúg
}

class ResetPasswordController extends GetxController {
  Rx<ResetPasswordState> resetPasswordstate = ResetPasswordState.none.obs;

  final authCodeController = TextEditingController();
  final passwordEditController = TextEditingController();
  final passwordConfirmEditController = TextEditingController();

  var _verificationId = "";
  var phone = "";

  AccountProvider registerProvider = AccountProvider();

  ResetPasswordController(this.phone);

  @override
  void onInit() {
    super.onInit();
    smsAuthentication();
  }

  bool isState(ResetPasswordState value) {
    return resetPasswordstate.value == value;
  }

  void setState(ResetPasswordState state) {
    resetPasswordstate.value = state;
  }

  void smsAuthentication() {
    FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: false);
    var countryCode = "+84";
    var exPhone = countryCode + phone.removeFirst();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: exPhone,
        verificationCompleted: (phoneAuthCredential) {
          print("verificationCompleted---------$phoneAuthCredential");
        },
        verificationFailed: (error) {
          print("smsAuthentication---------$error");
        },
        codeSent: (id, token) {
          _verificationId = id;
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  void submitAuthenCode(
      {required Function onSuccess,
      required Function(String) onFailure}) async {
    String authenValue = authCodeController.text;


    print("virification id : $_verificationId");
    print("authencode  id : $authenValue");

    AuthCredential cre = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: authenValue);

    FirebaseAuth.instance.signInWithCredential(cre).catchError((error) {
      if(error != null) {
        onFailure( "Mã xác thực không khả dụng hoặc hết hiệu lực. Vui lòng thử lại");
      }
    }).then((value) {
      print("then value :  $value");
      if(value.user != null) {
        setState(ResetPasswordState.autheCodeCorrect);
      }
    });
  }

  void submit(
      {required Function onSuccess, required Function(String) onFailure}) {
    String password = passwordEditController.text;
    String passwordConfirm = passwordConfirmEditController.text;

    if (password.isEmpty) {
      onFailure("Vui lòng nhập mật khẩu");
      return;
    }

    if (passwordConfirm.isEmpty) {
      onFailure("Vui lòng xác nhận mật khẩu");
      return;
    }

    if (password != passwordConfirm) {
      onFailure("Mật khẩu và xác nhận không giống nhau. Vui lòng kiểm tra lại");
      return;
    }

    var bytes = utf8.encode(password); // data being hashed
    var digest = md5.convert(bytes);

    registerProvider.resetPassword(phone, digest.toString(), () {
      onSuccess();
    }, (value) {
      onFailure(value);
    });
  }

}
