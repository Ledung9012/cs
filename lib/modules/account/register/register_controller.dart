import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/modules/account/account_provider.dart';
import 'dart:convert'; // for the utf8.encode method


class RegisterController extends GetxController {
  String phoneNumber = "0971568901";
  final nameEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  final passwordConfirmEditController = TextEditingController();
  final collaboratorEditController = TextEditingController();
  AccountProvider registerProvider = AccountProvider();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String validate() {
    String errorMessage = "";
    if (nameEditController.text.trim().length == 0) {
      errorMessage = "Vui lòng nhập tên của bạn";
      return errorMessage;
    }

    if (passwordEditController.text.length == 0) {
      errorMessage = "Vui lòng nhập mật khẩu";
      return errorMessage;
    }

    if (passwordEditController.text.length < 6) {
      errorMessage = "Mật khẩu phải dài hơn 6 ký tự.";
      return errorMessage;
    }

    if (passwordConfirmEditController.text.length == 0) {
      errorMessage = "Vui lòng xác nhận lại mật khẩu";
      return errorMessage;
    }

    if (passwordConfirmEditController.text != passwordEditController.text) {
      errorMessage =
          "Mật khẩu và xác nhận không giống nhau. Vui lòng kiểm tra lại";
      return errorMessage;
    }
    return errorMessage;
  }

  void register(Function(String) onSuccess, Function(String) onError) {
    // Register Validation ;
    String error = validate();
    if (error.length > 0) {
      onError(error);
      return;
    } else {

      String username = phoneNumber;
      String password = passwordConfirmEditController.text;
      String name = nameEditController.text;


      var bytes = utf8.encode(password); // data being hashed
      var digest = md5.convert(bytes);


      registerProvider.register(username, digest.toString(), name, (userID) {
        UserInstance().login(userID).then((value) {
          onSuccess("");
        });
      }, (error) {
        onError(error);
      });
    }
  }
}
