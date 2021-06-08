import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/account/account_provider.dart';

class  ChangePasswordController extends GetxController {
  TextEditingController oldPasswordEditController = TextEditingController();
  TextEditingController newPassworEditController = TextEditingController();
  TextEditingController confirmPasswordEditController = TextEditingController();

  AccountProvider _provider = AccountProvider();

  void sumbit({required Function onSuccess,required Function(String) onFailure}) {
    String oldPass = oldPasswordEditController.text;
    String newPass = newPassworEditController.text;
    String confirmPass = confirmPasswordEditController.text;

    if (oldPass.isEmpty) {
      onFailure("Vui lòng nhập mật khẩu cũ");
      return;
    }

    if (newPass.isEmpty) {
      onFailure("Vui lòng nhập mật khẩu mới");
      return;
    }

    if (newPass.length <6) {
      onFailure("Mật khẩu tối thiểu 6 ký tự");
      return;
    }

    if (confirmPass.isEmpty) {
      onFailure("Vui lòng xác nhận mật khẩu mới");
      return;
    }

    if (newPass != confirmPass) {
      onFailure("Mật khẩu và xác nhận không giống nhau");
      return;
    }

    var bytes = utf8.encode(oldPass); // data being hashed
    var digest = md5.convert(bytes);


    var bytesNew = utf8.encode(newPass); // data being hashed
    var digestNew= md5.convert(bytesNew);

    FocusManager.instance.primaryFocus!.unfocus();


    _provider.changePassword(id: 2, password: digest.toString(), newPassword : digestNew.toString(), success: (){

      onSuccess();
      clear();
    }, onError: (error){
      onFailure(error);

    });
  }

  void clear() {
    oldPasswordEditController.text = "";
    newPassworEditController.text = "";
    confirmPasswordEditController.text = "";

  }
}
