

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/news/news_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class NewsView extends GetView<NewsController> {
  AutoScrollController _scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (val) {
        if (val.primaryVelocity! < 0) {
          controller.next();
        } else {
          controller.previous();
        }
      },
      child: Container(
        color: Template.backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverStickyHeader(
              header: Container(
                  padding: EdgeInsets.only(top: 24, left: 12, right: 12),
                  height: 60,
                  width: double.infinity,
                  color: Template.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tin Tức",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
            ),
            SliverStickyHeader(
              sticky: true,
              header: buildCategory(),
              sliver: sliverGrid(),
            )
          ],
        ),
      ),
    );
  }

  Widget sliverGrid() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return productItem(index);
          },
          childCount: controller.newsLength ,
        ),
      );
    });
  }

  TextStyle selectedStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
  TextStyle unSelectedStyle = TextStyle(color: Colors.white54, fontSize: 16);

  Widget buildCategory() {
    return Container(
        color: Template.primaryColor,
        height: 48,
        width: double.infinity,
        child: Obx(() {
          return ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoryLength,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 12,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: GestureDetector(
                      onTap: () {
                        print("Selected Category index");

                        controller.selectCategory(index);
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                              controller.categoryIndex(index).name,
                              style: (index == controller.categorySelected)
                                  ? selectedStyle
                                  : unSelectedStyle,
                            )),
                      ),
                    ),
                  ),
                );
              });
        }));
  }

  Widget productItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressEnd: (va) {
        controller.goCreate(index);
      },
      onTap: () {
        controller.goDetail(index);
      },
      child: Container(
        padding: EdgeInsets.only(left: 8,right: 8,top: 4),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 12, right: 12, top: 12,bottom: 12),
                width: double.infinity,
                child: ClipRRect(borderRadius: BorderRadius.circular(4) ,child: AspectRatio(aspectRatio: 1.48, child: FittedBox(fit: BoxFit.cover,child: CachedNetworkImage(imageUrl: controller.newsIndex(index).imageURL())))),
              ),
              Container(child: Text(controller.newsIndex(index).title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),padding: EdgeInsets.only(left: 12,top: 4,bottom: 12))
            ],
          ),
        ),
      ),
    );
  }


  Widget image(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: FittedBox(
          fit: BoxFit.contain,
          child: CachedNetworkImage(
              imageUrl: controller.newsIndex(index).imageURL()),
        ),
      ),
    );
  }
}

