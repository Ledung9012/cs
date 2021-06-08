import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng Nhập"),
        backgroundColor: PrimaryColor,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 24, right: 24, bottom: 12),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: TextField(
                  autocorrect: false,
                  controller: controller.phoneEditController,
                  onSubmitted: (value) {
                    // EasyLoading.show(maskType: EasyLoadingMaskType.black);

                    controller.submitPhone(value, onSuccess: () {
                      EasyLoading.dismiss();
                    }, onFailure: (error) {
                      EasyLoading.dismiss();
                      Template.snackError(error);
                    });
                  },
                  onChanged: (value) {
                    controller.onChangePhone();
                  },
                  decoration:
                  InputDecoration(hintText: "Nhập số điện thoại của bạn")),
            ),
            buildContent(),
          ],
        ),
      ),
    );
  }

  void login() {
    EasyLoading.show();
    controller.logon(
        controller.phoneEditController.text, controller.passwordController.text,
        onFailure: (error) {
          EasyLoading.dismiss();
          Template.snackError(error);
        }, onSuccess: () {
      Get.back();
      Template.snackSuccess("Đăng nhập thành công. ");
      EasyLoading.dismiss();
    });
  }

  Widget buildGroupRegister() {
    return Container(
      child: Column(
        children: [
          TextField(
            autocorrect: false,
            controller: controller.authenticationCodeController,
            decoration: InputDecoration(hintText: "Mã xác nhận"),
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
                    "Bạn chưa có tài khoản. Vui lòng kiểm tra tin nhắn để lấy mã xác nhận tạo mới tài khoản",
                    style: TextStyle(color: TemplateInstance().subColor),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              child: Text("Đăng Ký"),
              onPressed: () {
                controller.confirmVirificationCode(
                    controller.authenticationCodeController.text, () {},
                        (error) {
                      Template.snackError(error);
                    });
              },
              style: TemplateInstance().elevantedPrimaryButtonStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    return Obx(() {
      if (controller.isState(LoginState.none)) {
        return Container();
      }

      if (controller.isState(LoginState.alreadyRegister)) {
        return buildLoginGroup();
      }

      if (controller.isState(LoginState.preRegister)) {
        return buildGroupRegister();
      }

      return Container();
    });
  }

  Widget buildLoginGroup() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          TextField(
            obscureText: true,
            autocorrect: false,
            controller: controller.passwordController,
            decoration: InputDecoration(
              hintText: "Mật khẩu",
            ),
            onSubmitted: (value) {
              login();
            },
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_rounded,
                  size: 18,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Nếu bạn quên mật khẩu, vui lòng nhấn vào ",
                            style:
                            TextStyle(color: TemplateInstance().subColor)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.goFogotPass();
                              },
                            text: "đây ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: "để lấy mật khẩu mới",
                            style:
                            TextStyle(color: TemplateInstance().subColor)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              child: Text("Đăng Nhập"),
              onPressed: () {
                login();
              },
              style: TemplateInstance().elevantedPrimaryButtonStyle,
            ),
          )
        ],
      ),
    );
  }
}
