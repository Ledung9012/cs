import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class CartController extends GetxController {
  var length = cart.products.length.obs;

  StoreProvider _provider = StoreProvider();
  TextEditingController nameEdit = TextEditingController();
  TextEditingController phoneEdit = TextEditingController();
  TextEditingController addressEdit = TextEditingController();


  Product productIndex(int index) => cart.products[index];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    length.value = cart.products.length;
  }

  Product product(int index) {
    return cart.products[index];
  }

  void remove(int index) {
    cart.remove(index);
    length.value = cart.products.length;
    length.refresh();

    if (length.value == 0) {
      Get.back();
    }
  }

  void refresh() {
    length.value = cart.products.length;
  }

  void submit(
      {required Function onSuccess, required Function(String) onFailure}) {
    String name = nameEdit.text;
    String phone = phoneEdit.text;
    String address = addressEdit.text;


    if (name.isEmpty) {
      onFailure("Vui lòng nhập tên người nhận");
      return;
    }

    if (phone.isEmpty) {
      onFailure("Vui lòng nhập số điện thoại người nhận");
      return;
    }

    if (name.isEmpty) {
      onFailure("Vui lòng nhập địa chỉ người nhận");
      return;
    }
    var productJson = cart.products.map((e) {
      return e.toJson();
    });


    OrderCreateRequest request = OrderCreateRequest();
    request.products = jsonEncode(cart.products);
    request.name = name;
    request.phone = phone;
    request.address = address;
    request.userId = 2;


    StoreProvider.orderCreate(
        request: request, success: () {
          onSuccess();
    }, onError: (error) {

      onFailure(error);

    });
  }
}
