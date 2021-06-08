import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/cart/cart_controller.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';

class CartView extends GetView<CartController> {
  Function compplete;

  CartView(this.compplete);

  InputDecoration inputDecoration(String value) {
    return InputDecoration(
      hintText: value,
      enabledBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: Template.subColor.withOpacity(0.2)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.cyan),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 44, left: 12, right: 12),
              height: 86,
              width: double.infinity,
              color: Template.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giỏ hàng",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: CustomScrollView(
                    slivers: [
                      SliverStickyHeader(
                        header: header("Danh sách sản phẩm"),
                        sliver: sliverList(),
                      ),
                      SliverStickyHeader(
                        header: header("Thông tin người nhận"),
                        sliver: address(),
                      ),
                      SliverStickyHeader(
                        header: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: header("Tổng giá trị"),
                              ),
                            ),
                            Container(
                              child: Text(
                                cart.sumDisplay(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            buildBottom()
          ],
        ),
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
                },
                child: Icon(Icons.arrow_back_rounded),
                style: Template.subButtonStyle,
              )),
          Expanded(child: SizedBox()),
          Container(
              width: 180,
              height: 40,
              child: TextButton(
                onPressed: () {

                  controller.submit(onSuccess: (){}, onFailure: (error){

                    Template.snackError(error);
                  });

                },
                child: Text("Xác nhận đặt hàng"),
                style: Template.primaryButtonStyle,
              ))
        ],
      ),
    );
  }

  Widget address() {
    return SliverList(

      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 68,
                child: TextField(
                  controller: controller.nameEdit,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: inputDecoration("Họ tên"),
                ),
              ),
              Container(
                height: 68,
                child: TextField(
                  controller: controller.phoneEdit,

                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: inputDecoration("Số điện thoại"),
                ),
              ),
              Container(
                height: 68,
                child: TextField(
                  controller: controller.addressEdit,

                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: inputDecoration("Địa chỉ"),
                ),
              ),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget sliverList() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return productItem(index);
          },
          childCount: controller.length.value,
        ),
      );
    });
  }

  Widget productItem(int index) {
    return Container(
      child: Card(
        child: Container(
          height: 102,
          padding: EdgeInsets.only(top: 12, bottom: 12, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(),
                width: 112,
                height: 86,
                child: CachedNetworkImage(
                  imageUrl: controller.product(index).imageURL(),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          controller.product(index).name,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                controller.product(index).priceDisplay(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                print("remove");
                                controller.remove(index);
                              },
                              child: Container(
                                width: 40,
                                child: Icon(
                                  Icons.clear,
                                  color: Template.subColor,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String value) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Text(
        value,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
