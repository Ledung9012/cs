import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/account/address/address_add_controller.dart';
import 'package:mobile/modules/account/address/address_add_view.dart';
import 'package:mobile/modules/account/address/address_provider.dart';
import 'package:mobile/modules/stores/cart/address_popup_view.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class CartController extends GetxController {
  TextEditingController couponEdit = TextEditingController();

  var length = cart.products.length.obs;
  var productPrice = 0.0.obs;
  var shippingPrice = 0.0.obs;
  var couponPrice = 0.0.obs;
  var price = cart.sumDisplay().obs;
  var _address = Address().obs;





  bool get isEmptyAddress => _address.value.isEmpty;

  StoreProvider _provider = StoreProvider();

  get address => _address.value;

  set address(value) {
    _address.value = value;
    _address.refresh();
  }


  String addressTitle(){
    return _address.value.titleDisplay();
  }

  void onReady(){

    print("-----------------onReady");
    refresh();
    super.onReady();


  }
  @override
  void onInit() {
    super.onInit();

    refresh();

  }


  Product product(int index) {
    return cart.products[index];
  }

  void remove(int index) {
    cart.remove(index);
    length.value = cart.products.length;
    refresh();
    if (length.value == 0) {
      Get.back();
    }
  }

  void refresh() {
    price.refresh();
    length.value = cart.products.length;
    price.value =  cart.sumDisplay();

  }

  void submit(
      {required Function onSuccess, required Function(String) onFailure}) {
    if (_address.value.isEmpty) {
      Template.dialogError("Vui lòng nhập địa chỉ giao hàng");
      return;
    }

    OrderCreateRequest request = OrderCreateRequest();
    request.products = jsonEncode(cart.products);
    request.name = "name";
    request.phone = "phone";
    request.address = "address";
    request.userId = 2;

    StoreProvider.orderCreate(
        request: request,
        success: () {
          clear();
          onSuccess();
        },
        onError: (error) {
          onFailure(error);
        });
  }

  void clear() {
    _address.value = Address();
    cart.removeAll();
  }

  void goAdd() {
    if (userInstance.logged) {
      getAddress((value) {
        if (value.length == 0) {
          _add();
        } else {
          Get.dialog(AddressPopupView(
            address: value,
            onComplete: (value) {
              _address.value = value;
            },
          ));
        }
      });
    } else {
      _add();
    }
  }

  void _add() {
    Get.put(AddressAddController());
    Get.to(AddressAddView(
        addState: AddressAddType.NONE,
        item: null,
        onComplete: (value) {
          _address.value = value;
        }));
  }

  void getAddress(Function(List<Address>) onSuccess) {
    AddressProvider.user(
        success: (value) => onSuccess(value), onError: (error) {});
  }

  void submitCoupt() {
    Template.dialogError("Mã khuyến mãi không hợp lệ");
  }
}
