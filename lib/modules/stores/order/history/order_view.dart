import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/order/detail/order_detail_view.dart';
import 'package:mobile/modules/stores/order/history/order_controller.dart';

class OrderView extends GetView<OrderController> {
  TextStyle generalTextStyle = TextStyle(color: Template.subColor,fontSize: 16);

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
        "Lịch sử mua hàng",
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
      margin: EdgeInsets.only(top: 24),
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.orderLength,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                },
                child: Container(
                  child: Card(
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 8),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                controller.item(index).dateDisplay(),
                                style: generalTextStyle,
                              ),
                              Text(controller.item(index).orderName(),style: generalTextStyle,),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 100, child: Text("Tổng giá trị",style: generalTextStyle,)),
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
                              Container(width: 100, child: Text("hoàn tiền",style: generalTextStyle,)),
                              Container(
                                width: 100,
                                child: Text(
                                  controller.item(index).commissionDisplay(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Template.primaryColor,fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.item(index).statusDisplay(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: controller.item(index).statusColor(),fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    ));
  }
}
