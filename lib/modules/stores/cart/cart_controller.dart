import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/account/address/address_add_controller.dart';
import 'package:mobile/modules/account/address/address_add_view.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class CartController extends GetxController {
  TextEditingController couponEdit = TextEditingController();

  var length = cart.products.length.obs;
  var productPrice = 0.0.obs;
  var shippingPrice = 0.0.obs;
  var couponPrice = 0.0.obs;
  var price = 0.0.obs;
  var _address = Address().obs;

  bool get isEmptyAddress => _address.value.isEmpty;

  StoreProvider _provider = StoreProvider();

  get address => _address.value;

  set address(value) {
    _address.value = value;
    _address.refresh();

    print("address refresh ");
  }

  @override
  void onInit() {
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
    OrderCreateRequest request = OrderCreateRequest();
    request.products = jsonEncode(cart.products);
    request.name = "name";
    request.phone = "phone";
    request.address = "address";
    request.userId = 2;

    StoreProvider.orderCreate(
        request: request,
        success: () {
          onSuccess();
          clear();
        },
        onError: (error) {
          onFailure(error);
        });
  }

  void clear() {}

  void goAdd() {
    Get.put(AddressAddController());

    Get.to(AddressAddView(
        addState: AddressAddType.NONE,
        item: null,
        onComplete: (value) {
          address = value;
        }));
  }

  void submitCoupt() {
    Template.dialogError("Mã khuyến mãi không hợp lệ");
  }
}
