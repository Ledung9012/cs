import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/transaction/withdraw/withdraw_controller.dart';

class WithdrawView extends GetView<WithdrawController> {
  TextStyle generalTextStyle = TextStyle(color: Template.subColor, fontSize: 16);

  final Function? onComplete;
  WithdrawView({this.onComplete});

  double itemHeight = 48.0;
  double marginField = 16.0;

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 24, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  buildInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Container(
        margin: EdgeInsets.only(top: 24, bottom: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text("Số dư khả dụng")),
                Obx(() {
                  return Text(
                    controller.transactionSummary.value.available.currencyValue(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Template.primaryColor),
                  );
                })
              ],
            ),
            buildContent()
          ],
        ));
  }


  Widget buildBankList()
  {

    print("bank : ${controller.banks[0].name}");
    var items = controller.banks.map((item) =>  DropdownMenuItem(value: item.id.toString(), child: Text(item.name, style: TextStyle(color: Colors.black),),)).toList();

    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      isExpanded: true,
      style: TextStyle(fontSize: 14, color: Colors.black),
      hint: Text("Vui lòng chọn ngân hàng"),
      onChanged: (value) {
        controller.bankId = value;
        print(value);
      },
      items: items,
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: marginField, top: 24),
          decoration: BoxDecoration(
              border: Border.all(color: Template.subColor),
              borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.only(left: 12, right: 12, top: 0),
          child: Obx((){
            if(controller.banks.length > 0) {
              return buildBankList();
              }
            else{
              return Container();
            }
          }),
        ),
        Container(
            margin: EdgeInsets.only(bottom: marginField),
            height: itemHeight,
            color: Colors.white,
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              controller: controller.textInputNumberController,
              decoration: decor(hintText: "Số tài khoản", label: ""),
            )),
        Container(
            margin: EdgeInsets.only(bottom: marginField),
            height: itemHeight,
            color: Colors.white,
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              controller: controller.textInputOwnerController,
              decoration: decor(hintText: "Tên chủ tài khoản", label: ""),
            )),
        Container(
            margin: EdgeInsets.only(bottom: marginField),
            height: itemHeight,
            color: Colors.white,
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              controller: controller.cashInputOwnerController,
              decoration: decor(hintText: "Số tiền rút", label: ""),
            )),
        buildButton()
      ],
    );
  }

  Widget buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Container(
            height: 40,
            child: TextButton(
              onPressed: () {
                Get.back();
                this.onComplete!();
              },
              child: Text("Quay Lại"),
              style: Template.subButtonStyle,
            ),
          ),
        ),
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: Container(
            height: 40,
            child: TextButton(
              onPressed: () {

                controller.accept((){
                  Template.snackSuccess("Rút tiền thành công");
                }, (error){

                  Template.snackError(error);
                });
              },
              child: Text("Xác Nhân"),
              style: Template.primaryButtonStyle,
            ),
          ),
        )
      ]),
    );
  }

  InputDecoration decor({required String hintText, required String label}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 12),
      hintText: hintText,
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.black.withOpacity(0.2))),
    );
  }

  Widget buildHeader() {
    return Container(
      child: Text(
        "Rút tiền đến tài khoản",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
}
