import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/main.dart';
import 'package:mobile/modules/account/account_controller.dart';
import 'package:mobile/modules/account/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {



  Function complete;

  RegisterView({required this.complete});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng Ký Tài Khoản"),
        backgroundColor: Template.primaryColor,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 24, right: 24, bottom: 12),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: RichText(
                    text: TextSpan(
                        text: "Tài khoản đăng nhập của bạn là ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        children: [
                          TextSpan(
                              text: controller.phoneNumber,
                              style: TextStyle(
                                  height: 1.8,
                                  color: Template.primaryColor,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,

                      onSubmitted: (value) {},
                      controller: controller.nameEditController,
                      decoration:
                          InputDecoration(hintText: "Nhập tên đầy đủ của bạn")),
                ),
                Container(
                  child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      controller: controller.passwordEditController,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                        hintText: "Mật khẩu",
                      )),
                ),
                Container(
                  child: TextField(
                      autocorrect: false,
                      controller: controller.passwordConfirmEditController,
                      obscureText: true,
                      onSubmitted: (value) {},
                      decoration:
                          InputDecoration(hintText: "Xác nhận lại mật khẩu")),
                ),
                Container(
                  child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,

                      controller: controller.collaboratorEditController,
                      obscureText: true,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                          hintText: "Số điện thoại người giới thiệu")),
                ),
                buildLoginGroup()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginGroup() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              child: Text("Đăng Ký"),
              onPressed: () {
                controller.register((success) {

                  AccountController accountController = Get.put(AccountController());
                  accountController.relayout();
                  Get.offNamed("/home");

                }, (successResponse) {
                  Template.dialogError(successResponse);

                });
              },
              style: Template.primaryButtonStyle,
            ),
          )
        ],
      ),
    );
  }
}
