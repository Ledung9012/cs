import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/order/history/order_controller.dart';

class OrderView extends GetView<OrderController> {
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Lịch sử mua hàng"),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.orderLength,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: item(index),
                onTap: () {},
              );
            });
      }),
    );
  }

  Widget item(int index) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                controller.item(index).dateDisplay(),
                style: generalTextStyle,
              ),
              Text(
                controller.item(index).orderName(),
                style: generalTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                  width: 100,
                  child: Text(
                    "Tổng giá trị",
                    style: generalTextStyle,
                  )),
              Container(
                width: 100,
                child: Text(
                  controller.item(index).billingDisplay(),
                  textAlign: TextAlign.right,
                  style: generalTextStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                  width: 100,
                  child: Text(
                    "hoàn tiền",
                    style: generalTextStyle,
                  )),
              Container(
                width: 100,
                child: Text(
                  controller.item(index).commissionDisplay(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Template.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Text(
                  controller.item(index).statusDisplay(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: controller.item(index).statusColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12,bottom: 12),
            height: 1,
            width: double.infinity,
            color: Template.subColor.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}
