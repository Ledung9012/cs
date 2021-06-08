import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/store_controller.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: Column(
        children: [buildHeader(), buildContent()],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: Template.primaryColor,
      width: double.infinity,
      height: 108,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 24, left: 12, right: 12),
              height: 108,
              width: double.infinity,
              color: Template.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thương hiệu hoàn tiền",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildCategory()
                ],
              )),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Obx(() {
          return GridView.builder(
            itemCount: controller.siteCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.48,
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemBuilder: (BuildContext context, int index) {
              return buildCell(index);
            },
          );
        }),
      ),
    );
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () {
        controller.detail(index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(width: 1, color: Colors.black12),
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: controller.store(index).imageURL(),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle selectedStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
  TextStyle unSelectedStyle = TextStyle(color: Colors.white54, fontSize: 16);

  Widget buildCategory() {
    return Expanded(
      child: Container(
          width: double.infinity,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryCount,
                itemBuilder: (context, index) {
                  var color = (index != 0) ? Colors.white54 : Colors.white;
                  return Container(
                    padding: EdgeInsets.only(
                      left: 0,
                      right: 12,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.selectIndex(index);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        child: Center(
                            child: Text(
                          controller.item(index).name,
                          style: (index == controller.selectedIndex)
                              ? selectedStyle
                              : unSelectedStyle,
                        )),
                      ),
                    ),
                  );
                });
          })),
    );
  }
}
