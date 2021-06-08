import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/transaction/transaction_controller.dart';
import 'package:mobile/modules/transaction/withdraw/withdraw_controller.dart';
import 'package:mobile/modules/transaction/withdraw/withdraw_view.dart';

class TransactionView extends GetView<TransactionController> {
  final itemHeight = 44.0;

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
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

  Widget buildContent() {
    return Expanded(
        child: CustomScrollView(
      slivers: [summary(), history()],
    ));
  }

  Widget summary() {
    return SliverStickyHeader(
      header: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.white),
        child: Text(
          "Thông tin tài khoản",
          style: Template.headerStyle,
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return buildInfoContent();
          },
          childCount: 1,
        ),
      ),
    );
  }

  Widget history() {
    return SliverStickyHeader(
      header: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.white),
        child: Text(
          "Lịch sử giao dịch",
          style: Template.headerStyle,
        ),
      ),
      sliver: Obx(() {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return buildHistoryContent(index);
            },
            childCount: controller.transactions.length,
          ),
        );
      }),
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
          Expanded(child: Container()),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {

              print("Go to Withdraw");

              Get.lazyPut<WithdrawController>(() => WithdrawController(complete: (){
                controller.summary();
                controller.history();
              }));
              var view = WithdrawView();
              Get.to(view);
            },
            child: Container(
              width: 48,
              height: 40,
              child: Center(
                child: SvgPicture.asset('assets/images/ic_withdrawal.svg',
                    width: 28, height: 28, color: Colors.green),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildInfoContent() {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0, bottom: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.green[50],
        ),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Tổng tiền khả dụng",
                  )),
                  Text(
                    controller.available,
                    style: TextStyle(
                        color: Template.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text("Tiền hoàn trả ")),
                  Text(controller.cashback)
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text("Tiền tiền đã rút")),
                  Text(controller.withdraw)
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildHistoryContent(int index) {
    return GestureDetector(
      onTap: () {
        // Get.bottomSheet(accesstradeTransactionDetailView(
        //     item: controller.transactions[index]));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        margin: EdgeInsets.only(left: 0, right: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(controller.transactions[index].dateDisplay() + " " + controller.transactions[index].label(),
                            maxLines: 2,style: TextStyle(color: Template.subColor),
                          )),


                      SizedBox(height: 12),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 86,
                              child: Text(
                                controller.transactions[index].typeLabel(),
                                style: TextStyle(
                                    color: Template.subColor),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Text(
                                controller.transactions[index].valueDisplay,textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: controller.transactions[index]
                                        .labelColor()),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              child: Text(
                                controller.transactions[index].statusLabel(),
                                style: TextStyle(
                                    color: controller.transactions[index].statusColor(),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              child:
                              controller.transactions[index].statusIcon(18),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }


}
