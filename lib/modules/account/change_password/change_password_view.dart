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
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                buildContent(),
                buildBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      child: Text(
        "Thay Đổi Mật Khẩu",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      height: 68,
      child: Row(
        children: [
          Container(
            width: 48,
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_rounded),
              style: Template.backButtonStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 48),
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
                    Template.snackError(error);
                  });
                },
              )),
        ],
      ),
    ));
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
