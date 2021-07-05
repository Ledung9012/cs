import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/news/user/news_user_controller.dart';

class NewsUserView extends GetView<NewsUserController> {
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
          Container(
              height: 40,
              child: TextButton(
                onPressed: () {
                  controller.create();
                },
                child: Text("Viết bài"),
                style: Template.primaryButtonStyle,
              ))
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
      onLongPressEnd: (va) {
        // controller.goCreate(index);
      },
      onTap: () {
        // controller.goDetail(index);
      },
      child: Container(
        padding: EdgeInsets.only(top: 4),
        child: Card(
          child: Container(
            height: 112,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AspectRatio(
                      aspectRatio: 1.24,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: CachedNetworkImage(
                          imageUrl: controller.item(index).imageURL(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 12, right: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.item(index).title,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: ClipRRect(borderRadius: BorderRadius.circular(4) ,child: AspectRatio(aspectRatio: 1.48, child: FittedBox(fit: BoxFit.cover,child: CachedNetworkImage(imageUrl: controller.item(index).imageURL())))),
              ),
              Container(child: Text(controller.item(index).title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),padding: EdgeInsets.only(left: 12,top: 4,bottom: 12))
            ],
          ),

* */
