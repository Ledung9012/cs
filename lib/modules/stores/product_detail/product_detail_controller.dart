



import 'package:get/get.dart';
import 'package:mobile/models/product.dart';

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

}