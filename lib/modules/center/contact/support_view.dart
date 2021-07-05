import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/center/contact/support_controller.dart';

class SupportView extends GetView<SupportController> {
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

  Widget item(int index){

       return Column(
      children: [
        Container(
          height: 48,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
            },
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16,right: 16),
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedNetworkImage(
                        imageUrl: controller.item(index).avatar,
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      controller.item(index).name,
                      style: TextStyle(
                          fontSize: 18, color: Template.subColor),
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Divider(
            color: Template.subColor.withOpacity(0.2),
            height: 30,
          ),
        )
      ],
    );

  }

}
