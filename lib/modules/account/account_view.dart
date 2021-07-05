import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/account/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: getView(),
    );
  }

  Widget getView() {
    return Obx(() {
      if (controller.alreadyLogin.value) {
        return Column(
          children: [buildHeader(), buildNavigator()],
        );
      } else {
        return Container(
          child: Center(
            child: Container(
              height: 48,
              width: 240,
              child: TextButton(
                style: Template.primaryButtonStyle,
                onPressed: () {
                  controller.logon();
                },
                child: Text("Đăng ký / Đăng nhập"),
              ),
            ),
          ),
        );
      }
    });
  }

  Future getImage() async {
    print('No image selected.');
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.uploadImage(pickedFile);
    } else {
      print('No image selected.');
    }
  }

  Widget buildHeader() {
    return Container(
      color: Template.primaryColor,
      height: 112,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Colors.white,
            ),
            width: 68,
            height: 68,
            margin: EdgeInsets.only(top: 24, left: 16),
            padding: EdgeInsets.all(2),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(33),
                child: Container(
                  color: Colors.red,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap:getImage,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Obx((){
                        return CachedNetworkImage(imageUrl: controller.image.value);
                      }),
                    ),
                   ),
                )),
          ),
          Container(
            width: 240,
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Text(
                    controller.name.value,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white),
                  );
                }),
                Text(
                  "Thành viên phổ thông",
                  style: TextStyle(
                      fontSize: 14, height: 1.5, color: Colors.white60),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildNavigator() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.only(left: 16),
        child: ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 40,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.select(index);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              controller.items[index].image,
                              width: 48,
                              height: 48,
                              color: HexColor.fromHex(
                                  controller.items[index].color),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                controller.items[index].name,
                                style: TextStyle(
                                    fontSize: 18, color: Template.subColor),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Template.subColor.withOpacity(0.2),
                    height: 30,
                  )
                ],
              );
            }),
      ),
    );
  }
}
