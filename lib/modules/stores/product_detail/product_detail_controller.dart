



import 'package:get/get.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/stores/cart/cart_controller.dart';
import 'package:mobile/modules/stores/cart/cart_view.dart';

class ProductDetailController extends GetxController{
  Product? _product ;
  Product get product => _product!;

  void set product(Product value) {
    _product = value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void goCart(){
    var cartItem = Get.put(CartController());
    cartItem.refresh();
    Get.to(CartView());
  }

}