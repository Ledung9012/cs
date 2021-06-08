import 'dart:convert'; // for the utf8.encode method

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/account/account_controller.dart';
import 'package:mobile/modules/account/account_provider.dart';

enum LoginState {
  none,
  login,
  alreadyRegister, // Trạng thái kiểm tra số điện thoại, đã có tài khoản
  preRegister, // Trạng thái
  register,
}

class LoginController extends GetxController {
  Rx<LoginState> loginState = LoginState.none.obs;

  Function() authenSuccess;
  Function(String) authenFalse;

  LoginController({required this.authenSuccess,required this.authenFalse});
  var _verificationId = "";
  var _phone = "";

  var authenticationCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneEditController = TextEditingController();

  AccountProvider loginProvider = AccountProvider();

  @override
  void onReady() {
    super.onReady();
    loginState.value = LoginState.none;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onInit() {
    super.onInit();
    Get.lazyPut<RegisterController>(() => RegisterController());
    loginState.value = LoginState.none;
  }

  bool isState(LoginState state) {
    return (loginState.value == state);
  }

  bool setState(LoginState state) {
    loginState.value = state;
  }

  void goFogotPass() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
    Get.to(ResetPasswordView());
  }

  void goRegister() {
    setState(LoginState.none);
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.to(RegisterView());
  }

  void logon(String username, String password,
      {Function onSuccess, Function(String) onFailure}) {
    if (username.isEmpty) {
      onFailure("Vui lòng nhập số điện thoại");
      return;
    }

    if (password.isEmpty) {
      onFailure("Vui lòng nhập mật khẩu");
      return;
    }










    var bytes = utf8.encode(password); // data being hashed
    var digest = md5.convert(bytes);
    print("Digest as bytes: ${digest.bytes}");
    print("Digest as hex string: $digest");

    print("user------------Login");
    loginProvider.login(username, digest.toString()).then((value) {
      if (value is CSUser) {
        UserInstance().login(value);

        onSuccess();
        logonSuccess();
      } else {
        onFailure(value);
      }
    }).onError((error, stackTrace) {
      onFailure(error.toString());
    });
  }

  void submitPhone(String phone,
      {Function onSuccess, Function(String) onFailure}) {
    _phone = phone;
    if (phone.isEmpty) {
      onFailure("Vui lòng nhập số điện thoại");
      return;
    }


    final regexp = RegExp('(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})');
    if(!regexp.hasMatch(phone)) {
      onFailure("Số điện thoại không hợp lệ");
      return;
    }


    loginProvider.userCheckAlreadyExists(phone, (exists) {
      onSuccess();
      if (!exists) {
        smsAuthentication();
      } else {
        setState(LoginState.alreadyRegister);
      }
    }, (error) {
      onFailure(error);
    });
  }

  void smsAuthentication() {
    FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: false);

    var countryCode = "+84";
    print("Phone remove--------------${_phone.removeFirst()}");

    var exPhone = countryCode + _phone.removeFirst() ;

    print("Phone Submit --------------${exPhone}");

    FirebaseAuth.instance.verifyPhoneNumber(


        phoneNumber: exPhone,
        verificationCompleted: (phoneAuthCredential) {
          print("verificationCompleted---------${phoneAuthCredential}");
        },
        verificationFailed: (error) {
          print("smsAuthentication---------${error}");
        },
        codeSent: (id, token) {
          _verificationId = id;
          setState(LoginState.preRegister);
          print("codeSent---------${token}");
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  void confirmVirificationCode(
      String value, Function onSuccess, Function(String) onFailure) async {
    if (value.isEmpty) {
      onFailure("Vui lòng nhập mã xác thực.");
      return;
    }

    if (value.length < 6) {
      onFailure("Mã xác thực phải có 6 ký tự.");
      return;
    }

    AuthCredential cre = await PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: value);

    FirebaseAuth.instance.signInWithCredential(cre).catchError((error) {
      onFailure(
          "Mã xác thực không khả dụng hoặc hết hiệu lực. Vui lòng thử lại");
    }).then((value) {
      print("confirmVirificationCode---------$value");
      if (value != null) {
        this.goRegister();
      }
    });
  }


  void logonSuccess(){
    var controller = Get.put(AccountController());
    controller.refresh();
  }

  void onChangePhone() {
    setState(LoginState.none);
  }
}