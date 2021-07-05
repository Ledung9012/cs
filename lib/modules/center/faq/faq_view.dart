import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/center/faq/faq_controller.dart';

class FAQView extends GetView<FaqController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Container(
      child: Obx(() {
        return Container(
          child: ListView.builder(
              itemCount: controller.userLength,
              itemBuilder: (context, index) {
                return item(index);
              }),
        );
      }),
    );
  }

  Widget item(int index) {
    return Container(
      width: double.infinity,
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 12),
        iconColor: Colors.white.withOpacity(0),
        collapsedIconColor: Colors.white.withOpacity(0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 2,right: 6),
              child: Center(child: Text((index+ 1).toString(),style: TextStyle(color: Colors.white,fontSize: 10),),),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: Template.primaryColor,
                  borderRadius: BorderRadius.circular(9)),
            ),
            Flexible(
                child: Text(
              controller.item(index).title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
          ],
        ),
        children: [
          Container(
              margin: EdgeInsets.only(left: 36, right: 16, bottom: 16),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: controller.item(index).content,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 16,
                      height: 1.24),
                ),
              ))
        ],
      ),
    );
  }
}
