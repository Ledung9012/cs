import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/account/address/address_controller.dart';

class AddressView extends GetView<AddressController> {
  Widget build(BuildContext context) {
    List<Widget> item = addButton();
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar("Sổ địa chỉ", child: item),
        body: content(),
      ),
    );
  }

  List<Widget> addButton() {
    return [
      GestureDetector(
        onTap: () {
          controller.goAdd();
        },
        child: Icon(
          Icons.add_rounded,
          size: 28,
        ),
      )
    ];
  }

  Widget content() {
    return Container(
      child: Obx(() {
        return ListView.builder(
            itemCount: controller.address.length,
            itemBuilder: (context, index) {
              return item(index);
            });
      }),
    );
  }

  Widget item(index) {
    return GestureDetector(
      onTap: (){

        controller.detail(index);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 12, left: 16, right: 16),
            width: double.infinity,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(controller.item(index).titleDisplay().toUpperCase(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                  Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(controller.item(index).displayDetail())),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),

        ],
      ),
    );
  }
}
