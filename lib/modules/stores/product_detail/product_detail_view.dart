import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';
import 'package:mobile/modules/stores/product_detail/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  Function? complete;

  ProductDetailView({required this.complete});

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: [
                      buildImage(context),
                      buildDescription(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildBottom()
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        padding: EdgeInsets.all(32),
        height: width,
        decoration: BoxDecoration(color: Colors.white),
        child: CachedNetworkImage(
          imageUrl: controller.product.imageURL(),
        ),
      ),
    );
  }

  Widget buildDescription() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    controller.product.name,
                    style: Template.headerStyle,
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 12),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: controller.product.description,
                  style: TextStyle(
                    color: Template.subColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
              width: 40,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Get.back();
                  complete!();
                },
                child: Icon(Icons.arrow_back_rounded),
                style: Template.backButtonStyle,
              )),
          Expanded(child: SizedBox()),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  controller.product.priceDisplay(),
                  style: TextStyle(
                      color: Template.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  controller.product.originalPriceDisplay(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Template.subColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          Container(
              height: 40,
              child: TextButton(
                onPressed: () {
                  print("-------${controller.product}");
                  cart.add(controller.product);

                  Template.dialogInfoList("Đã thêm sản phẩm vào giỏ hàng",
                      ["Tiếp tục mua hàng", "Thanh Toán"], (p0) {
                    if (p0 == 1) {
                      controller.goCart();
                    }
                  });
                },
                child: Text("Mua hàng"),
                style: Template.primaryButtonStyle,
              ))
        ],
      ),
    );
  }
}
