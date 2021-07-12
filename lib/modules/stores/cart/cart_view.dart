import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/modules/stores/cart/address_popup_view.dart';
import 'package:mobile/modules/stores/cart/cart_controller.dart';

class CartView extends GetView<CartController> {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back_ios_rounded)),
              SizedBox(
                width: 12,
              ),
              Text("Giỏ hàng".capitalize!),
            ],
          ),
        ),
        body: content(),
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.black.withOpacity(0.06),
        child: Column(
          children: [
            Obx(() => (controller.isEmptyAddress) ? addressNone() : address()),
            sizeBox(),
            product(),
            sizeBox(),
            coupon(),
            sizeBox(),
            payment(),
            sizeBox(),
            summary(),
            sizeBox(),
            acceptView()
          ],
        ),
      ),
    );
  }

  Widget acceptView() {
    return Container(
      width: double.infinity,
      color: Template.primaryColor,
      height: 48,
      child: TextButton(
        onPressed: () {
          controller.submit(
              onSuccess: () {
                Template.dialogInfoAction("Đặt hàng thành công", () {
                  Get.back();
                });
              },
              onFailure: (value) {});
        },
        child: Text(
          "Xác Nhận",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget sizeBox() {
    return SizedBox(
      height: 8,
    );
  }

  Widget coupon() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.wallet_giftcard_outlined,
                    color: Colors.redAccent,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Mã khuyến mãi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 80,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      controller.submitCoupt();
                    },
                    child: Text("Áp dụng"),
                    style: Template.primaryButtonStyle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget payment() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.payments_rounded,
                    color: Colors.redAccent,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Phương thức thanh toán",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    height: 40,
                    child: Text("Giao hàng thu tiền tận nơi - COD"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget summary() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Template.primaryColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Xác nhận đơn hàng",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text("Giá trị sản phẩm "),
                  ),
                ),
                Container(
                  child: Obx(() {
                    return Text(controller.price.value);
                  }),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text("Khuyến mãi "),
                  ),
                ),
                Container(
                  child: Text("- vnđ"),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text("Phí vận chuyển"),
                  ),
                ),
                Container(
                  child: Text("- vnđ"),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text("Tổng tiền thanh toán"),
                  ),
                ),
                Container(
                  child: Obx(() {
                    return Text(controller.price.value);
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget address() {
    return GestureDetector(
      onTap: () {
        controller.goAdd();
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.location_on_rounded,
                      color: Colors.redAccent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.addressTitle(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.more_vert_outlined)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      controller.address.displayDetail(),
                      style: TextStyle(fontSize: 14, color: Template.subColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addressNone() {
    return GestureDetector(
      onTap: () {
        controller.goAdd();
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.location_on_rounded,
                      color: Colors.redAccent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Tuỳ chọn địa chỉ giao hàng",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.navigate_next_rounded)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget product() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.shopping_basket_rounded,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  "Sản phẩm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 8),
            child: Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: true,
                  itemCount: controller.length.value,
                  itemBuilder: (context, index) {
                    return item(index);
                  });
            }),
          )
        ],
      ),
    );
  }

  Widget item(index) {
    return Column(
      children: [
        Container(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        ),
        Container(
          margin: EdgeInsets.only(top: 4, bottom: 4),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedNetworkImage(
                        imageUrl: controller.product(index).imageURL(),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(controller.product(index).name)),
                      Row(
                        children: [
                          Text(
                            controller.product(index).priceDisplay(),
                            style: TextStyle(
                                height: 2, fontWeight: FontWeight.w500),
                          ),
                          Expanded(child: SizedBox()),
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    Template.dialogInfoList(
                                        "Bạn có muốn xoá sản phẩm khỏi giỏ hàng không",
                                        ["Đóng", "Xoá"], (val) {
                                      if (val == 1) {
                                        controller.remove(index);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.black.withOpacity(0.24),
                                  )))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
