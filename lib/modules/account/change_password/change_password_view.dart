import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/account/change_password/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);
  double itemHeight = 48.0;
  double marginField = 16.0;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Thay đổi mật khẩu"),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 16),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 12),
              height: itemHeight,
              color: Colors.white,
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: decor(hintText: "Mật khẩu cũ", label: ""),
                obscureText: true,
                controller: controller.oldPasswordEditController,
              )),
          Container(
              margin: EdgeInsets.only(bottom: 12),
              height: itemHeight,
              color: Colors.white,
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: decor(hintText: "Mật khẩu mới", label: ""),
                controller: controller.newPassworEditController,
              )),
          Container(
              margin: EdgeInsets.only(bottom: 12),
              height: itemHeight,
              color: Colors.white,
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: decor(hintText: "Nhập lại mật khẩu mới", label: ""),
                controller: controller.confirmPasswordEditController,
              )),
          Container(
              margin: EdgeInsets.only(top: 40),
              width: double.infinity,
              height: itemHeight,
              color: Colors.white,
              child: TextButton(
                child: Text("Xác Nhận"),
                style: Template.primaryButtonStyle,
                onPressed: () {
                  controller.sumbit(onSuccess: () {
                    Template.snackSuccess("Thay đổi mật khẩu thành công");
                  }, onFailure: (error) {
                    Template.dialogError(error);
                  });
                },
              )),
        ],
      ),
    );
  }

  InputDecoration decor({required String hintText, required String label}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 12),
      hintText: hintText,
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.black.withOpacity(0.2))),
    );
  }
}
