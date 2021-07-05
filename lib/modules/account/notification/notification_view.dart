import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/notification.dart';
import 'package:mobile/modules/account/notification/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
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
        "Danh sách bài viết",
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
          Expanded(child: Container()),
          // Container(
          //     height: 40,
          //     child: TextButton(
          //       onPressed: () {
          //         controller.create();
          //       },
          //       child: Text("Viết bài"),
          //       style: Template.primaryButtonStyle,
          //     ))
        ],
      ),
    );
  }

  Widget buildContent() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 24),
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.newsLength,
            itemBuilder: (context, index) {
              return productItem(index);
            });
      }),
    ));
  }

  Widget newsItem(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Card(
          margin: EdgeInsets.only(left: 0, right: 0, bottom: 8),
        ),
      ),
    );
  }

  Widget productItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // controller.goDetail(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 12,bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8, top: 6),
                  width: 24, height: 24,
                  child: Center(child: Icon(Icons.create,color: Colors.white,size: 16,)),
                  decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(12)),
                ),
              ],
            ),
            Expanded(
                child: Container(
                  child: itemName(controller.item(index)),
                ))
          ],
        ),
      ),
    );
  }


  Widget itemName(SNotification item ){
    return  RichText(
      textAlign: TextAlign.left,
      text: new TextSpan(


        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          height: 1.48,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Bạn đã mua '),
          new TextSpan(text: item.itemName(), style: new TextStyle(fontWeight: FontWeight.w600,color: Template.primaryTextColor)),
          new TextSpan(text: '. Vui lòng viết bài review sản phẩm này để nhận được ưu đãi tử Save365.'),
        ],
      ),
    );

  }
}
