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
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar(
          "Trung tâm thông báo",
        ),
        body: buildContent(),
      ),
    );
  }


  Widget buildContent() {
    return Container(
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.newsLength,
            itemBuilder: (context, index) {
              return productItem(index);
            });
      }),
    );
  }

  Widget productItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // controller.goDetail(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 12),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12, top: 6),
                        width: 24,
                        height: 24,
                        child: Center(
                            child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 12,
                        )),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12)),
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
            Container(margin: EdgeInsets.only(left: 36 , top: 12), height: 1,width: double.infinity,color: Template.subColor.withOpacity(0.1),)
          ],
        ),
      ),
    );
  }

  Widget itemName(SNotification item) {
    return RichText(
      textAlign: TextAlign.left,
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          height: 1.48,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Bạn đã mua '),
          new TextSpan(
              text: item.itemName(),
              style: new TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Template.primaryTextColor)),
          new TextSpan(
              text:
                  '. Vui lòng viết bài review sản phẩm này để nhận được ưu đãi tử Save365.'),
        ],
      ),
    );
  }
}
