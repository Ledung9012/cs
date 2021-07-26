import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/promotion.dart';
import 'package:mobile/models/store.dart';

class PromotionDetaiView extends GetView {
  Promotion item;

  PromotionDetaiView(this.item);

  @override
  Widget build(BuildContext context) {
    return contentView(acceptBlock: () {}, cancelBlock: () {});
  }

  Widget contentView(
      {required Function acceptBlock, required Function cancelBlock}) {
    return GestureDetector(
      onTap: () {
        print("ount tap");
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
        child: GestureDetector(
          onTap: () {
            print("tap on content ");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        height: 60,
                        child: CachedNetworkImage(
                          imageUrl: item.storeImageURL(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 16, left: 16, bottom: 0, right: 16),
                      ),
                      title(),
                      content(),
                      bottom()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Text(
            item.titleDisplay(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Column(
        children: [
          RichText(
            softWrap: true,
            textAlign: TextAlign.left,
            text: TextSpan(
              text: item.content,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.86),
                  fontSize: 16,
                  height: 1.36),
            ),
          )
        ],
      ),
    );
  }

  Widget bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tooltip(
          message: "ahih",
          height: 24,
          verticalOffset: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
                padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                decoration:
                    BoxDecoration(color: Colors.redAccent.withOpacity(0.1)),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item.discountValue(),
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: 1,
                        color: Colors.white.withOpacity(0.5),
                        height: 24,
                        margin: EdgeInsets.only(left: 12, right: 12),
                      ),
                      Text(
                        item.code.toUpperCase(),
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
              color: Template.primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4)),
          width: 40,
          height: 36,
          child: Icon(
            Icons.storefront_sharp,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
