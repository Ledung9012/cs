import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/order/detail/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
        "Thông tin đơn hàng",
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
        ],
      ),
    );
  }

  Widget buildContent() {
    return Expanded(
        child: Container(
      child: CustomScrollView(
        slivers: [
          orderInfo(),
          products()
        ],
      ),
    ));
  }

  Widget orderInfo() {
    return SliverStickyHeader(
      header: Container(
        padding: EdgeInsets.only(top: 0, bottom: 8),
        color: Colors.white,
        child: Text(
          "Thông tin đơn hàng",
          style: Template.headerStyle,
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 12, bottom: 24),
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Template.primaryColor.withOpacity(0.1)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, bottom: 12),
                    child: Row(children: [
                      Expanded(child: Text("Tổng giá trị đơn hàng")),
                      Text("120.000"),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(child: Text("Tiền hoàn lại")),
                        Text("120.000"),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

  Widget products() {
    return SliverStickyHeader(
      header: Container(
        padding: EdgeInsets.only(top: 0, bottom: 8),
        color: Colors.white,
        child: Text(
          "Danh sách sản phẩm",
          style: Template.headerStyle,
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 12),
              padding:
              EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Template.primaryColor.withOpacity(0.1)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, bottom: 12),
                    child: Row(children: [
                      Expanded(child: Text("Tổng giá trị đơn hàng")),
                      Text("120.000"),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(child: Text("Tiền hoàn lại")),
                        Text("120.000"),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

}
