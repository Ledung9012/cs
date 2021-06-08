

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/account/reset_password/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy Mật Khẩu Mới"),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
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
                buildOTPGroup(),
                buildCreateGroup()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOTPGroup() {
    return Container(
      child: Column(
        children: [
          TextField(
            autocorrect: false,
            decoration: InputDecoration(hintText: "Mã xác nhận"),
            onSubmitted: (value){

            },
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_rounded,
                  size: 18,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "Vui lòng kiểm tra tin nhắn để lấy mã xác nhận tạo mật khẩu",
                    style: TextStyle(color: Template.subColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCreateGroup() {
    return Obx((){
      if(controller.isState(ResetPasswordState.none)) {
        return Container();
      }
      else{
        return Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                child: RichText(
                  text: TextSpan(
                      text: "Tạo mới mật khẩu ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      children: []),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                    autocorrect: false,
                    onSubmitted: (value) {},
                    // controller: controller.nameEditController,
                    decoration: InputDecoration(hintText: "Nhập mật khẩu mới")),
              ),
              Container(
                child: TextField(
                    autocorrect: false,
                    // controller: controller.passwordEditController,

                    onSubmitted: (value) {},
                    decoration: InputDecoration(hintText: "Xác nhận mật khẩu mới")),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  child: Text("Hoàn Tất"),
                  onPressed: () {
                    // controller.register((success)  {
                    //
                    //
                    //
                    // }, (successResponse) {
                    //
                    //   Template.snackError(successResponse);
                    //
                    //
                    // });
                  },
                  style: Template.primaryButtonStyle,
                ),
              )
            ],
          ),
        );
      }
    });
  }
}
