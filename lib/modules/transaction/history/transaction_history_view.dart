import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/transaction/history/transaction_history_controller.dart';

class TransactionHistoryView extends GetView<TransactionHistoryController> {
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);
  double itemHeight = 48.0;
  double marginField = 16.0;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Lịch sử giao dịch"),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: Obx((){
        return ListView.builder(
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) {
              return item(index);
            });
      }),
    );
  }

  Widget item(int index) {
    return GestureDetector(
      onTap: () {
        // Get.bottomSheet(accesstradeTransactionDetailView(
        //     item: controller.transactions[index]));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(top: 16),
        margin: EdgeInsets.only(left: 16, right: 16),
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
                          child: Text(
                        controller.transactions[index].dateDisplay() +
                            " " +
                            controller.transactions[index].label(),
                        maxLines: 2,
                        style: TextStyle(color: Template.subColor),
                      )),
                      SizedBox(height: 12),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 86,
                              child: Text(
                                controller.transactions[index].typeLabel(),
                                style: TextStyle(color: Template.subColor),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Text(
                                controller.transactions[index].valueDisplay,
                                textAlign: TextAlign.right,
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
                                    color: controller.transactions[index]
                                        .statusColor(),
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
            Container(
              margin: EdgeInsets.only(top: 16),
              color: Colors.black12,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
