import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/news/user/news_user_controller.dart';

class NewsUserView extends GetView<NewsUserController> {
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);



  Widget build(BuildContext context) {

    Widget addButton = GestureDetector(
        onTap: () {
          controller.create();
        },
        child: Icon(
          Icons.post_add_rounded,
          size: 24,
        ));

    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Quản lý bài viết",child:[addButton] ),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.newsLength,
            itemBuilder: (context, index) {
              return item(index);
            });
      }),
    );
  }

  Widget item(int index) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 86,
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
              Flexible(
                  child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  controller.item(index).title,
                  style: TextStyle(fontSize: 16, height: 1.24),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 1,
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}
