import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/modules/account/address/address_add_controller.dart';
import 'package:mobile/modules/account/address/address_add_view.dart';
import 'package:mobile/modules/account/address/address_provider.dart';

class AddressPopupView extends StatefulWidget {
  List<Address> address;

  Function(Address) onComplete ;
  AddressPopupView({required this.address, required this.onComplete});

  @override
  _AddressPopupViewState createState() => _AddressPopupViewState();
}

class _AddressPopupViewState extends State<AddressPopupView> {
  Widget build(BuildContext context) {
    return contentView(acceptBlock: () {}, cancelBlock: () {});
  }

  Widget contentView(
      {required Function acceptBlock, required Function cancelBlock}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    color: Template.primaryColor,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Chọn địa chỉ giao hàng",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    height: 360,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 16, left: 16, bottom: 36, right: 16),
                    child: ListView.builder(
                        itemCount: widget.address.length + 1,
                        itemBuilder: (context, index) {
                          return item(index);
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.black.withOpacity(0.1)))),
                    height: 54,
                    width: double.infinity,
                    child: TextButton(
                      style: Template.primaryButtonSimpleStyle,
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Đóng",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget rowText(String value) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget item(index) {
    if (index == widget.address.length) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.back();
          Get.put(AddressAddController());
          Get.to(AddressAddView(
              addState: AddressAddType.NONE,
              onComplete: (value) {
            widget.onComplete(value);
          }));
        },
        child: Container(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            "Thêm mới",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        widget.onComplete(widget.address[index]);
        Get.back();
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 12),
            width: double.infinity,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        widget.address[index].titleDisplay().toUpperCase(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(widget.address[index].displayDetail())),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
