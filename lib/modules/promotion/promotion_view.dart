import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/promotion.dart';
import 'package:mobile/modules/account/login/login_controller.dart';
import 'package:mobile/modules/account/login/login_view.dart';
import 'package:mobile/modules/promotion/detail/promotion_detail_view.dart';
import 'package:mobile/modules/promotion/promotion_controller.dart';
import 'package:mobile/modules/stores/store_controller.dart';
import 'package:mobile/modules/stores/store_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PromotionView extends GetView<PromotionController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return DefaultTabController(
          length: controller.storeLength,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  Template.sliderAppBar(
                      menu: [],
                      title: "MÃ GIÃM GIÁ",
                      items:
                          controller.stores.map((item) => item.name).toList())
                ];
              },
              body: TabBarView(
                children: controller.stores
                    .map((item) => ItemView(controller.promotions))
                    .toList(),
              ),
            ),
          ),
        );
      }),
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
                itemCount: controller.storeLength,
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

  Widget tabItem(String value) {
    return Container(margin: EdgeInsets.only(bottom: 12), child: Text(value));
  }
}

class ItemView extends StatefulWidget {
  var promotions = [];

  ItemView(this.promotions);

  @override
  _State createState() => _State();
}

class _State extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: widget.promotions.length,
        itemBuilder: (context, index) {
          return buildCell(index);
        });
  }

  @override
  void initState() {
    super.initState();
  }

  Promotion item(int index) {
    return widget.promotions[index];
  }

  void _launchURL(url) async {
    print("GO TO LINK : $url");
    launch(url, forceSafariVC: false);
  }

  Widget buildCell(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){


        Get.dialog(PromotionDetaiView(item(index)));



      },
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Card(
            child: Container(
              padding: EdgeInsets.only(right: 16, top: 16, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logoView(index),
                  contentView(index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logoView(int index) {
    return Container(
      width: 68,
      child: CachedNetworkImage(
        imageUrl: item(index).storeImageURL(),
      ),
    );
  }

  Widget priceView(int index) {
    return Container(
      width: 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item(index).discountValue(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget contentView(int index) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item(index).titleDisplay(),
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
            child: Text(
          item(index).content,
          maxLines: 3,
          style: TextStyle(color: Template.subColor),
        )),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                  decoration:
                      BoxDecoration(color: Colors.redAccent.withOpacity(0.1)),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item(index).discountValue(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: 1,
                          color: Colors.white.withOpacity(0.5),
                          height: 24,
                          margin: EdgeInsets.only(left: 12, right: 12),
                        ),
                        Text(
                          item(index).code.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    ));
  }
}
