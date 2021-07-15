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
  TextStyle generalTextStyle =
      TextStyle(color: Template.subColor, fontSize: 16);
  double itemHeight = 48.0;
  double marginField = 16.0;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Ví hoàn tiền"),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        children: [sumary(), menu()],
      ),
    );
  }

  Widget menu() {
    return Container(
        margin: EdgeInsets.only( top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                controller.goHistory();
              },
              child: menuItem("Lịch sử giao dịch",
                  Icon(Icons.history_rounded, color: Colors.white), Colors.red[400]!),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,

              onTap: (){

                controller.goWithdraw();
              },
              child: menuItem("Rút tiền",
                  Icon(Icons.money_outlined, color: Colors.white), Colors.green[400]!),
            ),
            menuItem(
                "Nhiệm vụ",
                Icon(Icons.assignment_outlined, color: Colors.white),
                Colors.purple[400]!),
          ],
        ));
  }

  Widget menuItem(String title, Icon icon, Color colr) {
    return Container(
      width: 68,
      height: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              decoration: BoxDecoration(color: colr),
              width: 48,
              height: 48,
              child: Center(
                child: icon,
              ),
            ),
          ),
          Flexible(
              child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ))
        ],
      ),
    );
  }

  TextStyle subTextStyle = TextStyle(
      color: Template.subColor, fontSize: 16, fontWeight: FontWeight.w500);

  Widget sumary() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 148,
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
                    style: subTextStyle,
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
                  Expanded(child: Text("Tiền hoàn trả ", style: subTextStyle)),
                  Text(controller.cashback)
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Tiền tiền đã rút", style: subTextStyle)),
                  Text(controller.withdraw)
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
